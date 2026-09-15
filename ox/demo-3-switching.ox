/*  demo-3-switching.ox -- Workshop 3, segment 3: the Markov-switching progression.

    1. K = 2 imposed (after the whiteboard): y_t = alpha(s_t) + beta(s_t) x_t + e_t,
       with unobserved regime s_t following a Markov chain. The data returns the
       probability of each regime at every date -- no dates chosen, no dates imposed.
    2. Selecting K: estimate K = 1, 2, 3 and compare by information criteria.

    Requires workshop3-data.in7 (run demo-0-data.ox first).
    Run from OxMetrics (Model > Run, Ctrl+R) or:  oxl demo-3-switching.ox
*/
#include <oxstd.oxh>
#include <oxdraw.oxh>
#import <packages/PcGive/pcgive_ects>
#import <OxRegimes/oxregimes>

main()
{
    decl r = new Regimes();
    r.Load("workshop3-data.in7");
    r.Model("y", {"Constant", "x"});                 // the model: y on a constant and x

    // ------------------------------------------------ 1. K = 2 imposed
    // Switching(2) estimates the model with 2 regimes by maximum likelihood:
    // all coefficients (and sigma) may differ across regimes, and the regime
    // follows a Markov chain with estimated transition probabilities.
    // Nothing about DATES is imposed or estimated -- the regimes are free to
    // come and go; the data returns P(regime k) at every date.
    println("==== 1. Markov switching with K = 2 regimes ====\n");
    decl ms2 = r.Switching(2, {{"label", "MS(2)"}});
    ms2.Print();
    // In the output: regime-by-regime coefficients (compare with the DGP), and the
    // "break date" -- here simply the date where the most likely regime changes.

    // The regime probabilities over time: one panel per regime, the smoothed
    // P(regime k at date t), with the most-likely-regime periods shaded.
    // THIS is the method's genuine output -- probabilities, not dates.
    RgPlots::Probabilities(ms2, {{"file", "demo-3-probs.pdf"}});

    // ------------------------------------------------ 2. selecting K
    // How many regimes? Estimate K = 1, 2, 3 (kmax) and compare information
    // criteria. More regimes ALWAYS fit better in-sample -- the criteria charge a
    // price per extra parameter (coefficients, sigma, transition probabilities).
    // Switching(0, ...) with "kmax"/"select" runs the whole comparison and prints
    // the table; "sc" = the Schwarz criterion does the choosing.
    println("\n==== 2. How many regimes? Compare K = 1, 2, 3 ====\n");
    r.Switching(0, {{"kmax", 3}, {"select", "sc"}, {"label", "MS"}});
    println("\nThe information criteria pick the number of regimes; more regimes always fit");
    println("better in-sample, so the criteria penalize the extra parameters.");

    // ---- estimates over time vs. the DGP ----------------------------------
    // The coefficient of the MOST LIKELY regime at each date ("argmax path"),
    // with 95% bands, and the true DGP path overlaid. Does the DGP lie inside?
    decl vS = range(0, 199)' .>= 100;                // DGP: break at obs 100 = 2000(1)
    RgPlots::EstimatesOverTime({ms2}, {},
        {{"file", "demo-3-estimates.pdf"},
         {"reference", (1 + 2 * vS)' | (0.5 + 1.5 * vS)'}, {"referencelabel", "DGP"},
         {"title", {"Intercept over time: Markov switching vs. DGP", "Slope on x over time: Markov switching vs. DGP"}}});

    delete r;
}
