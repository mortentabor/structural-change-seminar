/*  demo-2-autometrics.ox -- Workshop 3, segment 2: the indicator-saturation progression.

    1. tau KNOWN (after the whiteboard derivation): one full-sample regression with
       the step indicator S2000Q1 and the multiplicative indicator S2000Q1_x -- the
       coefficients on the indicators ARE the sizes of the shifts.
    2. tau UNKNOWN: saturate with an indicator at EVERY date (SIS + MIS) and let
       Autometrics keep the ones the data demands. Target 0.1%: the target is the
       share of indicators retained BY CHANCE -- with ~400 candidates, 1% would
       retain ~4 false steps, 0.1% ~0.4. (The target is a design choice.)

    Requires workshop3-data.in7 (run demo-0-data.ox first).
    Run from OxMetrics (Model > Run, Ctrl+R) or:  oxl demo-2-autometrics.ox
*/
#include <oxstd.oxh>
#include <oxdraw.oxh>
#import <packages/PcGive/pcgive_ects>
#import <OxRegimes/oxregimes>

main()
{
    decl r = new Regimes();
    r.Load("workshop3-data.in7");

    // ---------------- 1. tau KNOWN: the whiteboard equation, estimated by OLS
    // The two-regime model written as ONE regression on the full sample.
    // S2000Q1   = 1(t >= 2000Q1)        -- a step indicator (0s, then 1s): shifts the intercept
    // S2000Q1_x = 1(t >= 2000Q1) * x_t  -- a multiplicative indicator: shifts the slope
    // Both are ordinary columns in the database (look at them in OxMetrics!),
    // so the "break model" is just OLS with two extra regressors.
    println("\n\n\n\n==== 1. We KNOW tau: the break as indicator variables ====\n");
    println("   y_t = a1 + (a2-a1) S2000Q1_t + b1 x_t + (b2-b1) S2000Q1_t x_t + e_t\n");
    r.Model("y", {"Constant", "S2000Q1", "x", "S2000Q1_x"});
    r.Constant("Known tau: indicator regression").Print();
    // Read the output: the coefficient on S2000Q1 estimates a2-a1, the one on
    // S2000Q1_x estimates b2-b1 -- and each has a standard error and a t-test.
    println("The indicator coefficients are the SHIFTS: DGP a2-a1 = 2.0, b2-b1 = 1.5\n");

    // ---------------- 2. tau UNKNOWN: saturation + Autometrics selection
    // Now drop the two hand-made indicators and let the data choose: put a step
    // indicator (SIS) and a multiplicative indicator (MIS) at EVERY possible date
    // -- ~400 candidate regressors, more than the 200 observations! -- and let
    // Autometrics (the model-selection algorithm you know from Econometrics II)
    // keep only the indicators the data demands.
    //   "SIS+MIS"  which indicator types to include
    //   0.001      the target: the share of candidate indicators retained by chance
    //   "verbose"/"print"  show Autometrics' search output (block search, GUM, terminals)
    println("\n\n\n\n==== 2. tau UNKNOWN: an indicator at EVERY date, Autometrics selects ====\n");
    r.Model("y", {"Constant", "x"});
    decl sat = r.Saturation("SIS+MIS", 0.001, {{"verbose", TRUE}, {"print", 1}, {"label", "Autometrics SIS+MIS"}});
    sat.Print();

    // ---- estimates over time vs. the DGP ----------------------------------
    // The parameter path implied by the retained indicators, with 95% bands, and
    // the true DGP path overlaid. Does the DGP lie inside the bands?
    decl vS = range(0, 199)' .>= 100;                      // DGP: break at 2000(1)
    RgPlots::EstimatesOverTime({sat}, {},
        {{"file", "demo-2-estimates.pdf"},
         {"reference", (1 + 2 * vS)' | (0.5 + 1.5 * vS)'}, {"referencelabel", "DGP"},
         {"title", {"Intercept over time: Autometrics SIS+MIS vs. DGP", "Slope on x over time: Autometrics SIS+MIS vs. DGP"}}});

    delete r;
}
