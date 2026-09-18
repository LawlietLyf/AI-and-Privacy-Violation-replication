# Source-based revision validation

Validated on 18 September 2026. This report supersedes the previous reconstructed-package reports. No live API or paid inference experiment was run.

## Source comparison

Seven original project sample generators were compared structurally using Python AST, excluding only the generated CSV export/directory creation. Travel, car, XXX rename, self-assessment, dynamic, no-private and CoT generators match the original functions, including random draw order. All nine project-derived scripts retain the original SDK chat-completion call expressions and arguments. Credentials, endpoint/deployment values and local paths are externalized separately.

The three public baselines, public RCT and their two helpers were restored from the recorded GitHub commit. Necessary differences are listed file by file in SOURCE_CHANGES.md. That ledger identifies original source hashes and distinguishes a manuscript correction from an unchanged source choice or an unresolved source discrepancy.

## Clean-extracted checks

An allowlisted source ZIP was extracted into a fresh directory. A new Python 3.11.5 environment installed the unchanged requirements: OpenAI 3.15.0, Faker 40.39.0, NumPy 2.4.6, pandas 3.0.6 and pytest 9.1.1 among the resolved dependencies.

- `python -m pytest tests -q -p no:cacheprovider`: **26 passed**, 5.02 seconds.
- `python tools/smoke_test.py`, run against the extracted package from a temporary working directory: **17 scenarios passed**, 2.34 seconds. These cover all 14 scripts and all four public RCT shocks.
- Network connections are blocked by the tests. SDK substitutes and reduced counts live in tests only; production scripts have no added offline or resume mechanism.
- Tests cover original bracketed input/session shapes, RCT shared history and identical post samples, original CoT JSON parsing and policy acknowledgement, batch self-assessment, all four dynamic rounds, non-predictive substitution, monthly reset/branch timing/annual counts/summaries, numeric parsing and exception-body suppression.

The 60-month command is tested at reduced test-side sizes. Annual allocation and summary behavior are checked separately. A full online run is not performed; the 900,000 calls per policy are a design count, not observed runtime or cost. Automatic interrupted-run recovery is not claimed: the new checkpoint framework was removed to preserve source workflow.

## Release scans

The explicit allowlist contains **52 files**. Source and ZIP scans report zero findings; archive membership and CRC checks pass. An additional in-memory comparison against credential literals in original project Python files found no matches. No secret values were printed. The final archive contains the same code, tests and prompts as the clean-tested archive; only this report and its manifest change at final packaging.

No generated samples, model responses, experiment logs, notebooks, weights, dataset files or bytecode caches are distributed. The model-registry CSV is configuration metadata. Source hashes are not data. Original project scripts, paper and datasets were not modified.

## Limits

Offline execution establishes neither live provider compatibility nor agreement with paper results. Historical deployment IDs and outputs remain unverified. Original lognormal privacy-preference draws conflict with the SI's stated bounded range; the main-text non-predictive substitution lacks an exact matching source script. Both are explicitly documented, not hidden behind invented defaults. Upstream analysis scripts remain outside this validation workflow.
