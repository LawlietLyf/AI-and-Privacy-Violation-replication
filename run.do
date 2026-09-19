/*
Systematic AI privacy violations under economic incentives
Run from the directory containing this file: do run.do
Figures 2b, 3a-c, 4a-c, ED2 and ED3. ED1 is not run.
Dependency installation and supplied-data reproduction are described in README.md.
*/
version 17.0
clear all
set more off

capture confirm file "Fig 2/Data/fig2_data.dta"
if _rc {
    display as error "Change Stata's working directory to the folder containing run.do."
    exit 601
}

* Check dependencies without downloading or replacing installed packages.
foreach command in grstyle ppmlhdfe coefplot ftools reghdfe ivreghdfe ivreg2 ranktest _gxtile {
    capture which `command'
    if _rc {
        display as error "Missing command: `command'. Follow Installation in README.md."
        exit 499
    }
}

capture mkdir "outputs"
capture log close reproduction
log using "outputs/run.log", text replace name(reproduction)
display "Started: `c(current_date)' `c(current_time)'"
display "Stata version: `c(stata_version)'; operating system: `c(os)'"
foreach command in grstyle ppmlhdfe coefplot ftools reghdfe ivreghdfe ivreg2 ranktest _gxtile {
    which `command'
}

* Each existing script keeps its original data, estimation and plot commands.
display "Figure 2b"
do "Fig 2/code/Fig2 Plot.do"
graph save "outputs/fig2b.gph", replace
graph export "outputs/fig2b.pdf", replace
graph export "outputs/fig2b.png", width(3600) replace

clear all
display "Figure 3a"
do "Fig 3/a/code/fig3a_plot.do"
graph save "outputs/fig3a.gph", replace
graph export "outputs/fig3a.pdf", replace
graph export "outputs/fig3a.png", width(3600) height(3000) replace

clear all
display "Figure 3b"
do "Fig 3/b/code/plot_fig3b.do"
graph save "outputs/fig3b.gph", replace
graph export "outputs/fig3b.pdf", replace
graph export "outputs/fig3b.png", width(2400) replace

clear all
display "Figure 3c"
do "Fig 3/c/code/plot_fig3c.do"
graph save "outputs/fig3c.gph", replace
graph export "outputs/fig3c.pdf", replace
graph export "outputs/fig3c.png", width(2400) replace

clear all
display "Figure 4a"
do "Fig 4/Stata Code/Baseline Regressions -- Nature Submission.do"
graph save "outputs/fig4a.gph", replace
graph export "outputs/fig4a.pdf", replace
graph export "outputs/fig4a.png", width(2400) replace

clear all
display "Figure 4b"
do "Fig 4/Stata Code/Heterogenity Analyses -- Nature Submission.do"
graph save "outputs/fig4b.gph", replace
graph export "outputs/fig4b.pdf", replace
graph export "outputs/fig4b.png", width(2400) replace

clear all
display "Figure 4c"
do "Fig 4/Stata Code/Incident-Level Analyses -- Nature Submission.do"
graph save "outputs/fig4c.gph", replace
graph export "outputs/fig4c.pdf", replace
graph export "outputs/fig4c.png", width(2400) replace

clear all
display "Extended Data Figure 1"
do "ED 1/code/ed1_plot.do"
graph save "outputs/ed1.gph", replace
graph export "outputs/ed1.pdf", replace
graph export "outputs/ed1.png", width(3600) replace

clear all
display "Extended Data Figure 2"
do "ED 2/code/ED2_plot.do"
graph save "outputs/ed2.gph", replace
graph export "outputs/ed2.pdf", replace
graph export "outputs/ed2.png", width(3600) replace

clear all
display "Extended Data Figure 3"
do "ED 3/code/ED3_plot.do"
graph save "outputs/ed3.gph", replace
graph export "outputs/ed3.pdf", replace
graph export "outputs/ed3.png", width(3600) replace

display as result "Completed: nine figures saved as PDF, PNG and GPH in outputs/."
display "Finished: `c(current_date)' `c(current_time)'"
log close reproduction
