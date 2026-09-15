/*  demo-1-baiperron.ox -- Workshop 3, segment 1: the Bai-Perron progression.

    1. tau KNOWN:   impose the break at 2000(1) (regime model, no search), and TEST
       for a break at the known date: the Chow (1960) F-test, standard critical values.
    2. one break, tau UNKNOWN: the same statistic at every admissible date; the
       largest is the sup-F statistic (= the smallest-SSR split) -- searched critical
       values. The BreakProfile plot shows the whole search.
    3. multiple breaks: same idea, dates chosen jointly; just show the result.

    Requires workshop3-data.in7 (run demo-0-data.ox first).
    Run from OxMetrics (Model > Run, Ctrl+R) or:  oxl demo-1-baiperron.ox
*/
#include <oxstd.oxh>
#import <packages/PcGive/pcgive_ects>
#import <OxRegimes/oxregimes>

main()
{
    decl r = new Regimes();
    r.Load("workshop3-data.in7");
    r.Model("y", {"Constant", "x"});                 // the model: y on a constant and x

    // ------------- 1. tau KNOWN: impose the break at 2000(1), estimate, and test
    // Breaks({year, period}) estimates the regime model at the GIVEN date -- no search.
    // The output is one table with separate estimates for each regime.
    // Compare with the DGP: alpha 1.0 -> 3.0, beta 0.5 -> 2.0.
    println("\n\n\n\n==== 1. One break at a KNOWN date, 2000(1): estimate and test ====\n");
    r.Breaks({2000, 1}, {{"label", "Known break at 2000(1)"}}).Print();
    println("");
    // The Chow test asks: is the improvement in fit from allowing the break
    // larger than chance? H0: no break at 2000(1), i.e. alpha1 = alpha2, beta1 = beta2.
    // It is an ordinary F-test -- with q = 2 breaking coefficients:
    //   F = ((SSR_nobreak - SSR_break)/q) / (SSR_break/(T - 2q)),
    // compared with standard F critical values, BECAUSE the date was known in advance.
    r.Chow(2000, 1);

    // -------- 2. tau UNKNOWN: the same statistic at every admissible date
    // Nobody tells us tau. Bai-Perron: trim the sample ends (15% here, so every
    // regime has at least 30 observations), compute the break statistic at EVERY
    // admissible date, and take the largest -- the sup-F statistic. Its date is the
    // estimated break (equivalently: the split with the smallest SSR).
    // Searching changes the critical values: under H0 (no break) SOME date always
    // fits best, so the sup-F critical values are roughly twice the Chow values.
    // BaiPerron(max breaks, trimming): here max 1 break, 15% trimming.
    println("\n\n\n\n==== 2. One break at UNKNOWN date: search every admissible date ====\n");
    decl bp = r.BaiPerron(1, 0.15, {{"label", "BP: one break"}});
    r.GetModel("BP: one break").PrintTests();
    // In the output, note: (i) the sup F test vs. its critical values;
    // (ii) the break date with a CONFIDENCE INTERVAL -- a break date is an estimate
    // too, and the interval need not be symmetric (the two regimes need not be
    // equally informative about a mislocated break).

    // The whole search in one picture: SSR and the break statistic at every
    // admissible date, trimming zones shaded, with BOTH critical values --
    // known-date (Chow) and searched (sup-F). "chow" plots on the F scale.
    RgPlots::BreakProfile(bp, {{"file", "demo-1-ssr.pdf"}, {"statistic", "chow"}});

    // --------------------------------- 3. multiple breaks: the general procedure
    // Same idea for several breaks, with the dates chosen JOINTLY. The number of
    // breaks is picked by sequential sup F(l+1|l) tests or an information
    // criterion (BIC/LWZ). Watch the output: the 2- and 3-break candidates barely
    // improve the fit, and every selection rule settles on ONE break at 2000(1).
    println("\n\n\n\n==== 3. Multiple breaks: same idea, dates chosen jointly ====\n");
    r.BaiPerron(3, 0.15, {{"label", "BP: up to three breaks"}});
    r.GetModel("BP: up to three breaks").PrintTests();

    // ---- estimates over time vs. the DGP ----------------------------------
    // The parameter path implied by the estimated break, with 95% bands, and the
    // true DGP path overlaid ("reference"). Does the DGP lie inside the bands?
    decl vS = range(0, 199)' .>= 100;                // DGP: break at obs 100 = 2000(1)
    RgPlots::EstimatesOverTime({bp}, {},
        {{"file", "demo-1-estimates.pdf"},
         {"reference", (1 + 2 * vS)' | (0.5 + 1.5 * vS)'}, {"referencelabel", "DGP"},
         {"title", {"Intercept over time: Bai-Perron vs. DGP", "Slope on x over time: Bai-Perron vs. DGP"}}});

    delete r;
}
