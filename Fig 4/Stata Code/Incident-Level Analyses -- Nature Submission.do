********************************************************************************
* Codes are prepared for Stata 17.0 MP
********************************************************************************
set mem 1700m
set more off
set matsize 3000
clear all
* Run from the package root (the directory containing run.do).

* Dependency installation is documented in the root README.md.
* Define local variables
local control_variables       logsale markup rdnorm cashnorm tobin_q
local lightcast_variables     delta_ai_job_ratio_ba delta_ai_job_ratio_ge delta_it_job_ratio
local instrumental_babina     uni_iv_v4c uni_cs_v4c uni_top10
local county_level_controls   delta_num_job_post_county
local control_variables_delta delta_logsale delta_markup delta_rdnorm delta_cashnorm delta_tobin_q
local control_variables_2     logsale markup rdnorm cashnorm /* do not require listed firms (no tobin_q) */

********************************************************************************
* Incident-level analysis

**************************  Programs for Function ******************************
* Winsorize at the 1st and 99th percentiles.
program define trim
 egen p_1  = pctile(`1'), p(1)
 egen p_99 = pctile(`1'), p(99)
 replace `1' = p_1  if `1' < p_1  & `1' !=.
 replace `1' = p_99 if `1' > p_99 & `1' !=.
 drop p_1 p_99
end

********************************************************************************
use "Fig 4/Stata Data/social_incidents_compustat.dta", clear
keep if privacy_violations == 1
merge n:1 permno incident_date using "Fig 4/Stata Data/cost_estimate_privacy.dta", keep(3) nogenerate
replace fyear = fyear - 1
merge n:1 gvkey fyear          using "Fig 4/Stata Data/temp5.dta",                 keep(3) nogenerate
trim pricacy_cost
trim E_R
egen delta_ai_job_ratio_ba_xtile = xtile(delta_ai_job_ratio_ba), nq(3)


********************************************************************************
* Start Plotting the Figure				  
grstyle init
grstyle color background white
grstyle color major_grid gs8
grstyle linewidth major_grid thin
grstyle linepattern major_grid dot
grstyle yesno draw_major_hgrid yes
grstyle yesno grid_draw_min yes
grstyle yesno grid_draw_max yes
grstyle anglestyle vertical_tick horizontal
grstyle gsize axis_title_gap tiny

graph bar (mean) pricacy_cost (median) pricacy_cost, ///
    over(delta_ai_job_ratio_ba_xtile, relabel(1 "Low" 2 "Mid" 3 "High")) ///
    bar(1, color(ebblue)) ///
    bar(2, color(cranberry)) ///
    ytitle("Economic Cost of Privacy Violation" "Incidents (Million USD)") ///
    ylabel(0(500)2500, nogrid format(%9.0fc)) ///
    b1title("Degree of AI-Induced Incidents") ///
    legend(order(1 "Mean" 2 "Median") ring(0) position(11) cols(1) region(lcolor(black))) ///
    title("{bf:c}", position(11) ring(1) span)
