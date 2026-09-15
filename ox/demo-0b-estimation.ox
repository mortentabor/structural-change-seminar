/*  demo-0b-estimation.ox -- Workshop 3, segment 0b: the same estimations in code, twice.

    After estimating the constant-parameter model by hand in OxMetrics, this script
    shows how to do the SAME estimations in Ox code:

    Part A -- with PcGive, the package you know (this is exactly the "batch code"
              OxMetrics can generate for any model you estimate by clicking):
              1. constant-parameter model, full sample 1975(1)-2024(4)
              2. regime 1 only: 1975(1)-1999(4)
              3. regime 2 only: 2000(1)-2024(4)
    Part B -- the same three with the OxRegimes package: one model spec, change
              the sample. Same numbers, less code -- and the same object later runs
              Bai-Perron, Autometrics saturation, and Markov switching.
    Part C -- rolling-window estimates: how the parameters LOOK over time before
              any formal method is applied. Figure only.

    Requires workshop3-data.in7 (run demo-0-data.ox first).
    Run from OxMetrics (Model > Run, Ctrl+R) or:  oxl demo-0b-estimation.ox
*/
#include <oxstd.oxh>
#import <packages/PcGive/pcgive_ects>
#import <OxRegimes/oxregimes>

main()
{
    // ================= Part A: PcGive =================
    // The workflow mirrors the OxMetrics menus, step by step:
    // create a model object -> load data -> choose variables -> sample -> method -> estimate.
    println("\n\n\n\n==== A. PcGive: constant parameters, full sample ====");
    decl model = new PcGive();
    model.Load("workshop3-data.in7");
    model.Deterministic(-1);                 // creates the Constant (and trend/seasonals),
                                             //   just like OxMetrics does behind the scenes

    model.Select(Y_VAR, {"y", 0, 0});        // the dependent variable; {name, first lag, last lag}
    model.Select(X_VAR, {"Constant", 0, 0}); // regressors, one Select per variable
    model.Select(X_VAR, {"x", 0, 0});        //   (lags 0,0 = only the current value)

    model.SetSelSample(1975, 1, 2024, 4);    // estimation sample: year, period, year, period
    model.SetMethod(M_OLS);                  // ordinary least squares
    model.Estimate();                        // prints the full PcGive output you know --
                                             //   note the misspecification tests at the end!

    // Same model, subsamples only: just reset the sample and re-estimate.
    // Compare the two regimes' estimates with the full-sample ones above.
    println("\n\n==== A. PcGive: regime 1 only, 1975(1)-1999(4) ====");
    model.SetSelSample(1975, 1, 1999, 4);
    model.Estimate();

    println("\n\n==== A. PcGive: regime 2 only, 2000(1)-2024(4) ====");
    model.SetSelSample(2000, 1, 2024, 4);
    model.Estimate();

    delete model;

    // ================= Part B: OxRegimes =================
    // The same three estimations. The model is specified ONCE with Model();
    // Constant() estimates it with constant parameters on the current sample.
    println("\n\n\n\n==== B. OxRegimes: the same three estimations ====");
    decl r = new Regimes();
    r.Load("workshop3-data.in7");
    r.Model("y", {"Constant", "x"});         // the model spec: y on a constant and x

    r.Constant("Full sample").Print();       // estimate + print (label appears in the output)

    r.SetSample(1975, 1, 1999, 4);           // change the sample ...
    r.Constant("Regime 1: 1975(1)-1999(4)").Print();

    r.SetSample(2000, 1, 2024, 4);           // ... and again
    r.Constant("Regime 2: 2000(1)-2024(4)").Print();

    // ====== Part C: rolling-window estimates (figure only, with 95% bands) ======
    // A 40-quarter window slides through the sample; the model is re-estimated in
    // each window. Watch how a SHARP break at 2000Q1 becomes a 10-year RAMP in the
    // rolling estimates: every window that straddles the break mixes the two regimes.
    // (Each estimate is plotted at the END of its window.)
    r.SetSample(1975, 1, 2024, 4);           // back to the full sample
    decl roll = r.Rolling(40, "Rolling, 40-quarter window");
    RgPlots::EstimatesOverTime({roll}, {},
        {{"file", "demo-0b-rolling.pdf"},
         {"title", {"Intercept: rolling estimate with 95% band", "Slope on x: rolling estimate with 95% band"}}});

    delete r;
}
