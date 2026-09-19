clear all
* Run from the package root (the directory containing run.do).
use "Fig 3/b/data/fig3b_data.dta", clear
twoway ///
    (rcap cilb ciub round, lwidth(medium) lcolor(black%75) lpattern(dash)) ///
    (connected coefficient round if sample=="good", ///
        color("228 26 28") lpattern(solid) lwidth(medthick) ///
        msymbol(circle) msize(medium) mcolor("228 26 28")) ///
    (connected coefficient round if sample=="normal", ///
        color("77 175 74") lpattern(longdash) lwidth(medthick) ///
        msymbol(sh) msize(medium) mcolor("77 175 74")) ///
    (connected coefficient round if sample=="bad", ///
        color("55 126 184") lpattern(shortdash) lwidth(medthick) ///
        msymbol(th) msize(medium) mcolor("55 126 184")) ///
    , ///
    legend(order(2 "Privacy-preserving" 3 "Neutral" 4 "Performance-maximizing") ///
           ring(1) pos(6) rows(1) ///
           region(lcolor(none))  /// 
           size(small))         ///
    ytitle("Violation Score", size(medium)) ///
    xtitle("Round", size(medium)) ///
    yline(0, lpattern(dot) lcolor(gs8)) /// 
    ylabel(, angle(0) nogrid) /// 
    graphregion(color(white) margin(small)) ///
    plotregion(color(white) margin(small)) ///
    scale(1.15) 




