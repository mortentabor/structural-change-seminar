/*  demo-0-data.ox -- Workshop 3, segment 0: simulate the data, save it, show it.

    DGP -- the data-generating process, the "truth" every method must find:
        y_t = 1.0 + 0.5 x_t + eps_t   before 2000(1)      (alpha1 = 1.0, beta1 = 0.5)
        y_t = 3.0 + 2.0 x_t + eps_t   from   2000(1)      (alpha2 = 3.0, beta2 = 2.0)
    with x_t ~ N(0,1), eps_t ~ N(0,1), quarterly 1975(1)-2024(4), T = 200.

    Saves workshop3-data.in7 with y, x, and the known-tau indicators S2000Q1, S2000Q1_x.
    (An .in7 file is an OxMetrics database; it comes with a companion .bn7 file that
    holds the numbers -- keep the two together.)

    LIVE after running this: load workshop3-data.in7 in OxMetrics and estimate
    y on Constant, x over the full sample in PcGive (point-and-click) -- the familiar
    output, badly misspecified: the estimates are averages across the two regimes.

    Run from OxMetrics (Model > Run, Ctrl+R) or:  oxl demo-0-data.ox
*/
#include <oxstd.oxh>                    // Ox standard library (matrices, print, random numbers)
#include <oxdraw.oxh>                   // Ox graphics (DrawTMatrix, SaveDrawWindow, ...)
#import <packages/PcGive/pcgive_ects>   // PcGive -- the package behind the OxMetrics menus
#import <OxRegimes/oxregimes>           // OxRegimes -- structural-change tools used all day

main()
{
    // ---- simulate the two-regime data ------------------------------------
    // Ox basics used below:
    //   decl        declares a variable (everything is declared with decl)
    //   range(a,b)  the row vector (a, a+1, ..., b); the ' transposes it into a column
    //   .>= .*      element-by-element comparison and multiplication ("dot" operators)
    //   rann(r,c)   an r x c matrix of standard-normal draws
    ranseed(2026);                                   // fix the random seed: same data every run
    decl cT = 200, iTau = 100;                       // T = 200 quarters; obs 100 = 2000(1),
                                                     //   the FIRST observation of regime 2
    decl vS = range(0, cT - 1)' .>= iTau;            // step indicator S_t = 1(t >= tau):
                                                     //   a column of 0s, then 1s from obs 100
    decl vX = rann(cT, 1);                           // x_t ~ N(0,1), T x 1
    decl vY = 1.0 + 2.0*vS + (0.5 + 1.5*vS) .* vX + rann(cT, 1);
    // read vY as: intercept 1.0 (+2.0 after the break), slope 0.5 (+1.5 after), noise N(0,1)

    // ---- put the series in a dated database and save it -------------------
    decl r = new Regimes();                          // a Regimes object IS a database
    r.Create(4, 1975, 1, 2024, 4);                   // quarterly (freq 4), 1975(1)-2024(4)
    r.Append(vY ~ vX ~ vS ~ vS .* vX,                //  ~ joins columns side by side
             {"y", "x", "S2000Q1", "S2000Q1_x"});    // variable names in the database
    r.Save("workshop3-data.in7");                    // every later demo LOADS this file,
                                                     //   so all segments use identical data
    println("Saved workshop3-data.in7  (quarterly 1975(1)-2024(4), T = 200)");
    println("\nTRUTH:                 before 2000(1)    from 2000(1)");
    println("  alpha (intercept)         1.0              3.0");
    println("  beta  (slope on x)        0.5              2.0");
    println("  sigma = 1;  x ~ N(0,1)\n");

    // ---- show the simulated data: y in the top panel, x below -------------
    // DrawTMatrix(panel, data row, name, start year, start period, frequency, ...)
    DrawTMatrix(0, vY', {"y"}, 1975, 1, 4, 0, 2);
    DrawTitle(0, "Simulated y  (break at 2000Q1)");
    DrawTMatrix(1, vX', {"x"}, 1975, 1, 4, 0, 2);
    DrawTitle(1, "Simulated x");
    SaveDrawWindow("demo-0-data.pdf");               // save the figure as a PDF ...
    ShowDrawWindow();                                // ... and show it in OxMetrics

    delete r;                                        // free the object (good Ox hygiene)
}
