
* Run from the package root (the directory containing run.do).
use "Fig 3/c/data/fig3c_data.dta", clear
set scheme s1color

* graphing
twoway (bar coefficient order  if  experiment=="raw",  color("77 175 74" ) barwidth(0.7) lcolor(gs8) lwidth(0.3)) ///
		(bar coefficient order  if  experiment=="HH_tuned" ,  color("255 127 0") barwidth(0.7) lcolor(gs8) lwidth(0.3)) ///
		(bar coefficient order  if  experiment=="sft_tuned" , color("55 126 184")   barwidth(0.7) lcolor(gs8) lwidth(0.3)) ///
		(bar coefficient order  if  experiment=="GDPR_tuning" , color("228 26 28")  barwidth(0.7) lcolor(gs8) lwidth(0.3)) ///
		(rcap cilb ciub order,  lwidth(medium) lcolor(black%75) lpattern(dash)), ///
             xlabel(-0.25 "Baseline" ///
			        1.75 "HH" ///
					3.75 "Counterfact" ///
					5.75 "Knowledge", ///
                    labsize(2.8)  noticks angle(0)) ///
             ytitle("Violation Score",size(*1.2)) ///
             xtitle("") ///
			     graphregion(color(white) margin(small)) ///
    plotregion(color(white) margin(small)) ///
             legend(off) ///
			 scale(1.2)
				

				
				

				