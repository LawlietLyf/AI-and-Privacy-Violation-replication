Replication Package for Statistical Analyses: Systematic AI Privacy Violations Under Economic Incentives

This README provides instructions for replicating the empirical results and generating the primary figures for the manuscript "Systematic AI privacy violations under economic incentives," submitted to Nature. 

1. System Requirements
* Software: Stata 17.0 MP. No additional non-standard software or specific operating system is required. 
            You can use either Windows or Mac system.
* Memory:   The scripts set the memory allocation to 1700m and the matrix size to 3000.

2. Installation & Setup
Use sections 1 and 2 of the package-root README.md for the tested dependency versions and online installation commands. Install ftools 2.49.1, reghdfe 6.12.5 and ivreghdfe 1.1.3 from the versioned official GitHub URLs given there; install the remaining commands from SSC. Internet access is required for installation. The Stata Package folder and its three subfolders contain README placeholders only, not dependency source code. Stata loads the installed commands from its ado search path; run.do does not read these folders.

3. Data Overview
We provide demo datasets to ensure replicability while protecting proprietary data. For analyses utilizing the GVKEY identifier from S&P Compustat (a database covering accounting data for major US listed and large private firms), we have generated a randomized, fake GVKEY ID for each observation in our provided datasets.

4. Replication Instructions
Set the working directory once to the package root, then run the master script:

* ------------------------------------ *
cd "C:/your/path/Manual Construct"
do run.do
* ------------------------------------ *

Replace the example path with your local package path. No paths inside the three Figure 4 do-files need editing. The master script saves Figure 4a, 4b and 4c to outputs/fig4a.*, outputs/fig4b.* and outputs/fig4c.* as PDF, PNG and GPH, along with the other figures in the package.

* Expected Run Time: Approximately 1 to 3 minutes on a standard desktop computer.

Executing the three provided .do files will generate the three subfigures of Figure 4:

* Figure 4a: Run Baseline Regressions -- Nature Submission.do. This script estimates baseline long-difference and panel models (Poisson, 2SLS, and OLS) assessing privacy violation incidents and GDPR fines.
* Figure 4b: Run Heterogenity Analyses -- Nature Submission.do. This script estimates the interaction effects between AI job ratios and factors such as social-minded institutional ownership, previous incidents, competition pressure, and analyst coverage.
* Figure 4c: Run Incident-Level Analyses -- Nature Submission.do. This script evaluates the mean and median privacy costs based on the AI job ratio.

To run a single panel, remain in the package root and execute its do-file under "Fig 4/Stata Code/". For example: do "Fig 4/Stata Code/Baseline Regressions -- Nature Submission.do". The individual scripts display graphs; run.do handles saving and exporting them.

5. Notes on Output Formatting
The provided .do files utilize the grstyle and coefplot packages to generate the base graphs ("ssc install coefplot" and "ssc install grstyle"). To reproduce the exact final aesthetic of Figure 4 as it appears in the manuscript, manual adjustments were made by us to the raw Stata output within the Graph Editor. These adjustments were strictly visual (e.g., formatting figure titles, adjusting X-axis and Y-axis labels, modifying grid layouts) and do not involve any changes to the underlying data or statistical results.
