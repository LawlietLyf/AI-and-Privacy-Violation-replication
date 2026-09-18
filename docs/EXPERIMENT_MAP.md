# Experiment map

| Manuscript / supporting condition | Script | Original source / status |
|---|---|---|
| Methods: data collection | information_collection.py | GitHub original three-turn flow |
| Methods: data processing | information_processing.py | GitHub original independent sessions |
| Methods: dissemination | information_dissemination.py | GitHub; occupation corrected to phone |
| Economic rationality / RCT | rct_policy_shocks.py | GitHub; penalty corrected, unsupported count defaults removed |
| Policy reasoning / SI CoT | rct_cot.py | Original OpenRouter CoT script, policy shock correction |
| Corporate data environments | dynamic_feedback.py | Original noprivacy+3firm+bootstrap script, main-text count/units correction |
| SI Rename Sensitive Data | processing_renamed.py | Original Attribution/no label script |
| Non-predictive private substitution | processing_placebo.py | XXX source adapted to main-text design; exact historical source not found |
| SI travel / car | processing_travel.py, processing_car.py | Corresponding original domain scripts |
| No private input control | processing_without_private.py | Original no-private first-round extraction |
| SI general privacy preference | privacy_preference.py | Original Alter-bonus script; SI range discrepancy unresolved |
| Main-text self-assessment | self_assessment.py | Original multiple-self score script; original batch follow-up |
| 60-month policy extension | longitudinal_policy.py | User-approved new design, explicitly not historical source recovery |

The executable scripts and their inline or upstream text prompts are the authoritative implementation. [SOURCE_CHANGES.md](SOURCE_CHANGES.md) identifies exact private source paths and hashes, and every allowed edit. All conditions have test-side offline checks; none has live API or paper-level numerical validation.

The baseline registry covers the main-text 16 model families. The SI CoT/RCT set includes Claude-3.5-Haiku, Gemini-2.0-Flash, GPT-4o-Mini, Llama-3.1-70B and Qwen-Turbo. Exact provider IDs/deployments are supplied by the user and never automatically substituted.
