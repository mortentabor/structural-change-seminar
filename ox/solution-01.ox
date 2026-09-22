/*  solution-01.ox -- instructor's solved version of exercise-01, used to generate
    the expected numbers printed in the exercise's comments. Not for students.  */
#include <oxstd.oxh>
#import <packages/PcGive/pcgive_ects>
#import <OxRegimes/oxregimes>

main()
{
    decl r = new Regimes();
    r.Load("forecast-errors.in7");
    r.Model("error_avg", {"Constant", "revision_avg"});
    r.SetSample(1970, 2, 2024, 2);
    r.SetSE("HAC");

    println("==== A. constant parameters ====");
    decl res0 = r.Constant("Constant parameters");   // keep the result for the plot
    res0.Print();

    println("\n==== B. Chow at 1990(1) ====");
    r.Chow(1990, 1);

    println("\n==== C. Bai-Perron, max 5, 15% ====");
    decl bp = r.BaiPerron(5, 0.15, {{"label", "BP"}});
    r.GetModel("BP").PrintTests();

    println("\n==== D. SIS+MIS at 0.1% ====");
    decl sat = r.Saturation("SIS+MIS", 0.001, {{"label", "SIS+MIS"}});
    sat.Print();

    println("
==== E. estimates over time ====");
    RgPlots::EstimatesOverTime({res0, bp, sat}, {}, {{"file", "exercise-01.pdf"}});

    delete r;
}
