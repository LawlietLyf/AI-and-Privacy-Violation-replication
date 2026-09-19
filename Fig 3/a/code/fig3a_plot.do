/*==============================================================================
  RCT Results
  2x2 Panel Figure: Four Tests × Six Models
==============================================================================*/

* Run from the package root (the directory containing run.do).
use "Fig 3/a/data/fig3a_data.dta", clear
local color_gpt "55 126 184"
local color_qwen "77 175 74"
local color_deepseek "255 224 0"
local color_gemini "255 127 0"
local color_claude "152 78 163"
local color_llama "228 26 28"

// Graph scheme
set scheme s1color

/*==============================================================================
  Four panels (2x2 layout)
==============================================================================*/

// Bonus test
twoway ///
    (bar abs_did pos if test == "Bonus" & model == "gpt-4o-mini", ///
        barwidth(0.7) color("`color_gpt'") lcolor(gs8) lwidth(0.3)) ///
    (bar abs_did pos if test == "Bonus" & model == "qwen-turbo", ///
        barwidth(0.7) color("`color_qwen'") lcolor(gs8) lwidth(0.3)) ///
	(bar abs_did pos if test == "Bonus" & model == "deepseek-chat", ///
        barwidth(0.7) color("`color_deepseek'") lcolor(gs8) lwidth(0.3)) ///
    (bar abs_did pos if test == "Bonus" & model == "gemini-2.0-flash-001", ///
        barwidth(0.7) color("`color_gemini'") lcolor(gs8) lwidth(0.3)) ///
    (bar abs_did pos if test == "Bonus" & model == "claude-3.5-haiku", ///
        barwidth(0.7) color("`color_claude'") lcolor(gs8) lwidth(0.3)) ///
    (bar abs_did pos if test == "Bonus" & model == "llama-3.1-70b-instruct", ///
        barwidth(0.7) color("`color_llama'") lcolor(gs8) lwidth(0.3)) ///
    (rcap ci_lower ci_upper pos if test == "Bonus", ///
        lwidth(medium) lcolor(black%75) lpattern(dash)), ///
    xlabel(1 "GPT" 2 "Qwen" 3 "DS" 4 "Gemini" 5 "Claude" 6 "Llama", ///
        labsize(2.8) noticks angle(0)) ///
    xtitle("") ///
    ytitle("Treatment Effect", size(2.8) margin(small)) ///
    ylabel(0(5)35, labsize(2.5) angle(0) format(%3.0f) nogrid) ///
    title("{bf:Bonus Reduction}", size(3.2) pos(11) justification(left)) ///
    graphregion(color(white) margin(small)) ///
    plotregion(color(white) margin(small)) ///
    legend(off) ///
    name(bonus, replace) ///
    scale(1.2)

// Punishment test  
twoway ///
    (bar abs_did pos if test == "Punishment" & model == "gpt-4o-mini", ///
        barwidth(0.7) color("`color_gpt'") lcolor(gs8) lwidth(0.3)) ///
    (bar abs_did pos if test == "Punishment" & model == "qwen-turbo", ///
        barwidth(0.7) color("`color_qwen'") lcolor(gs8) lwidth(0.3)) ///
		(bar abs_did pos if test == "Punishment" & model == "deepseek-chat", ///
        barwidth(0.7) color("`color_deepseek'") lcolor(gs8) lwidth(0.3)) ///
    (bar abs_did pos if test == "Punishment" & model == "gemini-2.0-flash-001", ///
        barwidth(0.7) color("`color_gemini'") lcolor(gs8) lwidth(0.3)) ///
    (bar abs_did pos if test == "Punishment" & model == "claude-3.5-haiku", ///
        barwidth(0.7) color("`color_claude'") lcolor(gs8) lwidth(0.3)) ///
    (bar abs_did pos if test == "Punishment" & model == "llama-3.1-70b-instruct", ///
        barwidth(0.7) color("`color_llama'") lcolor(gs8) lwidth(0.3)) ///
    (rcap ci_lower ci_upper pos if test == "Punishment", ///
        lwidth(medium) lcolor(black%75) lpattern(dash)), ///
    xlabel(1 "GPT" 2 "Qwen" 3 "DS" 4 "Gemini" 5 "Claude" 6 "Llama", ///
        labsize(2.8) noticks angle(0)) ///
    xtitle("") ///
    ytitle("Treatment Effect", size(2.8) margin(small)) ///
    ylabel(0(5)35, labsize(2.5) angle(0) format(%3.0f) nogrid) ///
    title("{bf:Punishment Increase}", size(3.2) pos(11) justification(left)) ///
    graphregion(color(white) margin(small)) ///
    plotregion(color(white) margin(small)) ///
    legend(off) ///
    name(punishment, replace) ///
    scale(1.2)

// Detection test
twoway ///
    (bar abs_did pos if test == "Detection" & model == "gpt-4o-mini", ///
        barwidth(0.7) color("`color_gpt'") lcolor(gs8) lwidth(0.3)) ///
    (bar abs_did pos if test == "Detection" & model == "qwen-turbo", ///
        barwidth(0.7) color("`color_qwen'") lcolor(gs8) lwidth(0.3)) ///
	(bar abs_did pos if test == "Detection" & model == "gemini-2.0-flash-001", ///
        barwidth(0.7) color("`color_gemini'") lcolor(gs8) lwidth(0.3)) ///
    (bar abs_did pos if test == "Detection" & model == "deepseek-chat", ///
        barwidth(0.7) color("`color_deepseek'") lcolor(gs8) lwidth(0.3)) ///
    (bar abs_did pos if test == "Detection" & model == "claude-3.5-haiku", ///
        barwidth(0.7) color("`color_claude'") lcolor(gs8) lwidth(0.3)) ///
    (bar abs_did pos if test == "Detection" & model == "llama-3.1-70b-instruct", ///
        barwidth(0.7) color("`color_llama'") lcolor(gs8) lwidth(0.3)) ///
    (rcap ci_lower ci_upper pos if test == "Detection", ///
        lwidth(medium) lcolor(black%75) lpattern(dash)), ///
    xlabel(1 "GPT" 2 "Qwen" 3 "DS" 4 "Gemini" 5 "Claude" 6 "Llama", ///
        labsize(2.8) noticks angle(0)) ///
    xtitle("") ///
    ytitle("Treatment Effect", size(2.8) margin(small)) ///
    ylabel(0(5)35, labsize(2.5) angle(0) format(%3.0f) nogrid) ///
    title("{bf:Detection Enhancement}", size(3.2) pos(11) justification(left)) ///
    graphregion(color(white) margin(small)) ///
    plotregion(color(white) margin(small)) ///
    legend(off) ///
    name(detection, replace) ///
    scale(1.2)

// Policy test
twoway ///
    (bar abs_did pos if test == "Policy" & model == "gpt-4o-mini", ///
        barwidth(0.7) color("`color_gpt'") lcolor(gs8) lwidth(0.3)) ///
    (bar abs_did pos if test == "Policy" & model == "qwen-turbo", ///
	        barwidth(0.7) color("`color_qwen'") lcolor(gs8) lwidth(0.3)) ///
    (bar abs_did pos if test == "Policy" & model == "deepseek-chat", ///
        barwidth(0.7) color("`color_deepseek'") lcolor(gs8) lwidth(0.3)) ///
    (bar abs_did pos if test == "Policy" & model == "gemini-2.0-flash-001", ///
        barwidth(0.7) color("`color_gemini'") lcolor(gs8) lwidth(0.3)) ///
    (bar abs_did pos if test == "Policy" & model == "claude-3.5-haiku", ///
        barwidth(0.7) color("`color_claude'") lcolor(gs8) lwidth(0.3)) ///
    (bar abs_did pos if test == "Policy" & model == "llama-3.1-70b-instruct", ///
        barwidth(0.7) color("`color_llama'") lcolor(gs8) lwidth(0.3)) ///
    (rcap ci_lower ci_upper pos if test == "Policy", ///
       lwidth(medium) lcolor(black%75) lpattern(dash)), ///
    xlabel(1 "GPT" 2 "Qwen" 3 "DS" 4 "Gemini" 5 "Claude" 6 "Llama", ///
        labsize(2.8) noticks angle(0)) ///
    xtitle("") ///
    ytitle("Treatment Effect", size(2.8) margin(small)) ///
    ylabel(0(5)35, labsize(2.5) angle(0) format(%3.0f) nogrid) ///
    title("{bf:Policy Strictness}", size(3.2) pos(11) justification(left)) ///
    graphregion(color(white) margin(small)) ///
    plotregion(color(white) margin(small)) ///
    legend(off) ///
    name(policy, replace) ///
    scale(1.2)

/*==============================================================================
  Combine panels
==============================================================================*/

graph combine bonus punishment detection policy, ///
    cols(2) rows(2) ///
    imargin(small) ///
    graphregion(color(white) margin(medium)) ///
    title("", size(large))
	

* run.do saves and exports the combined figure to outputs/.
