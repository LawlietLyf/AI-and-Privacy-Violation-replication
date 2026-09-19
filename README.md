# Figure reproduction package

**Systematic AI privacy violations under economic incentives**

This package contains the authors' prepared data and Stata scripts for Figures 2b, 3a–c and 4a–c, together with Extended Data Figures 1, 2 and 3. The main entry point is `run.do`.

## 1. System requirements

- **Stata 17 or later**, with an edition supporting `set matsize 3000` for the supplied empirical scripts (SE/MP). The original empirical scripts were prepared for Stata 17 MP. Current execution is tested with Stata 18 on Windows, build 10.0.26200. macOS and Linux have not been tested in this verification; paths use forward slashes and the original directory capitalization.
- A standard desktop computer; no GPU, accelerator or other non-standard hardware. Allow approximately 1 GB of free disk space for the package and generated figures. 8 GB RAM is a practical recommendation, not a measured minimum. The original `set mem 1700m` lines are retained; modern Stata manages memory automatically.
- A writable package directory for `outputs/`, and a writable Stata PERSONAL ado directory for grstyle's temporary scheme.
- The user-written commands below. Stata itself requires a licence. Internet access is needed to install packages not already available; the analyses subsequently run locally without network access.

| Dependency | Version used in verification | Purpose / source |
|---|---|---|
| grstyle | 1.1.1, 15 September 2020 | Figure appearance; SSC |
| coefplot | 1.8.6, 22 February 2023 | Figure 4 coefficient plots; SSC |
| ppmlhdfe | 2.3.0, 25 February 2021 | Figure 4 Poisson models; SSC |
| ftools | 2.49.1, 8 August 2023 | Fixed-effects support; [official repository](https://github.com/sergiocorreia/ftools/tree/2.49.1) |
| reghdfe | 6.12.5, 27 December 2023 | Figure 4 fixed-effects models; [official repository](https://github.com/sergiocorreia/reghdfe/tree/6.12.5) |
| ivreghdfe | 1.1.3, 4 January 2023 | Figure 4 instrumental-variable model; [official repository](https://github.com/sergiocorreia/ivreghdfe/tree/1.1.3) |
| ivreg2 | 4.1.12, 14 August 2024 | Instrumental-variable support; SSC |
| ranktest | 2.0.04, 21 September 2020 | Instrumental-variable diagnostics; SSC |
| egenmore (`_gxtile`) | `_gxtile` 2.1, 14 January 2019 | Figure 4 quantile groups; SSC |

These are tested versions, not claims that every other version is incompatible. `run.do` records the active command versions in its log and stops if a required command is absent. It does not automatically install or update software.

## 2. Installation

Extract the complete folder, preserving its directory structure. Release the `Fig 4.zip`. In Stata, change to the directory containing this README and `run.do`:

```stata
cd "C:/your/path/"
```

Replace this example path with your local path. No paths inside the analysis files need editing.

For a new Stata setup, install the additional commands once, in the order below. The `ssc install` commands download from SSC; the three `net install` commands download the specified versions from the dependencies' official GitHub repositories:

```stata
ssc install grstyle
ssc install coefplot
ssc install ivreg2
ssc install ranktest
ssc install egenmore

net install ftools, from("https://raw.githubusercontent.com/sergiocorreia/ftools/2.49.1/src/") replace
net install reghdfe, from("https://raw.githubusercontent.com/sergiocorreia/reghdfe/6.12.5/src/") replace
net install ivreghdfe, from("https://raw.githubusercontent.com/sergiocorreia/ivreghdfe/1.1.3/src/") replace

ssc install ppmlhdfe
```

The three GitHub URLs specify the tested versions rather than the changing `master` branch. SSC supplies its currently distributed versions, which may differ from the verification table. If your Stata already has the tested versions, installation is unnecessary. Run installation commands in a fresh Stata session so that previously loaded Mata libraries do not persist from a different dependency version. The `replace` commands affect those installed packages; they do not change any research data.

The `Fig 4/Stata Package/` directory contains documentation placeholders only. Third-party source trees are not included in this distribution. Its structure is:

```text
Fig 4/Stata Package/
    README.md
    ftools-master/README.md
    reghdfe-master/README.md
    ivreghdfe-master/README.md
```

The README files preserve the directory structure in GitHub, which does not track empty directories. These are not local installation sources: no files need to be downloaded into these folders. Stata installs the commands in its ado directory and finds them through its search path. `run.do` checks the installed commands and does not read the placeholder folders. Each dependency's source and licence are available from its official repository linked above.

Typical setup time after Stata itself is installed is approximately **2–5 minutes** on a normal desktop with internet access. This is an estimate; it depends on the connection and the existing installation. Stata installation time is not included.

## 3. Demonstration using the supplied data

The supplied figure datasets serve as the example data for demonstrating the code. The compact plotting datasets contain 4–51 records each; Figure 4 uses the supplied empirical analysis datasets. The demonstration is the figure reproduction workflow itself. From the package root, after installation:

```stata
do run.do
```

Expected output: the nine figures listed below, each saved as PDF, PNG and GPH, plus `outputs/run.log`. Allow approximately **1–3 minutes** on a normal desktop; verification runs took 36 and 51 seconds, excluding Stata startup. Inputs are unchanged. The next section maps each figure to its script and data and explains how to run the code on other data.

## 4. Instructions for use and full reproduction

In a fresh Stata session, set the package root once and run:

```stata
cd "C:/your/path/Manual Construct"
do run.do
```

Run the entire do-file, rather than selected lines. `run.do` clears data and stored estimates from memory, executes the nine scripts in the order below, and exports each completed graph. Save any unrelated work in your Stata session first. Missing dependencies or a wrong working directory are reported in the command window before a new log is opened. Once analysis starts, Stata stops at any failing command; inspect `outputs/run.log` before using partial outputs. A successful run ends with `Completed: nine figures saved as PDF, PNG and GPH in outputs/.`

| Output stem in `outputs/` | Script | Input / operation |
|---|---|---|
| fig2b | `Fig 2/code/Fig2 Plot.do` | `Fig 2/Data/fig2_data.dta`: 51 plotting records |
| fig3a | `Fig 3/a/code/fig3a_plot.do` | `Fig 3/a/data/fig3a_data.dta`: 24 policy-by-model estimates |
| fig3b | `Fig 3/b/code/plot_fig3b.do` | `Fig 3/b/data/fig3b_data.dta`: 12 condition-by-round records |
| fig3c | `Fig 3/c/code/plot_fig3c.do` | `Fig 3/c/data/fig3c_data.dta`: four inference conditions |
| fig4a | `Fig 4/Stata Code/Baseline Regressions -- Nature Submission.do` | Supplied empirical data: baseline Poisson, IV and OLS models for AI and generative AI |
| fig4b | `Fig 4/Stata Code/Heterogenity Analyses -- Nature Submission.do` | Supplied empirical data: four heterogeneity analyses |
| fig4c | `Fig 4/Stata Code/Incident-Level Analyses -- Nature Submission.do` | Supplied empirical data: mean and median privacy costs by AI-intensity group |
| ed2 | `ED 2/code/ED2_plot.do` | `ED 2/data/ED2_data.dta`: 34 plotting records |
| ed3 | `ED 3/code/ED3_plot.do` | `ED 3/data/ed3_data.dta`: 36 plotting records |

For each output stem, the program writes a vector **PDF**, a **PNG** preview and an editable Stata **GPH** file: **27 figure files**, plus `outputs/run.log`. Rerunning replaces those outputs. No input DTA is overwritten. Regression output, sample sizes, warnings, dependency versions and start/end times appear in the log. The program does not create separate regression-table documents. Stata-generated logs can contain local file and installation paths; exclude `outputs/` when distributing the source package. The supplied ZIP excludes this directory.

Allow approximately **1–3 minutes** for the complete run on a normal desktop; the verification timing is reported below. Runtime depends on the machine and the installed dependency versions. Figure 4 requires more computation than redrawing the compact plotting datasets.

The supplied plotting and estimation commands are retained. As documented by the authors for Figure 4, the manuscript's final figure appearance also received visual adjustments in Stata's Graph Editor. The exported GPH files permit these visual edits; this script exports the reproducible base graphs, rather than claiming pixel-identical manuscript layout.

### Using your own data

Work on a copy of the package and replace the relevant input file, or edit its `use`/`merge using` path in the corresponding do-file. Run that do-file from the package root to inspect the graph, or run `run.do` to rebuild all figures.

- **Prepared plotting data:** preserve the variable names, types, condition strings and plotting-position fields used by the target script. Coefficient/rate fields and confidence bounds must already be in the units of the intended plot. Preserve Stata value labels used for model and panel labels. For example, Figure 3c's `order` values determine the positions of its four conditions. These plotters do not turn new raw API responses into estimates.
- **Empirical analyses:** preserve the variables used in the Figure 4 scripts and the matching keys across all supplied tables (`gvkey`, `fyear`, `main_county`, or `permno` and `incident_date`, as specified by each merge). The existing do-files explicitly contain the sample restrictions, transformations, winsorization, models and standard-error specifications. They should be reviewed for scientific suitability before applying them to a different dataset.
- **Identifiers:** the authors' Figure 4 data note states that GVKEY identifiers have been replaced with randomized identifiers. Use the supplied tables together; do not interpret those values as external Compustat identifiers. Changing identifiers alone does not make the underlying empirical covariates synthetic. This README does not grant redistribution rights to third-party source data; access terms are governed by the manuscript's Data Availability statement and the applicable data providers.

### Code availability and scope

The study's model-experiment repository is [AI-and-Privacy-Violation-replication](https://github.com/LawlietLyf/AI-and-Privacy-Violation-replication). This README describes the figure package supplied with the submission. Model experiments and fresh-response estimation workflows are separate from this prepared-data figure runner.

The data generation code under `ED 1/` folder is not read or executed by `run.do`. Its standalone Python inference script reads `AZURE_OPENAI_API_KEY` and `AZURE_OPENAI_ENDPOINT` from environment variables; users of that script must also set its output directory and model deployment for their own environment. 
