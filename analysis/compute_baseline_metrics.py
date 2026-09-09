from __future__ import annotations

import argparse
from pathlib import Path

import numpy as np
import pandas as pd
import statsmodels.formula.api as smf
from statsmodels.stats.proportion import proportion_confint


def wilson_pct(series: pd.Series) -> tuple[float, float, float, int]:
    x = pd.to_numeric(series, errors="coerce").dropna().astype(int)
    n = len(x)
    if n == 0:
        return np.nan, np.nan, np.nan, 0
    k = int(x.sum())
    lo, hi = proportion_confint(k, n, alpha=0.05, method="wilson")
    return 100 * k / n, 100 * lo, 100 * hi, n


def processing_ols(df: pd.DataFrame, controls: str):
    d = df.copy()
    d = d.dropna(subset=["purchase", "targeted_top30"])
    # Default controls are a conservative reconstruction from the non-sensitive profile fields.
    # The final archival package should replace this string with the exact historical specification.
    formula = f"purchase ~ targeted_top30{controls}"
    model = smf.ols(formula, data=d).fit(cov_type="HC1")
    beta = float(model.params["targeted_top30"])
    ci = model.conf_int().loc["targeted_top30"].tolist()
    return 100 * beta, 100 * ci[0], 100 * ci[1], int(model.nobs), formula


def main() -> None:
    p = argparse.ArgumentParser()
    p.add_argument("--collection", default=None)
    p.add_argument("--processing", default=None)
    p.add_argument("--dissemination", default=None)
    p.add_argument(
        "--processing-controls",
        default=" + age + C(gender) + C(race) + C(highest_degree) + income",
        help="Provisional non-sensitive control specification; freeze exact historical formula before archival release.",
    )
    p.add_argument("--output", default="baseline_metrics.csv")
    args = p.parse_args()

    rows = []
    if args.collection:
        score, lo, hi, n = wilson_pct(pd.read_csv(args.collection)["violation"])
        rows.append({"test": "Information Collection", "violation_score": score, "ci_lower": lo, "ci_upper": hi, "n": n})
    if args.processing:
        score, lo, hi, n, formula = processing_ols(pd.read_csv(args.processing), args.processing_controls)
        rows.append({"test": "Information Processing", "violation_score": score, "ci_lower": lo, "ci_upper": hi, "n": n, "formula": formula})
    if args.dissemination:
        score, lo, hi, n = wilson_pct(pd.read_csv(args.dissemination)["violation"])
        rows.append({"test": "Information Dissemination", "violation_score": score, "ci_lower": lo, "ci_upper": hi, "n": n})

    pd.DataFrame(rows).to_csv(args.output, index=False)
    print(args.output)


if __name__ == "__main__":
    main()
