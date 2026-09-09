# Reproducibility notes

## Why fresh API results may differ

Commercial LLM APIs are hosted services. A model-family label can route to an updated snapshot, safety configuration, or inference stack. Exact numerical reproduction therefore requires the archived provider route, exact model/snapshot identifier, prompt version, synthetic input sample, decoding parameters, and analysis specification.

## Historical vs reconstructed code

The supplied development scripts were written at different stages of the project and contain legacy values (including alternative score scales, sample sizes and incentive amounts). This repository does not expose those legacy scripts as if they were canonical replication code. Instead, the current experiment modules reconstruct the workflows against the current manuscript. The archival release will be frozen against the actual historical run logs and accepted paper.

## Statistical analysis

Collection and dissemination are trial-level binary outcomes. The baseline package uses Wilson 95% intervals. The processing metric is an OLS coefficient on the top-30% targeting indicator, multiplied by 100. The exact historical non-sensitive control set remains to be frozen; the current analysis script exposes this as a configurable formula and marks the default as provisional.
