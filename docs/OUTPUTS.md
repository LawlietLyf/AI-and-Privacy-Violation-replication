# Original-style outputs

No generated file is included in this release. Scripts create their own outputs when run. Output directories can be overwritten by the original scripts; choose a separate directory per model/run. There is no universal run-ID, settings fingerprint, checkpoint database or automatic resume interface.

| Scripts | Output |
|---|---|
| Public baselines | synthetic_users.csv, raw_model_calls.jsonl, collection/processing/dissemination_results.csv |
| Public RCT | shock/pair_NNN_pre.csv, pair_NNN_control_post.csv, pair_NNN_treatment_post.csv, paired_runs.jsonl |
| Travel / car / XXX | Original consumer_sample.csv and scores_*.csv under CONFIG paths |
| No-private | Generated sample and small sample/Round 1/scores_round1.csv |
| Self-assessment | small sample/Round 1/scores_round1.csv, criteria_round1.txt, self_reported_privacy_round1.txt |
| Dynamic | bootstrap_N/consumer_sample_bootstrap_N.csv, scores_round1.csv and good/bad/normal_scores_round2..4.csv |
| CoT | Per-agent treatment/control folders with original scores_year_bonus.csv name, year*_temp.txt and messages.txt |
| Privacy preference | results.csv with bonus, punish, score (raw answer) |
| 60-month extension | Per-shock/pair monthNN_arm.csv, .calls.jsonl, .feedback.json |

Local project `score` columns preserve raw response strings. Exhausted retries return the original `Error` marker, not zero. CoT additionally saves parsed_score and thought_process; invalid JSON or out-of-range scores produce missing parsed values. Public scripts retain their upstream single-number parser, raw records and source-specific error handling; exception bodies are replaced by type names to avoid credential disclosure. RCT additionally saves raw responses in stage CSVs.

Dynamic feedback reads the prior CSV and excludes nonnumeric/out-of-range predictions; the original prediction file remains unchanged. Self-assessment text concerns the preceding batch of predictions and is saved without invented boolean coding. The legacy filename scores_year_bonus.csv remains in CoT for source fidelity, although its intervention is now the paper's policy shock.

Original Python analysis scripts are unvalidated and may require adaptation to source-specific output columns. No statistical analysis is run as part of acceptance testing.
