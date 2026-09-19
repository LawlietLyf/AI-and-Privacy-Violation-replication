********************************************************************************
* Codes are prepared for Stata 17.0 MP
********************************************************************************
set mem 1700m
set more off
set matsize 3000
clear all
* Run from the package root (the directory containing run.do).
use "Fig 2/Data/fig2_data.dta", clear
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
 
twoway (bar violation_score group_pos if category==1, horizontal barwidth(1.5) color("55 126 184")) ///
(bar violation_score group_pos if category==2, horizontal barwidth(1.5) color("77 175 74")) ///
(bar violation_score group_pos if category==3, horizontal barwidth(1.5) color("255 224 0") ) ///
(bar violation_score group_pos if category==4, horizontal barwidth(1.5) color("228 26 28")) ///
(bar violation_score group_pos if category==5, horizontal barwidth(1.5) color("152 78 163")) ///
(bar violation_score group_pos if category==6, horizontal barwidth(1.5) color("255 127 0")) ///
	   (rcap cilb ciub group_pos, horizontal lwidth(medium) lcolor(black%75) lpattern(dash)), ///
       ytitle("") ///
       xlabel(0(20)110) ///
       ylabel(1(2)33, valuelabel angle(0) labsize(small) noticks) ///
       yscale(reverse noline) ///
       xtitle("Violation Score") ///
       by(panel, rows(1) note("") legend(off))  ///
       graphregion(margin(0)) plotregion(margin(0)) ///
	   legend(off)

	   