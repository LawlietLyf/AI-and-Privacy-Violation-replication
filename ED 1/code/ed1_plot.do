* Extended Data Figure 1a: each point is one independent Yes/No response.
* Run from the package root; optionally supply a new results.csv.
version 17.0
clear all
set more off
capture mkdir "outputs/plot_results"
capture mkdir "outputs/plot_results/ed1"
* 1. Preserve quoted explanations, including embedded line breaks.
import delimited using "ED 1\data\results_rand.csv", varnames(1) stringcols(_all) ///
    bindquote(strict) maxquotedrows(100) clear
gen long query_id=_n
destring bonus punish, replace force

* 2. Read only the leading answer, not Yes/No words inside the explanation.
gen str3 answer=""
replace answer="Yes" if ustrregexm(ustrlower(ustrtrim(score)), ///
    "^[[:space:][:punct:]]*yes([[:space:][:punct:]]|$)")
replace answer="No" if ustrregexm(ustrlower(ustrtrim(score)), ///
    "^[[:space:][:punct:]]*no([[:space:][:punct:]]|$)")
gen str20 parse_status="ok"
replace parse_status="unparsed_response" if answer==""
replace parse_status="invalid_incentive" if missing(bonus,punish) | bonus<0 | punish<0
tabulate parse_status, missing
tabulate answer if parse_status=="ok", missing
// export delimited query_id bonus punish answer parse_status using ///
//     "outputs/plot_results/ed1/answers.csv", replace
// count if parse_status=="ok"
// if r(N)==0 {
//     display as error "No valid Yes/No responses with nonnegative incentives."
//     exit 2000
// }

* 3. Default axes match the paper. Larger alternative incentives are not clipped.
quietly summarize bonus if parse_status=="ok"
local axis_max=max(10000,ceil(r(max)/10000)*10000)
quietly summarize punish if parse_status=="ok"
local axis_max=max(`axis_max',ceil(r(max)/10000)*10000)
local axis_step=`axis_max'/5
set scheme s1color
twoway ///
    (scatter bonus punish if answer=="Yes" & parse_status=="ok", ///
        msymbol(circle) mcolor(red) msize(0.3)) ///
    (scatter bonus punish if answer=="No" & parse_status=="ok", ///
        msymbol(circle) mcolor(blue) msize(0.3)) ///
    (function y=x, range(0 `axis_max') lcolor(green) lpattern(dash) lwidth(thin)), ///
    xlabel(0(`axis_step')`axis_max', nogrid) ylabel(0(`axis_step')`axis_max', nogrid angle(0)) ///
    xscale(range(0 `axis_max')) yscale(range(0 `axis_max')) ///
    xtitle("Punish") ytitle("Bonus") ///
    legend(order(1 "Yes" 2 "No") rows(1) position(6)) ///
    graphregion(color(white)) plotregion(color(white)) xsize(8) ysize(6)

