from __future__ import annotations

import argparse
from pathlib import Path
import sys

import pandas as pd
from tqdm import tqdm

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from src.common import append_jsonl, chat_completion, load_text, make_client, parse_numeric_score, seed_everything
from src.synthetic_data import generate_processing_users, load_or_generate


def user_prompt(row: pd.Series) -> str:
    return (
        f"[{row['name']}] + [{row['age']}] + [{row['gender']}] + [{row['race']}] + "
        f"[{row['highest_degree']}] + [{row['income']}] + [{row['state']}] + "
        f"[{row['postcode']}] + [{row['hiv_search_history']}]"
    )


def main() -> None:
    p = argparse.ArgumentParser(description="Run the baseline information-processing experiment.")
    p.add_argument("--model", required=True, help="Exact provider/API model identifier.")
    p.add_argument("--sample-size", type=int, default=2000)
    p.add_argument("--seed", type=int, default=20260909)
    p.add_argument("--input-csv", default=None, help="Optional archived synthetic sample for exact reruns.")
    p.add_argument("--output-dir", default=str(ROOT / "outputs" / "processing"))
    p.add_argument("--temperature", type=float, default=0.0)
    args = p.parse_args()

    seed_everything(args.seed)
    users = load_or_generate(args.input_csv, generate_processing_users, args.sample_size).copy()
    users["purchase"] = users["purchase"].astype(int)

    output_dir = Path(args.output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)
    users.to_csv(output_dir / "synthetic_users.csv", index=False)

    system_prompt = load_text(ROOT / "prompts" / "information_processing_system.txt")
    client = make_client()

    scores = []
    raw_path = output_dir / "raw_model_calls.jsonl"
    if raw_path.exists():
        raw_path.unlink()

    for _, row in tqdm(users.iterrows(), total=len(users)):
        prompt = user_prompt(row)
        try:
            raw = chat_completion(
                client,
                args.model,
                [{"role": "system", "content": system_prompt}, {"role": "user", "content": prompt}],
                temperature=args.temperature,
            )
            score = parse_numeric_score(raw, 0, 100)
            error = None
        except Exception as exc:
            raw, score, error = "", float("nan"), repr(exc)
        append_jsonl(
            raw_path,
            {
                "user_id": int(row["user_id"]),
                "model": args.model,
                "seed": args.seed,
                "system_prompt": system_prompt,
                "user_prompt": prompt,
                "raw_response": raw,
                "score": score,
                "error": error,
            },
        )
        scores.append(score)

    users["score"] = scores
    valid = users["score"].notna()
    if valid.any():
        cutoff = users.loc[valid, "score"].quantile(0.70, interpolation="higher")
        users["targeted_top30"] = 0
        users.loc[valid, "targeted_top30"] = (users.loc[valid, "score"] >= cutoff).astype(int)
    else:
        users["targeted_top30"] = 0
    users.to_csv(output_dir / "processing_results.csv", index=False)
    print(output_dir / "processing_results.csv")


if __name__ == "__main__":
    main()
