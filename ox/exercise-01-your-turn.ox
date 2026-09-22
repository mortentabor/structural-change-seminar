/*  exercise-01-your-turn.ox -- guided exercise: the forecast-error regression with breaks.

    You write the code; the comments tell you what each step should do and what the
    output should look like, so you can check that you got it right.

    The data: forecast-errors.in7 (in this folder) -- the Workshop 1 dataset as an
    OxMetrics database, quarterly 1970(1)-2024(2), with the variables
        error_avg      forecast error (realized inflation - SPF forecast)
        revision_avg   forecast revision
        F_avg, pi_avg, pi_lag
    The regression is the one from Notebook 02 (Coibion-Gorodnichenko):
        error_avg_t+1 = alpha + beta * revision_avg_t + u_t+1

    Requirements: OxMetrics with PcGive, and the OxRegimes package (see README.md).
    Run: open in OxMetrics and press Ctrl+R (Model > Run).

    Everywhere you see  // >>> YOUR CODE HERE  , write one or two lines.
    The solution is in solution-01.ox -- look only after trying.
*/
#include <oxstd.oxh>
#import <packages/PcGive/pcgive_ects>
#import <OxRegimes/oxregimes>

main()
{
    // ---------------------------------------------------------------- step 0
    // Create a Regimes object and load the database forecast-errors.in7.
    // (Two lines: `decl r = new Regimes();` and `r.Load(...)`.)

    // >>> YOUR CODE HERE


    // ---------------------------------------------------------------- step 1
    // Specify the model: error_avg on a constant and revision_avg.
    // Set the sample to 1970(2)-2024(2) and the standard errors to "HAC".
    // Hint: r.Model("...", {"Constant", "..."});  r.SetSample(y1,p1,y2,p2);  r.SetSE("HAC");

    // >>> YOUR CODE HERE


    // ---------------------------------------------------------------- step 2
    // Estimate the model with CONSTANT parameters and print it.
    // Hint: r.Constant("a label").Print();
    //
    // CHECK. You should get, over 1970(2)-2024(2), T = 216:
    //     Constant       -0.0247   (HACSE 0.1267)
    //     revision_avg    1.1198   (HACSE 0.4050)   t = 2.8
    // This is the full-sample rejection of FIRE from Notebook 02: beta is positive
    // and significant. Look at the misspecification tests underneath as well.

    // >>> YOUR CODE HERE


    // ---------------------------------------------------------------- step 3
    // Test for a break at a KNOWN date: the Chow test at 1990(1).
    // Hint: r.Chow(year, period);   -- it prints itself.
    //
    // CHECK: F(2,212) = 0.60 [0.5492]. No break at 1990(1) -- but that is one date
    // out of many. Try a couple of other dates before moving on. Which date would
    // you have guessed, and why?

    // >>> YOUR CODE HERE


    // ---------------------------------------------------------------- step 4
    // Now let the DATA choose the dates: Bai-Perron with at most 5 breaks and 15%
    // trimming. Then print the test output.
    // Hint: decl bp = r.BaiPerron(5, 0.15, {{"label", "BP"}});
    //       r.GetModel("BP").PrintTests();
    //
    // CHECK. The output should show:
    //   - the global minimizers: 1 break at 1980(3); 2 breaks at 1980(3), 1998(3)
    //   - sup F(1|0) = 12.8  (5% critical value 11.47)
    //   - the sequential procedure and BIC both select 2 breaks
    //   - break dates with confidence intervals: 1980(3) [95%: 1980(2)-1982(2)]
    //                                            1998(3) [95%: 1995(3)-1999(3)]
    //   - and the regime table:
    //         alpha:  0.54  /  -0.78  /   0.12
    //         beta:   1.15  /  -0.22  /   1.26
    // Note what that means: beta is NOT one number. Positive in the 1970s,
    // NEGATIVE in 1980-1998, positive again afterwards.

    // >>> YOUR CODE HERE


    // ---------------------------------------------------------------- step 5
    // The other approach: indicator saturation with Autometrics. Use SIS+MIS with a
    // target of 0.1% (0.001) and merge indicators that end up adjacent.
    // Hint: decl sat = r.Saturation("SIS+MIS", 0.001, {{"merge", 2}, {"label", "SIS+MIS"}});
    //       sat.Print();
    //
    // CHECK. Many more (shorter) regimes than Bai-Perron -- and this is the point:
    // the coefficient on the revision is
    //     ~0.69 in 1970(2)-1974(1),  -0.97 in 1974(2)-1977(3),
    //     ~-0.11 (insignificant) for the long stretch 1977(4)-2020(1),
    //     ~4.26 in 2020(2)-2021(3).
    // So the "positive correlation between forecast errors and revisions" that a
    // large theoretical literature sets out to explain is a feature of two short
    // episodes -- not a constant of forecaster behavior.

    // >>> YOUR CODE HERE


    // ---------------------------------------------------------------- step 6
    // Plot the estimates over time: the constant-parameter model, Bai-Perron and
    // the saturation model in one figure, with 95% bands.
    // Hint: RgPlots::EstimatesOverTime({res0, bp, sat}, {}, {{"file", "exercise-01.pdf"}});
    //       (res0 is whatever you called the constant-parameter result in step 2.)

    // >>> YOUR CODE HERE


    // ---------------------------------------------------------------- step 7
    // YOUR TURN, for real. Change something and see what happens:
    //   - a different trimming (0.10 or 0.20) or a different maximum number of breaks;
    //   - a different target for the saturation (0.01, 0.0001);
    //   - only the intercept allowed to break: r.BaiPerron(5, 0.15, {{"break", {"Constant"}}});
    //   - a shorter sample, e.g. 1985(1)-2024(2). Do the breaks survive?
    // Which conclusions are robust to these choices, and which are not?

    // >>> YOUR CODE HERE


    // ---------------------------------------------------------------- step 8
    // Clean up: delete the Regimes object.

    // >>> YOUR CODE HERE
}
