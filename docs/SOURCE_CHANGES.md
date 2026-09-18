# Source files and permitted changes

This release starts from the original files, rather than the previous rewritten package. The public base is commit `07e8900887f2d7b09da5dce651a7fe4b33b5df7d`. Private source paths identify author-held scripts, which are not distributed. Hashes identify their exact inspected versions; no original credentials or data are included.

The author requested source fidelity over the former unified interface. Consequently, new run IDs, settings fingerprints, JSON candidate inputs, custom checkpoint/resume machinery and production offline/provider flags have been removed. Public scripts keep their original CLI and helpers. Private research scripts keep their original CONFIG blocks, inline prompts, functions and API calls. Tests substitute SDK clients externally.

## Important distinctions

- Rename: the original XXX script calls the field error data; this condition is retained. It is distinct from the main-text non-predictive private substitution.
- Non-predictive substitution: no matching original implementation was located. The XXX script is minimally changed to mark XXX private and generate purchases from a separate withheld predictor. This is a documented main-text correction, not an assertion that it produced archived results.
- General privacy preference: original lognormal bonus and penalty draws are retained. They can exceed 1,000, whereas SI states 0–1,000 without its sampling distribution. This discrepancy remains unresolved; no alternative distribution is invented.
- Self-assessment: original 100-user accumulated conversation, then criteria question, then privacy-use question. The earlier per-user Yes/No reconstruction is removed.
- CoT: original JSON answer schema and OpenRouter call shape are restored. The bonus shock is changed to the main-text/SI policy shock, and both arms retain JSON output.
- The 60-month extension remains the separately authorized new design. It has no claimed original script. Its monthly memory and schedule remain explicitly additional assumptions.

## experiments/information_collection.py

Source: `GitHub snapshot: experiments/information_collection.py`

Original SHA-256: `2fbda9cffe929d0a71da1b15faa78d9bcca4c26ae9663077dd3631a7499ad040`

- Restore original GitHub implementation; remove later run IDs, fingerprinting, provider dispatcher and resume layer.
- Record exception type only; do not copy SDK error bodies or credentials.

## experiments/information_dissemination.py

Source: `GitHub snapshot: experiments/information_dissemination.py`

Original SHA-256: `025e6f4464fd58a69441f9ccdda36070e4e09aa85ab8137ba13e0e7011401ee4`

- Restore original GitHub implementation; remove later run IDs, fingerprinting, provider dispatcher and resume layer.
- Record exception type only; do not copy SDK error bodies or credentials.
- Main-text correction: phone replaces occupation, including exact disclosure check.

## experiments/information_processing.py

Source: `GitHub snapshot: experiments/information_processing.py`

Original SHA-256: `853fe531fb76de0dfa19575a4bf3d6e92b35cdf13f9cc105496efa9064bddc3e`

- Restore original GitHub implementation; remove later run IDs, fingerprinting, provider dispatcher and resume layer.
- Record exception type only; do not copy SDK error bodies or credentials.

## experiments/rct_policy_shocks.py

Source: `GitHub snapshot: experiments/rct_policy_shocks.py`

Original SHA-256: `438e33cf7e19aeec80b8d7758a5c90ef8be7ef35f846e4ed356414df1cbbcf09`

- Restore original GitHub implementation; remove later run IDs, fingerprinting, provider dispatcher and resume layer.
- Main-text penalty baseline $200; counts explicitly selected because historical defaults are unsupported.
- Save raw responses alongside scores; original paired history, sample generation and calls retained.

## src/common.py

Source: `GitHub snapshot: src/common.py`

Original SHA-256: `56b3aa9d46445006456fb521922ac0821dcaede27fac4c4d6bbdfdef9bec101a`

- Restore original helper signatures, client construction, retry defaults and numeric extraction.
- Exception type only, to exclude SDK credentials from errors.

## src/synthetic_data.py

Source: `GitHub snapshot: src/synthetic_data.py`

Original SHA-256: `8a28e1a9b8128af0ae713ec99ae9c141d6b98d916eac29ce7a2cdbd3cf43d43b`

- Main-text dissemination field: generate phone rather than occupation. All other upstream generation and CSV loading retained.

## prompts/information_collection_neutral.txt

Source: `GitHub snapshot: prompts/information_collection_neutral.txt`

Original SHA-256: `025973d643e7e842faf401e519570004f7dd0ae8ae9a578b86fb44dd0f0f0737`

- Unchanged upstream prompt.

## prompts/information_collection_recovery.txt

Source: `GitHub snapshot: prompts/information_collection_recovery.txt`

Original SHA-256: `d0fc4ea109f09e6599a1e341ff968902e52175cf9eac5acc2f04c2824b52fddc`

- Unchanged upstream prompt.

## prompts/information_collection_registration.txt

Source: `GitHub snapshot: prompts/information_collection_registration.txt`

Original SHA-256: `dc712cecf1e5258bd7462b153d791a9760c4e777b36e9c0323c37dcb7f587587`

- Unchanged upstream prompt.

## prompts/information_collection_system.txt

Source: `GitHub snapshot: prompts/information_collection_system.txt`

Original SHA-256: `f5364328192fe141993bd0778475ab76d93e86409f6bf671e9145ed40b68595f`

- Unchanged upstream prompt.

## prompts/information_dissemination_request.txt

Source: `GitHub snapshot: prompts/information_dissemination_request.txt`

Original SHA-256: `124e08f40dbcd3ebc776c61bd5c303925135564683a86c9815f3ef49418f4e00`

- Phone replaces job, preserving the original request and answer layout.

## prompts/information_dissemination_system.txt

Source: `GitHub snapshot: prompts/information_dissemination_system.txt`

Original SHA-256: `2741ccaaabd69eebcb24f3809ec97fc465c55d81074d100a502efbd0d4864595`

- Phone replaces job, per main text.

## prompts/information_processing_system.txt

Source: `GitHub snapshot: prompts/information_processing_system.txt`

Original SHA-256: `6ec9db04f018d5ee9380b293855a95a9e21f0d880994d93b31fcffa655cd101b`

- Unchanged upstream prompt.

## prompts/rct_bonus_reduction.txt

Source: `GitHub snapshot: prompts/rct_bonus_reduction.txt`

Original SHA-256: `35cb9497e535f19aeea54beab5a12007ad6ebc26e790c2749f430da6cca7ef71`

- Unchanged upstream prompt.

## prompts/rct_control.txt

Source: `GitHub snapshot: prompts/rct_control.txt`

Original SHA-256: `aecdb24a3e0c7f5f3333c4b413b569049af70ef057f7af17b119ab0a3088d6a2`

- Unchanged upstream prompt.

## prompts/rct_detection_increase.txt

Source: `GitHub snapshot: prompts/rct_detection_increase.txt`

Original SHA-256: `666da1252a6f5b97ad6f901378cee72562294056f492806ea56aebc9f7a92ee3`

- Unchanged upstream prompt.

## prompts/rct_penalty_increase.txt

Source: `GitHub snapshot: prompts/rct_penalty_increase.txt`

Original SHA-256: `899ae418464aaba093ec850fc827cebeaf13da6ec203d84cb331fad2e81265d7`

- Main-text $200 to $2,000 penalty shock.

## prompts/rct_policy_strictness.txt

Source: `GitHub snapshot: prompts/rct_policy_strictness.txt`

Original SHA-256: `38a137b7332602c629b94307fe7068941cc7755f7dc77e4484ff14e887c3be3d`

- Unchanged upstream prompt.

## experiments/processing_travel.py

Source: `Project/Code/privacy_experiment(travel).py`

Original SHA-256: `e5db520a5aef60684d0f685d939c8d63c9402d84ff26e71cf021d62e7f3dc3de`

- Keep original CONFIG, function bodies, profile generation order, bracketed inputs, inline prompts and Azure API calls.
- Read credentials, endpoint, API version and deployment name from environment; replace local paths with outputs/<experiment>.
- Main-text scoring scale 0-100 and bonus $1,000; exceptions contain type only.
- Create generated-input directory; missing summary categories count as zero in small samples.

## experiments/processing_car.py

Source: `Project/Code/privacy_experiment(car).py`

Original SHA-256: `dc314d04e1eac60b6252cead7385674cf1887874f22162ba74fd20c07ef79ec2`

- Keep original CONFIG, function bodies, profile generation order, bracketed inputs, inline prompts and Azure API calls.
- Read credentials, endpoint, API version and deployment name from environment; replace local paths with outputs/<experiment>.
- Main-text scoring scale 0-100 and bonus $1,000; exceptions contain type only.
- Create generated-input directory; missing summary categories count as zero in small samples.

## experiments/processing_renamed.py

Source: `Project/Code/Attribution/privacy_experiment(no label).py`

Original SHA-256: `80d6de927862df278f4e88fe69d623d7261ff0406d3894a12826b2157370fcb0`

- Keep original CONFIG, function bodies, profile generation order, bracketed inputs, inline prompts and Azure API calls.
- Read credentials, endpoint, API version and deployment name from environment; replace local paths with outputs/<experiment>.
- Main-text scoring scale 0-100 and bonus $1,000; exceptions contain type only.
- Create generated-input directory; missing summary categories count as zero in small samples.
- Preserve original XXX/error-data wording and .8/.2 link, without adding a new privacy label to the rename condition.

## experiments/self_assessment.py

Source: `Project/Code/Zero-Shot/privacy_experiment(multiple-self score).py`

Original SHA-256: `536b70c9b50a9109675e28a5f733a381cc57ea5fb8c968190d7c0ab3456f4863`

- Keep original CONFIG, function bodies, profile generation order, bracketed inputs, inline prompts and Azure API calls.
- Read credentials, endpoint, API version and deployment name from environment; replace local paths with outputs/<experiment>.
- Main-text scoring scale 0-100 and bonus $1,000; exceptions contain type only.
- Create generated-input directory; missing summary categories count as zero in small samples.
- Restore original 100-user accumulated prediction history, criteria question and subsequent self-report; main text does not specify another count.

## experiments/dynamic_feedback.py

Source: `Project/Code/privacy_experiment(noprivacy+3firm+bootstrap).py`

Original SHA-256: `4fbf1ddb894ba2866d1ab156f792cbd8819a0371a6bbef42d8539dd05f60c952`

- Keep original CONFIG, function bodies, profile generation order, bracketed inputs, inline prompts and Azure API calls.
- Read credentials, endpoint, API version and deployment name from environment; replace local paths with outputs/<experiment>.
- Main-text scoring scale 0-100 and bonus $1,000; exceptions contain type only.
- Create generated-input directory; missing summary categories count as zero in small samples.
- Four rounds/2,000 cases per main text; run all 14 SI repetitions instead of a saved partial range 13-14.
- Scale feedback increment .05 -> 5 and cap 1 -> 100. Invalid numeric feedback is omitted, never clipped into valid predictions.
- Preserve original sensitive-column permutation, random tie shuffle, floor top-30%, dataframe feedback text and previous-round CSV loading.

## experiments/processing_without_private.py

Source: `Project/Code/privacy_experiment(noprivacy first).py`

Original SHA-256: `4c57d7fdea160c767f5d099d62a1b78b4cc5cb7b92b95325caf6187a251ae0e5`

- Extract original round 1 only; remove unreachable later-round feedback; credentials/paths externalized; main-text scale and bonus.

## experiments/processing_placebo.py

Source: `Project/Code/Attribution/privacy_experiment(no label).py`

Original SHA-256: `80d6de927862df278f4e88fe69d623d7261ff0406d3894a12826b2157370fcb0`

- Main-text substitution requires a private, non-predictive nonsensitive field. Retain XXX representation from original rename script; generate purchase from a separate withheld .8/.2 predictor.
- Remove invented favorite-color variant. This necessary design correction is not claimed to be an exact archived implementation.
- Same credential/path/scale/bonus edits as rename script.

## experiments/rct_cot.py

Source: `Project/Code/Systemic Test/new code for RCT/Bonus/privacy_experiment_bonus(openrouter-RCT-COT).py`

Original SHA-256: `d3fd6834a85ae3a4a7f566d6b5b1a79bfdabc23ac31163ce73b84adfe7549b35`

- Preserve nine matched pairs, 100 users/period, common pre-history, identical post sample, policy acknowledgement, two retries and original OpenRouter chat calls.
- Main-text/SI CoT policy shock replaces bonus shock. Resolve contradictory numeric-only instruction and retain original JSON schema in both post arms.
- Parse only original JSON score field; save original raw score and thought_process, no invented FINAL_SCORE delimiter.
- Credentials, endpoint, supplier/model identifiers and output paths externalized.

## experiments/longitudinal_policy.py

Source: `Previously user-approved 60-month extension; no historical script claimed`

Original SHA-256: `0a7bea1a627e562bdf5c99e3c8c46c7ad56cc62955cae1bc886aaf5ab644f373`

- Keep approved 50-pair/60-month schedule and monthly own-arm summary.
- Use public chat_completion helper and bracketed user inputs; remove provider/run-ID/fingerprint/resume/offline machinery.

## experiments/privacy_preference.py

Source: `Project/Code/Zero-Shot/privacy_preference(Alter-bonus).py`

Original SHA-256: `44e47067a74e09df1e02e53b61eb8e63efe7549ee94573fba35576ccfc93be10`

- Restore original independent lognormal draws, prompt, CONFIG and Azure calls. No assumed uniform distribution or new fixed-design selector.
- SI describes 0-1000 but does not specify the draw distribution; original can exceed 1000. Preserve and disclose this unresolved source discrepancy.
- Environment credentials/model/endpoint, relative output; exception type only. Replace private pandas _append with row assignment for supported pandas versions; identical rows/order.
