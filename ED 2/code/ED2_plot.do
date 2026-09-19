clear all
* Run from the package root (the directory containing run.do).
use "ED 2/data/ED2_data.dta", clear
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
twoway 	(bar violation_score group_pos if test != "Nonsense", ///
        horizontal barwidth(0.5) base(0) color(red%50)) ///
		(bar violation_score group_pos if test == "Nonsense", ///
	horizontal barwidth(0.5) base(0) color(red%20)) ///
		(rcap ciub cilb group_pos if privacy_test == "Data Processing", ///
         horizontal lwidth(medium) lcolor(black%75) lpattern(dash)), ///
    ylabel( ///
	0.8  "GPT-3.5" ///
    2.8  "GPT-4o" ///
	4.8  "GPT-5" ///
    6.8  "Qwen Turbo" ///
    8.8  "Qwen Plus" ///
    10.8 "DeepSeek 1.5B" ///
    12.8 "DeepSeek 7B" ///
    14.8 "DeepSeek 14B" ///
    16.8 "DeepSeek 32B" ///
    18.8 "DeepSeek 671B" ///
    20.8 "Llama 3.1" ///
    22.8 "Llama 4" ///
    24.8 "Claude-3.5" ///
    26.8 "Claude-4.6" ///
    28.8 "Gemini-1.5" ///
	30.8 "Gemini-2.0" ///
    32.8 "Gemini-3.0", valuelabel angle(0) labsize(*0.8) noticks) ///
    ytitle("Violation Score", size(*1.0)) ///
    xtitle("", size(*1.0)) ///
	ytitle("") ///
	xsize(10) ysize(6) ///
	legend(order(1 "Baseline" 2 "Nonsense"))	

				