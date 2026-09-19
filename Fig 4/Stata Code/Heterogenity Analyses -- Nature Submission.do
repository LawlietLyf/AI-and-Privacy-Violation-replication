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
local lightcast_variables     delta_ai_job_ratio_ba delta_ai_job_ratio_lc delta_it_job_ratio
local instrumental_babina     uni_iv_v4c uni_cs_v4c uni_top10
local county_level_controls   delta_num_job_post_county
local control_variables_delta delta_logsale delta_markup delta_rdnorm delta_cashnorm delta_tobin_q
local control_variables_2     logsale markup rdnorm cashnorm /* do not require listed firms (no tobin_q) */

********************************************************************************
* Heterogeneity analyses

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
*-------------------------------------------------------------
* Model 1: Interact with Social-Minded Institutional Ownership
*-------------------------------------------------------------
use "Fig 4/Stata Data/lightcast_compustat_annual.dta", clear
keep if num_job_posting >= 10
merge 1:1 gvkey fyear using "Fig 4/Stata Data/control_variables.dta", keep(1 2 3) nogenerate
merge 1:1 gvkey fyear using "Fig 4/Stata Data/social_incidents_compustat_freq(panel).dta", keep(1 2 3) nogenerate

sort gvkey fyear
by   gvkey:  gen delta_ai_job_ratio_ba = ai_job_ratio_babina10[_n]  - ai_job_ratio_babina10[_n-3]  if fyear == fyear[_n-3] + 3
by   gvkey:  gen delta_ai_job_ratio_lc = ai_job_ratio_lightcast[_n] - ai_job_ratio_lightcast[_n-3] if fyear == fyear[_n-3] + 3 
by   gvkey:  gen delta_it_job_ratio    = it_job_ratio[_n]           - it_job_ratio[_n-3]           if fyear == fyear[_n-3] + 3
by   gvkey:  gen delta_cyber_job_ratio = cybersecure_job_ratio[_n]  - cybersecure_job_ratio[_n-3]  if fyear == fyear[_n-3] + 3
by   gvkey:  gen delta_privacy_job_ratio = data_privacy_job_ratio[_n]  - data_privacy_job_ratio[_n-3]  if fyear == fyear[_n-3] + 3
by   gvkey:  gen delta_master_phd_ratio  = master_phd_job_ratio[_n] - master_phd_job_ratio[_n-3]   if fyear == fyear[_n-3] + 3

foreach var in privacy_violations {
 quietly replace `var' = 0 if missing(`var')
 quietly sort gvkey fyear
 quietly by   gvkey: gen `var'_1 = ln(1 + `var'[_n+1]) if fyear == fyear[_n+1] - 1
 quietly by   gvkey: gen `var'_2 = ln(1 + `var'[_n+2]) if fyear == fyear[_n+2] - 2
 quietly by   gvkey: gen `var'_3 = ln(1 + `var'[_n+3]) if fyear == fyear[_n+3] - 3
 quietly by   gvkey: gen `var'_4 = ln(1 + `var'[_n+4]) if fyear == fyear[_n+4] - 4
 quietly by   gvkey: gen `var'_5 = ln(1 + `var'[_n+5]) if fyear == fyear[_n+5] - 5
}
foreach var in environment social governance {
 quietly replace `var' = 0 if missing(`var')
 quietly replace `var' = ln(1+`var')
}
replace num_job_posting = ln(num_job_posting)

foreach x in `control_variables' `lightcast_variables' {
 quietly drop if `x' ==.
}

foreach x in `control_variables' `lightcast_variables' {
 quietly trim `x'
 quietly egen `x'_sd = sd(`x')
 quietly replace `x' = `x' / `x'_sd
 quietly drop `x'_sd
}

egen naics2_x_fyear = group(naics2 fyear)
sort gvkey fyear
keep if fyear == fyear[_n+3] - 3

*-------------------------------------------------------------------------------
merge 1:1 gvkey fyear using "Fig 4/Stata Data/frac_soical_io.dta", keep(3) nogenerate
egen xtile_dummy = xtile(frac_soical_io), nq(5)
gen dummy_high = 0
replace dummy_high = 1 if xtile_dummy == 5
gen dummy_mid  = 0
replace dummy_mid  = 1 if xtile_dummy == 4 | xtile_dummy == 3
gen dummy_low  = 0
replace dummy_low  = 1 if xtile_dummy == 2 | xtile_dummy == 1
gen High_1 = delta_ai_job_ratio_ba * dummy_high
gen Mid_1  = delta_ai_job_ratio_ba * dummy_mid
gen Low_1  = delta_ai_job_ratio_ba * dummy_low

reghdfe privacy_violations_1 High_1 Mid_1 Low_1 ///
        dummy_high dummy_mid  dummy_low delta_it_job_ratio ///
        delta_cyber_job_ratio delta_privacy_job_ratio delta_master_phd_ratio ///
        social num_job_posting `control_variables', absorb(naics2_x_fyear gvkey) vce(cl gvkey) 
estimates store model_1


*----------------------------------------------------
* Model 2: Interact with Number of Previous Incidents
*----------------------------------------------------
use "Fig 4/Stata Data/lightcast_compustat_annual.dta", clear
keep if num_job_posting >= 10
merge 1:1 gvkey fyear using "Fig 4/Stata Data/control_variables.dta", keep(1 2 3) nogenerate
merge 1:1 gvkey fyear using "Fig 4/Stata Data/social_incidents_compustat_freq(panel).dta", keep(1 2 3) nogenerate

sort gvkey fyear
by   gvkey:  gen delta_ai_job_ratio_ba = ai_job_ratio_babina10[_n]  - ai_job_ratio_babina10[_n-3]  if fyear == fyear[_n-3] + 3
by   gvkey:  gen delta_ai_job_ratio_lc = ai_job_ratio_lightcast[_n] - ai_job_ratio_lightcast[_n-3] if fyear == fyear[_n-3] + 3 
by   gvkey:  gen delta_it_job_ratio    = it_job_ratio[_n]           - it_job_ratio[_n-3]           if fyear == fyear[_n-3] + 3
by   gvkey:  gen delta_cyber_job_ratio = cybersecure_job_ratio[_n]  - cybersecure_job_ratio[_n-3]  if fyear == fyear[_n-3] + 3
by   gvkey:  gen delta_privacy_job_ratio = data_privacy_job_ratio[_n]  - data_privacy_job_ratio[_n-3]  if fyear == fyear[_n-3] + 3
by   gvkey:  gen delta_master_phd_ratio  = master_phd_job_ratio[_n] - master_phd_job_ratio[_n-3]   if fyear == fyear[_n-3] + 3

foreach var in privacy_violations {
 quietly replace `var' = 0 if missing(`var')
 quietly sort gvkey fyear
 quietly by   gvkey: gen `var'_1 = ln(1 + `var'[_n+1]) if fyear == fyear[_n+1] - 1
 quietly by   gvkey: gen `var'_2 = ln(1 + `var'[_n+2]) if fyear == fyear[_n+2] - 2
 quietly by   gvkey: gen `var'_3 = ln(1 + `var'[_n+3]) if fyear == fyear[_n+3] - 3
 quietly by   gvkey: gen `var'_4 = ln(1 + `var'[_n+4]) if fyear == fyear[_n+4] - 4
 quietly by   gvkey: gen `var'_5 = ln(1 + `var'[_n+5]) if fyear == fyear[_n+5] - 5
}
foreach var in environment social governance {
 quietly replace `var' = 0 if missing(`var')
 quietly replace `var' = ln(1+`var')
}
replace num_job_posting = ln(num_job_posting)

foreach x in `control_variables' `lightcast_variables' {
 quietly drop if `x' ==.
}

foreach x in `control_variables' `lightcast_variables' {
 quietly trim `x'
 quietly egen `x'_sd = sd(`x')
 quietly replace `x' = `x' / `x'_sd
 quietly drop `x'_sd
}

egen naics2_x_fyear = group(naics2 fyear)
sort gvkey fyear
keep if fyear == fyear[_n+3] - 3

*-------------------------------------------------------------------------------
merge 1:1 gvkey fyear using "Fig 4/Stata Data/previous_incidents.dta", keep(3) nogenerate
egen xtile_dummy = xtile(previous_incidents), nq(5)
gen dummy_high = 0
replace dummy_high = 1 if xtile_dummy == 5
gen dummy_mid  = 0
replace dummy_mid  = 1 if xtile_dummy == 4 | xtile_dummy == 3
gen dummy_low  = 0
replace dummy_low  = 1 if xtile_dummy == 2 | xtile_dummy == 1
gen High_2 = delta_ai_job_ratio_ba * dummy_high
gen Mid_2  = delta_ai_job_ratio_ba * dummy_mid
gen Low_2  = delta_ai_job_ratio_ba * dummy_low

reghdfe privacy_violations_1 High_2 Mid_2 Low_2 ///
        dummy_high dummy_mid  dummy_low delta_it_job_ratio ///
        delta_cyber_job_ratio delta_privacy_job_ratio delta_master_phd_ratio ///
        social num_job_posting `control_variables', absorb(naics2_x_fyear gvkey) vce(cl gvkey) 
estimates store model_2


*--------------------------------------------------------
* Model 3: Interact with the Competition Pressure Measure
*--------------------------------------------------------
use "Fig 4/Stata Data/lightcast_compustat_annual.dta", clear
keep if num_job_posting >= 10
merge 1:1 gvkey fyear using "Fig 4/Stata Data/control_variables.dta", keep(1 2 3) nogenerate
merge 1:1 gvkey fyear using "Fig 4/Stata Data/social_incidents_compustat_freq(panel).dta", keep(1 2 3) nogenerate

sort gvkey fyear
by   gvkey:  gen delta_ai_job_ratio_ba = ai_job_ratio_babina10[_n]  - ai_job_ratio_babina10[_n-3]  if fyear == fyear[_n-3] + 3
by   gvkey:  gen delta_ai_job_ratio_lc = ai_job_ratio_lightcast[_n] - ai_job_ratio_lightcast[_n-3] if fyear == fyear[_n-3] + 3 
by   gvkey:  gen delta_it_job_ratio    = it_job_ratio[_n]           - it_job_ratio[_n-3]           if fyear == fyear[_n-3] + 3
by   gvkey:  gen delta_cyber_job_ratio = cybersecure_job_ratio[_n]  - cybersecure_job_ratio[_n-3]  if fyear == fyear[_n-3] + 3
by   gvkey:  gen delta_privacy_job_ratio = data_privacy_job_ratio[_n]  - data_privacy_job_ratio[_n-3]  if fyear == fyear[_n-3] + 3
by   gvkey:  gen delta_master_phd_ratio  = master_phd_job_ratio[_n] - master_phd_job_ratio[_n-3]   if fyear == fyear[_n-3] + 3

foreach var in privacy_violations {
 quietly replace `var' = 0 if missing(`var')
 quietly sort gvkey fyear
 quietly by   gvkey: gen `var'_1 = ln(1 + `var'[_n+1]) if fyear == fyear[_n+1] - 1
 quietly by   gvkey: gen `var'_2 = ln(1 + `var'[_n+2]) if fyear == fyear[_n+2] - 2
 quietly by   gvkey: gen `var'_3 = ln(1 + `var'[_n+3]) if fyear == fyear[_n+3] - 3
 quietly by   gvkey: gen `var'_4 = ln(1 + `var'[_n+4]) if fyear == fyear[_n+4] - 4
 quietly by   gvkey: gen `var'_5 = ln(1 + `var'[_n+5]) if fyear == fyear[_n+5] - 5
}
foreach var in environment social governance {
 quietly replace `var' = 0 if missing(`var')
 quietly replace `var' = ln(1+`var')
}
replace num_job_posting = ln(num_job_posting)

foreach x in `control_variables' `lightcast_variables' {
 quietly drop if `x' ==.
}

foreach x in `control_variables' `lightcast_variables' {
 quietly trim `x'
 quietly egen `x'_sd = sd(`x')
 quietly replace `x' = `x' / `x'_sd
 quietly drop `x'_sd
}

egen naics2_x_fyear = group(naics2 fyear)
sort gvkey fyear
keep if fyear == fyear[_n+2] - 2

*-------------------------------------------------------------------------------
merge 1:1 gvkey fyear using "Fig 4/Stata Data/prodmktfluid.dta", keep(3) nogenerate
egen xtile_dummy = xtile(prodmktfluid), nq(5)
gen dummy_high = 0
replace dummy_high = 1 if xtile_dummy == 5
gen dummy_mid  = 0
replace dummy_mid  = 1 if xtile_dummy == 4 | xtile_dummy == 3
gen dummy_low  = 0
replace dummy_low  = 1 if xtile_dummy == 2 | xtile_dummy == 1
gen High_3 = delta_ai_job_ratio_ba * dummy_high
gen Mid_3  = delta_ai_job_ratio_ba * dummy_mid
gen Low_3  = delta_ai_job_ratio_ba * dummy_low

reghdfe privacy_violations_1 High_3 Mid_3 Low_3 ///
        dummy_high dummy_mid  dummy_low delta_it_job_ratio ///
        delta_cyber_job_ratio delta_privacy_job_ratio delta_master_phd_ratio ///
        social num_job_posting `control_variables', absorb(naics2_x_fyear gvkey) vce(cl gvkey) 
estimates store model_3


*--------------------------------------------------------
* Model 4: Interact with the Number of Analysts Coverage
*--------------------------------------------------------
use "Fig 4/Stata Data/lightcast_compustat_annual.dta", clear
keep if num_job_posting >= 10
merge 1:1 gvkey fyear using "Fig 4/Stata Data/control_variables.dta", keep(1 2 3) nogenerate
merge 1:1 gvkey fyear using "Fig 4/Stata Data/social_incidents_compustat_freq(panel).dta", keep(1 2 3) nogenerate

sort gvkey fyear
by   gvkey:  gen delta_ai_job_ratio_ba = ai_job_ratio_babina10[_n]  - ai_job_ratio_babina10[_n-3]  if fyear == fyear[_n-3] + 3
by   gvkey:  gen delta_ai_job_ratio_lc = ai_job_ratio_lightcast[_n] - ai_job_ratio_lightcast[_n-3] if fyear == fyear[_n-3] + 3 
by   gvkey:  gen delta_it_job_ratio    = it_job_ratio[_n]           - it_job_ratio[_n-3]           if fyear == fyear[_n-3] + 3
by   gvkey:  gen delta_cyber_job_ratio = cybersecure_job_ratio[_n]  - cybersecure_job_ratio[_n-3]  if fyear == fyear[_n-3] + 3
by   gvkey:  gen delta_privacy_job_ratio = data_privacy_job_ratio[_n]  - data_privacy_job_ratio[_n-3]  if fyear == fyear[_n-3] + 3
by   gvkey:  gen delta_master_phd_ratio  = master_phd_job_ratio[_n] - master_phd_job_ratio[_n-3]   if fyear == fyear[_n-3] + 3

foreach var in privacy_violations {
 quietly replace `var' = 0 if missing(`var')
 quietly sort gvkey fyear
 quietly by   gvkey: gen `var'_1 = ln(1 + `var'[_n+1]) if fyear == fyear[_n+1] - 1
 quietly by   gvkey: gen `var'_2 = ln(1 + `var'[_n+2]) if fyear == fyear[_n+2] - 2
 quietly by   gvkey: gen `var'_3 = ln(1 + `var'[_n+3]) if fyear == fyear[_n+3] - 3
 quietly by   gvkey: gen `var'_4 = ln(1 + `var'[_n+4]) if fyear == fyear[_n+4] - 4
 quietly by   gvkey: gen `var'_5 = ln(1 + `var'[_n+5]) if fyear == fyear[_n+5] - 5
}
foreach var in environment social governance {
 quietly replace `var' = 0 if missing(`var')
 quietly replace `var' = ln(1+`var')
}
replace num_job_posting = ln(num_job_posting)

foreach x in `control_variables' `lightcast_variables' {
 quietly drop if `x' ==.
}

foreach x in `control_variables' `lightcast_variables' {
 quietly trim `x'
 quietly egen `x'_sd = sd(`x')
 quietly replace `x' = `x' / `x'_sd
 quietly drop `x'_sd
}

egen naics2_x_fyear = group(naics2 fyear)
sort gvkey fyear
keep if fyear == fyear[_n+3] - 3

*-------------------------------------------------------------------------------
merge 1:1 gvkey fyear using "Fig 4/Stata Data/analysts_forecast.dta", keep(3) nogenerate
egen xtile_dummy = xtile(numest), nq(5)
gen dummy_high = 0
replace dummy_high = 1 if xtile_dummy == 5
gen dummy_mid  = 0
replace dummy_mid  = 1 if xtile_dummy == 4 | xtile_dummy == 3
gen dummy_low  = 0
replace dummy_low  = 1 if xtile_dummy == 2 | xtile_dummy == 1
gen High_4 = delta_ai_job_ratio_ba * dummy_high
gen Mid_4  = delta_ai_job_ratio_ba * dummy_mid
gen Low_4  = delta_ai_job_ratio_ba * dummy_low

reghdfe privacy_violations_1 High_4 Mid_4 Low_4 ///
        dummy_high dummy_mid  dummy_low delta_it_job_ratio ///
        delta_cyber_job_ratio delta_privacy_job_ratio delta_master_phd_ratio ///
        social num_job_posting `control_variables', absorb(naics2_x_fyear gvkey) vce(cl gvkey) 
estimates store model_4


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

coefplot (model_1, keep(High_1 Mid_1 Low_1) label("Social-Minded Institutional Ownership") msymbol(O) color(ebblue)) ///
         (model_2, keep(High_2 Mid_2 Low_2) label("Num. Past Privacy Incidents") msymbol(D) color(cranberry)) ///
         (model_3, keep(High_3 Mid_3 Low_3) label("Product Market Competition") msymbol(T) color(forest_green)) ///
         (model_4, keep(High_4 Mid_4 Low_4) label("Financial Analysts Coverage") msymbol(X) color(dkorange)) ///
   , vertical ciopts(recast(rcap)) levels(95) ///
   coeflabels(High_1="High" Mid_1="Mid" Low_1="Low" ///
              High_2="High" Mid_2="Mid" Low_2="Low" ///
              High_3="High" Mid_3="Mid" Low_3="Low" ///
              High_4="High" Mid_4="Mid" Low_4="Low") ///
   ytitle("Coefficients and Confidence" "Intervals (95%)") ///
   ylabel(, nogrid) ///
   yline(0, lpattern(blank)) ///
   legend(ring(1) position(6) cols(1) region(lcolor(black))) ///
   title("{bf:b}", position(11) ring(1) span)