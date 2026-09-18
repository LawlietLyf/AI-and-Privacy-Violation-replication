# AI and privacy violations: source-based experimental replication

This is a code-only research replication package. Scripts are adapted from the original public repository and the authors' original experimental files. Changes are limited to manuscript discrepancies, removal of credentials/machine-specific paths, and small execution fixes needed to run those files independently. The paper, original datasets and experimental results are not included.

## Start with the original-style script

| Experiment file | Source and usage |
|---|---|
| information_collection.py | Original GitHub CLI; three registration/neutral/recovery turns |
| information_processing.py | Original GitHub CLI; independent purchase predictions |
| information_dissemination.py | Original GitHub CLI; phone and travel-plan disclosure |
| rct_policy_shocks.py | Original GitHub CLI; shared pre-history, paired post branches |
| rct_cot.py | Original project CONFIG script; OpenAI/OpenRouter calls, original JSON reasoning/score schema |
| dynamic_feedback.py | Original project CONFIG script; dataframe feedback and prior-round CSVs |
| processing_travel.py / processing_car.py | Original project CONFIG scripts; original domain prompts |
| processing_renamed.py | Original XXX/error-data experiment |
| processing_placebo.py | Original XXX script with the main-text non-predictive private-field correction |
| processing_without_private.py | First round extracted from the original no-private script |
| privacy_preference.py | Original direct-question script and lognormal incentive draws; unresolved SI mismatch |
| self_assessment.py | Original cumulative predictions, criteria question, then privacy-use question |
| longitudinal_policy.py | Separately authorized 60-month extension, not a recovered historical script |

The original input layout is `[field] + [field]`; local research scripts keep their `CONFIG`, functions, inline prompts and direct SDK calls. Only public GitHub scripts use the original `src/common.py` and `src/synthetic_data.py`. This release does not impose a common experiment framework, a new CLI on research scripts, a new API route, or a checkpoint format.

[Source and change ledger](docs/SOURCE_CHANGES.md) lists each original file, its hash and the reasons for its edits. Read that document before comparing this package with historical results.

## Install

Use Python 3.10+ in a dedicated environment:

```sh
python -m venv .venv
# Activate the environment, then:
python -m pip install -r requirements.txt
```

Dependencies are unchanged from the public package. Do not put API credentials in scripts. `.env.example` lists environment variable names; it is not automatically loaded.

## Run the public GitHub experiments

Set `OPENAI_API_KEY` and, if needed, `OPENAI_BASE_URL`. Supply the exact model ID; the code never substitutes a model.

```sh
python experiments/information_collection.py --model EXACT_MODEL_ID --sample-size 2000
python experiments/information_processing.py --model EXACT_MODEL_ID --sample-size 2000
python experiments/information_dissemination.py --model EXACT_MODEL_ID --sample-size 2000
python experiments/rct_policy_shocks.py --model EXACT_MODEL_ID --shock penalty --pairs 9 --users-per-stage 100
```

These retain the upstream seed, temperature, optional input-CSV and output-directory arguments. RCT counts must be selected explicitly; the example is not a claim that every historical experiment used the same counts. Use a separate output directory for each model or new run: original scripts overwrite their output files. No new run-ID or automatic resume interface is added.

## Run original project experiments

For Azure scripts, set `AZURE_OPENAI_API_KEY`, `AZURE_OPENAI_ENDPOINT`, `OPENAI_API_VERSION` and `AZURE_OPENAI_MODEL`. Inspect and edit `CONFIG` at the top of the chosen script, as in the original research workflow, then run it directly:

```sh
python experiments/processing_travel.py
python experiments/dynamic_feedback.py
python experiments/self_assessment.py
```

For CoT, set `OPENAI_API_KEY`, `OPENAI_BASE_URL`, `OPENAI_MODEL_PROVIDER` and `OPENAI_MODEL`; the original call joins the last two as `provider/model`. It retains nine pairs and 100 users per period. Dynamic defaults are four rounds of 2,000 fresh profiles, repeated 14 times. Self-assessment retains the original 100-user count. Other original research scripts use their own CONFIG values; there is no universal seed or sample-size override.

The model registry records 16 main-text baseline families, not verified live deployment IDs or historical snapshots. A valid model/deployment must be supplied by the recipient.

## Check without an API

```sh
python -m pytest -q -p no:cacheprovider tests
python tools/smoke_test.py
```

The tests replace SDK clients and block network connections. Small synthetic samples and outputs exist only in temporary test directories. Offline checks exercise the actual original-style procedures; no offline flags or fake clients are embedded in production experiment code. Passing tests does not establish scientific replication of the reported effects.

## Longitudinal extension

```sh
python experiments/longitudinal_policy.py --model EXACT_MODEL_ID --shock bonus --output-dir outputs/longitudinal_bonus
```

The approved extension uses 50 pairs, 60 months, a month-13 treatment shock, 2,000 cases per agent-year and each arm's own previous-month summary. These are explicitly new implementation assumptions. One shock requires 900,000 scoring calls per model before retries; all four require 3,600,000. This package does not launch them automatically or supply automatic resume.

## Boundaries and known discrepancies

- No datasets, historical outputs, logs, credentials, weights, training or notebooks are distributed. Scripts generate their own synthetic records when run.
- No new regression, DID, figure, Stata or firm-data workflow is added. Original `analysis/` files remain unvalidated reference material.
- Original privacy-preference sampling is lognormal and can exceed the SI's stated 0–1,000 range. The distribution is not silently changed; see the source ledger.
- The non-predictive substitution needs a main-text correction to the XXX script; an exact matching historical script has not been identified.
- Live API behavior and historical model snapshots remain unverified. Prompt corrections can change results; numerical agreement with the paper is not promised.
- The paper's broader Data Availability statement includes materials outside this deliberately code-only release.

[Experiment map](docs/EXPERIMENT_MAP.md) · [Protocol](docs/PROTOCOL.md) · [Outputs](docs/OUTPUTS.md) · [Validation](docs/VALIDATION.md)

Build a source-only archive at a new path with `python tools/build_release.py --output ../replication-new.zip`. Packaging scans use an explicit allowlist and do not run experiments. `UPSTREAM.json` identifies the public snapshot and `RELEASE_MANIFEST.json` hashes released files. No publication, push or new licence is implied.
