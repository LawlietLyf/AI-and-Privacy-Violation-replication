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
* All Baseline Regressions

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

foreach independent_variable in delta_ai_job_ratio_ba delta_ai_job_ratio_ge {
*---------------------------------------------------------------------------
* Model 1: Long-difference, Poisson regression, privacy violation incidents
*---------------------------------------------------------------------------
use "Fig 4/Stata Data/lightcast_compustat_annual.dta", clear
merge 1:1 gvkey fyear using "Fig 4/Stata Data/genai_panel2.dta", keep(3) nogenerate
gen  generative_ai_ratio = job_genai_score_0 / num_job_posting
keep if num_job_posting >= 10
sort gvkey fyear
by   gvkey: gen delta_ai_job_ratio_ba = ai_job_ratio_babina10[_n+12] - ai_job_ratio_babina10[_n]  ///
            if fyear == 2010 & fyear[_n+12] == 2022
by   gvkey: gen delta_ai_job_ratio_ge = generative_ai_ratio[_n+12]   - generative_ai_ratio[_n] ///
            if fyear == 2010 & fyear[_n+12] == 2022
by   gvkey: gen delta_it_job_ratio    = it_job_ratio[_n+12]          - it_job_ratio[_n] ///
            if fyear == 2010 & fyear[_n+12] == 2022
keep if fyear == 2010 & delta_ai_job_ratio_ba !=.
keep gvkey fyear delta_ai_job_ratio_ba delta_ai_job_ratio_ge delta_it_job_ratio num_job_posting main_county

merge 1:1 gvkey using "Fig 4/Stata Data/control_variables_delta.dta", keep(3) nogenerate
merge 1:1 gvkey using "Fig 4/Stata Data/social_incidents_compustat_freq.dta", keep(3) nogenerate

replace social = ln(1+social)
replace num_job_posting = ln(num_job_posting)

foreach x in `control_variables' {
 quietly drop if `x' ==.
}

foreach x in `control_variables' `lightcast_variables' social num_job_posting {
 quietly trim `x'
 quietly egen `x'_sd = sd(`x')
 quietly replace `x' = `x' / `x'_sd
 quietly drop `x'_sd
}

foreach x in privacy_violations {
 quietly trim `x'
}

rename   `independent_variable' model_1
ppmlhdfe privacy_violations model_1 delta_it_job_ratio social num_job_posting `control_variables', absorb(naics2) vce(cl naics2)
estimates store `independent_variable'_1


*-----------------------------------------------------------------------
* Model 2: Long-difference, 2SLS regression, privacy violation incidents
*-----------------------------------------------------------------------
use "Fig 4/Stata Data/lightcast_compustat_annual.dta", clear
merge 1:1 gvkey fyear using "Fig 4/Stata Data/genai_panel2.dta", keep(3) nogenerate
gen  generative_ai_ratio = job_genai_score_0 / num_job_posting
keep if num_job_posting >= 10
sort gvkey fyear
by   gvkey: gen delta_ai_job_ratio_ba = ai_job_ratio_babina10[_n+12] - ai_job_ratio_babina10[_n]  ///
            if fyear == 2010 & fyear[_n+12] == 2022
by   gvkey: gen delta_ai_job_ratio_ge = generative_ai_ratio[_n+12]   - generative_ai_ratio[_n] ///
            if fyear == 2010 & fyear[_n+12] == 2022
by   gvkey: gen delta_it_job_ratio    = it_job_ratio[_n+12]          - it_job_ratio[_n] ///
            if fyear == 2010 & fyear[_n+12] == 2022
keep if fyear == 2010 & delta_ai_job_ratio_ba !=.
keep gvkey fyear delta_ai_job_ratio_ba delta_ai_job_ratio_ge delta_it_job_ratio num_job_posting main_county

merge 1:1 gvkey using "Fig 4/Stata Data/control_variables_delta.dta",           keep(3) nogenerate
merge 1:1 gvkey using "Fig 4/Stata Data/social_incidents_compustat_freq.dta",   keep(3) nogenerate
merge n:1 main_county using "Fig 4/Stata Data/county_level_controls.dta",       keep(3) nogenerate
merge 1:1 gvkey using "Fig 4/Stata Data/uni_iv.dta",                            keep(3) nogenerate keepusing(uni_iv_v4c uni_cs_v4c uni_top10)

foreach x in privacy_violations num_job_posting social {
 quietly replace `x' = ln(1+`x') /* for 2SLS */
}

foreach x in `control_variables_delta' `control_variables' {
 quietly drop if `x' ==.
}

foreach x in `control_variables_delta' `control_variables' `lightcast_variables' `instrumental_babina' `county_level_controls' {
 quietly trim `x'
 quietly egen `x'_sd = sd(`x')
 quietly replace `x' = `x' / `x'_sd
 quietly drop `x'_sd
}

rename  `independent_variable' model_2
ivreghdfe privacy_violations (model_2 = uni_iv_v4c) uni_cs_v4c uni_top10 delta_it_job_ratio num_job_posting social ///
         `control_variables_delta' `county_level_controls', absorb(naics2) cl(naics2)
estimates store `independent_variable'_2


*------------------------------------------------------------------------
* Model 3: Panel Model, Poisson regression, privacy violation incidents as DV
*------------------------------------------------------------------------
use "Fig 4/Stata Data/lightcast_compustat_annual.dta", clear
merge 1:1 gvkey fyear using "Fig 4/Stata Data/genai_panel2.dta", keep(3) nogenerate
gen  generative_ai_ratio = job_genai_score_0 / num_job_posting
keep if num_job_posting >= 10
merge 1:1 gvkey fyear using "Fig 4/Stata Data/control_variables.dta", keep(1 2 3) nogenerate
merge 1:1 gvkey fyear using "Fig 4/Stata Data/social_incidents_compustat_freq(panel).dta", keep(1 2 3) nogenerate

sort gvkey fyear
by   gvkey:  gen delta_ai_job_ratio_ba = ai_job_ratio_babina10[_n]  - ai_job_ratio_babina10[_n-3]  if fyear == fyear[_n-3] + 3
by   gvkey:  gen delta_ai_job_ratio_ge = generative_ai_ratio[_n]    - generative_ai_ratio[_n-3]    if fyear == fyear[_n-3] + 3 
by   gvkey:  gen delta_it_job_ratio    = it_job_ratio[_n]           - it_job_ratio[_n-3]           if fyear == fyear[_n-3] + 3
by   gvkey:  gen delta_cyber_job_ratio = cybersecure_job_ratio[_n]  - cybersecure_job_ratio[_n-3]  if fyear == fyear[_n-3] + 3
by   gvkey:  gen delta_privacy_job_ratio = data_privacy_job_ratio[_n]  - data_privacy_job_ratio[_n-3]  if fyear == fyear[_n-3] + 3
by   gvkey:  gen delta_master_phd_ratio = master_phd_job_ratio[_n]  - master_phd_job_ratio[_n-3]   if fyear == fyear[_n-3] + 3

foreach var in privacy_violations {
 quietly replace `var' = 0 if missing(`var')
 quietly sort gvkey fyear
 quietly by   gvkey: gen `var'_1 = `var'[_n+1] if fyear == fyear[_n+1] - 1
 quietly by   gvkey: gen `var'_2 = `var'[_n+2] if fyear == fyear[_n+2] - 2
 quietly by   gvkey: gen `var'_3 = `var'[_n+3] if fyear == fyear[_n+3] - 3
 quietly by   gvkey: gen `var'_4 = `var'[_n+4] if fyear == fyear[_n+4] - 4
 quietly by   gvkey: gen `var'_5 = `var'[_n+5] if fyear == fyear[_n+5] - 5
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

rename  `independent_variable' model_3
ppmlhdfe privacy_violations_1 model_3 delta_it_job_ratio delta_cyber_job_ratio delta_privacy_job_ratio ///
   delta_master_phd_ratio num_job_posting `control_variables', absorb(gvkey naics2_x_fyear) vce(cl gvkey) 
estimates store `independent_variable'_3


*---------------------------------------------------------------------------
* Model 4: Long-difference, OLS regression, GDPR Fines as dependent variable
*---------------------------------------------------------------------------
use "Fig 4/Stata Data/lightcast_compustat_annual.dta", clear
merge 1:1 gvkey fyear using "Fig 4/Stata Data/genai_panel2.dta", keep(3) nogenerate
gen  generative_ai_ratio = job_genai_score_0 / num_job_posting
keep if num_job_posting >= 10
sort gvkey fyear
by   gvkey: gen delta_ai_job_ratio_ba = ai_job_ratio_babina10[_n+12] - ai_job_ratio_babina10[_n]  ///
            if fyear == 2010 & fyear[_n+12] == 2022
by   gvkey: gen delta_ai_job_ratio_ge = generative_ai_ratio[_n+12]   - generative_ai_ratio[_n] ///
            if fyear == 2010 & fyear[_n+12] == 2022
by   gvkey: gen delta_it_job_ratio    = it_job_ratio[_n+12]          - it_job_ratio[_n] ///
            if fyear == 2010 & fyear[_n+12] == 2022
keep if fyear == 2010 & delta_ai_job_ratio_ba !=.
keep gvkey fyear delta_ai_job_ratio_ba delta_ai_job_ratio_ge delta_it_job_ratio num_job_posting main_county

merge 1:1 gvkey using "Fig 4/Stata Data/control_variables_delta.dta", keep(3)   nogenerate
merge 1:1 gvkey using "Fig 4/Stata Data/factset_geo_europe.dta"     , keep(1 3) nogenerate
merge 1:1 gvkey using "Fig 4/Stata Data/gdpr_with_gvkey.dta"        , keep(1 3) nogenerate
replace est_percent = 0 if missing(est_percent)        /* est_percent = firm's sales percentage in Europe */
bys naics2: egen est_percent_mean = mean(est_percent)
replace est_percent = (est_percent - est_percent_mean) /* industry-adjusted */

gen     log_fine = 0
replace log_fine = log(Fine) if Fine > 0 & Fine !=.
replace num_job_posting = ln(num_job_posting)

foreach x in `control_variables_2' {
 quietly drop if `x' ==.
}

foreach x in `control_variables_2' `lightcast_variables' num_job_posting {
 quietly trim `x'
 quietly egen `x'_sd = sd(`x')
 quietly replace `x' = `x' / `x'_sd
 quietly drop `x'_sd
}

rename  `independent_variable' model_4
reghdfe log_fine model_4 delta_it_job_ratio num_job_posting, absorb(naics2)
estimates store `independent_variable'_4
}


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

coefplot (delta_ai_job_ratio_ba_1 delta_ai_job_ratio_ba_2 delta_ai_job_ratio_ba_3 delta_ai_job_ratio_ba_4, ///
            label("AI") msymbol(O) color(ebblue)) ///
         (delta_ai_job_ratio_ge_1 delta_ai_job_ratio_ge_2 delta_ai_job_ratio_ge_3 delta_ai_job_ratio_ge_4, ///
            label("Generative AI") msymbol(D) color(cranberry)) ///
   , keep(model_1 model_2 model_3 model_4) vertical ciopts(recast(rcap)) levels(95) ///
   coeflabels(model_1="Model 1" model_2="Model 2" model_3="Model 3" model_4="Model 4") ///
   ytitle("Coefficients and Confidence" "Intervals (95%)") ///
   ylabel(, nogrid) ///
   legend(ring(0) position(2) rows(1) region(lcolor(black))) ///
   title("{bf:a}", position(11) ring(1) span) ///
   yline(0, lpattern(blank))