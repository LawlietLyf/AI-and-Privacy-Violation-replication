# AI and privacy violations: replication package

This package provides code and data for Fig. 2b, Fig. 3a–c, Fig. 4a–c and Extended Data Fig. 1a, 2 and 3. Run all commands from the `replication` directory.

## Three ways to use the package

| Route | Input and procedure | API access |
|---|---|---|
| Repeat the experiments | Run each model experiment, estimate from its outputs, then plot | Required |
| Reproduce the paper figures | Plot the supplied figure data; Fig. 4 runs the supplied empirical analyses | Not required |
| Demonstrate the analysis | Estimate and plot a coefficient from the supplied single-model sample | Not required |

Final analysis panels are also supplied for Fig. 3a–c, ED2 and ED3, allowing reviewers to inspect and rerun the estimation steps. New model calls produce new observations; model randomness and service updates mean numerical results can differ from the paper.

## Start with the paper figures

Use **Stata 17 or later**, with **SE/MP for Fig. 4**. Install `grstyle` with `ssc install grstyle`. Fig. 4 has additional dependencies and installation commands in its [README](plot_results/fig4/README.md). You need to first release the plot_results.zip and follow the steps below:

```stata
do plot_results/plot_paper.do
```

This produces ten plots. To run the final-panel estimations and plot their results:

```stata
do plot_results/reestimate_paper.do
```

For the single-model analysis demonstration:

```stata
do plot_results/demo/code/run_demo.do
```

The [demo README](plot_results/demo/README.md) gives the data fields and expected coefficient. Figure-specific commands and methods are listed below.

## Repeat the model experiments

Use Python 3.10 or later and install the dependencies:

```sh
python -m venv .venv
# Activate the environment, then:
python -m pip install -r requirements.txt
```

Set credentials in environment variables. `.env.example` lists the variable names; it is a template and is not loaded automatically.

| Provider | Required settings |
|---|---|
| Azure OpenAI | `API_PROVIDER=azure`, `AZURE_OPENAI_API_KEY`, `AZURE_OPENAI_ENDPOINT`, `OPENAI_API_VERSION` |
| OpenRouter | `API_PROVIDER=openrouter`, `OPENROUTER_API_KEY` |
| OpenAI-compatible tuned deployment | `API_PROVIDER=openai`, `OPENAI_API_KEY`, `OPENAI_BASE_URL`, `OPENAI_MODEL` |

For command-line experiment scripts, pass the model through `--model`. For scripts with a top-level `CONFIG`, set `AZURE_OPENAI_MODEL` or `OPENROUTER_MODEL`, and edit the output paths in `CONFIG`. OpenRouter uses a `provider/model` identifier. Supply the accessible deployment for each baseline or tuned condition and use separate output directories for separate runs. Keep credentials in the environment.

The figure guides give the experiment commands, input CSV lists and Stata estimation steps. `experiments/` retains separate scripts for each experiment; `prompts/` contains the prompt templates. The current tuning workflow runs inference with an already deployed tuned model. The supplied figure datasets and final panels contain the observations needed for the documented analyses.

## Software and data

The workflows were checked on Windows with Stata 18 MP and Python 3.11.5. Python dependencies are listed in `requirements.txt`; Fig. 4's README lists its Stata packages. The supplied-data workflows run locally without a GPU or API key. Stata requires a licence. Allow about 1 GB for the package and generated outputs, with write access to the package and Stata PERSONAL directories. Python/package installation normally takes a few minutes; the supplied-data figure commands typically complete within a few minutes once dependencies are installed.
