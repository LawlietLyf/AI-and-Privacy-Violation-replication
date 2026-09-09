from __future__ import annotations

import argparse
from pathlib import Path

import pandas as pd

from compute_baseline_metrics import processing_ols


def beta(path: Path, controls: str) -> float:
    value, _, _, _, _ = processing_ols(pd.read_csv(path), controls)
    return value


def main() -> None:
    p = argparse.ArgumentParser(description="Estimate pair-level processing-score DID from an RCT output directory.")
    p.add_argument("--rct-dir", required=True)
    p.add_argument(
        "--processing-controls",
        default=" + age + C(gender) + C(race) + C(highest_degree) + income",
    )
    p.add_argument("--output", default="rct_pair_did.csv")
    args = p.parse_args()

    d = Path(args.rct_dir)
    pairs = sorted(d.glob("pair_*_pre.csv"))
    rows = []
    for pre_path in pairs:
        pair = pre_path.stem.split("_")[1]
        c_path = d / f"pair_{pair}_control_post.csv"
        t_path = d / f"pair_{pair}_treatment_post.csv"
        b_pre = beta(pre_path, args.processing_controls)
        b_c = beta(c_path, args.processing_controls)
        b_t = beta(t_path, args.processing_controls)
        did = (b_t - b_pre) - (b_c - b_pre)
        rows.append({"pair_id": int(pair), "pre_beta_pp": b_pre, "control_post_beta_pp": b_c, "treatment_post_beta_pp": b_t, "did_pp": did})

    pd.DataFrame(rows).to_csv(args.output, index=False)
    print(args.output)


if __name__ == "__main__":
    main()
