/*  import-data-template.ox -- getting YOUR OWN data into OxMetrics.

    Most projects start with a CSV downloaded from FRED, the Philadelphia Fed, the
    ECB, or a similar source. This template turns such a file into a dated OxMetrics
    database (.in7) that the OxRegimes tools can use.

    Two routes. Route A (no code) is usually fastest; route B is here so you can see
    what happens and so it can be repeated when the data are updated.

    ROUTE A -- through the OxMetrics interface, no code
      1. File > Open, choose your .csv. OxMetrics shows the columns.
      2. Set the database frequency and start date: Database > Set Sample / Dated,
         or right-click the database > Transform > Dated. Quarterly = frequency 4.
      3. File > Save As > .in7. Done. Both .in7 and .bn7 are written -- keep them together.

    ROUTE B -- in code (this file)
      Fill in the four things marked <<< and run (Ctrl+R).

    Requirements: OxMetrics with PcGive, and the OxRegimes package (see README.md).
*/
#include <oxstd.oxh>
#import <packages/PcGive/pcgive_ects>
#import <OxRegimes/oxregimes>

main()
{
    // 1. The file. Strip the header row and any date/text column BEFORE loading:
    //    loadmat reads numbers only. Missing values should be written as .NaN
    //    (in Excel: save as CSV, then find-and-replace empty cells).
    decl sFile = "mydata-numeric.csv";                 // <<< your file
    decl m = loadmat(sFile);
    if (!ismatrix(m)) { println("could not read ", sFile); return; }
    println("loaded ", rows(m), " observations x ", columns(m), " variables");

    // 2. The dating: frequency and the FIRST and LAST observation of the file.
    //    Frequency 4 = quarterly, 12 = monthly, 1 = annual.
    decl iFreq = 4, iY1 = 1970, iP1 = 1, iY2 = 2024, iP2 = 2;   // <<< your sample

    // 3. The variable names, in the same order as the columns of the file.
    decl asNames = {"y", "x1", "x2"};                  // <<< your names
    if (columns(m) != sizeof(asNames))
        println("WARNING: ", columns(m), " columns but ", sizeof(asNames), " names");

    // 4. Build and save the database.
    decl r = new Regimes();
    r.Create(iFreq, iY1, iP1, iY2, iP2);
    r.Append(m, asNames);
    r.Save("mydata.in7");                              // <<< output name
    println("saved mydata.in7 (+ mydata.bn7 -- keep the two together)");

    // Check that the dating is right: this should print your sample and the first
    // and last values of the first variable.
    println("sample: ", iY1, "(", iP1, ") - ", iY2, "(", iP2, ")");
    println("first/last of ", asNames[0], ": ", m[0][0], " / ", m[rows(m)-1][0]);

    // A quick sanity regression (optional): does the model load and estimate?
    // r.Model("y", {"Constant", "x1"});
    // r.SetSample(iY1, iP1, iY2, iP2);
    // r.Constant("check").Print();

    delete r;
}

/*  COMMON PROBLEMS

    "Invalid sample" or dates look wrong
        The number of rows must match the sample you declared in step 2. Count them:
        a quarterly sample 1970(1)-2024(2) has 4*(2024-1970) + 2 = 218 observations.

    Missing values
        Write them as .NaN in the CSV. OxRegimes drops rows with missing values in
        the variables used by a model; the estimation sample in the output tells you
        how many were dropped.

    Mixed frequencies (e.g. monthly rates + quarterly GDP)
        Aggregate to the lower frequency BEFORE importing (quarterly average or
        end-of-quarter value) -- and say in your paper which one you chose.

    Real-time versus latest data
        For forecast errors it matters whether "realized" means the first release or
        the latest vintage. The Philadelphia Fed publishes both. Choose, and say so.
*/
