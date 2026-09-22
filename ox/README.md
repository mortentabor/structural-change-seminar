# Ox programs — Workshop 3: the toolbox

The live demos from Workshop 3: three methods for identifying structural change from the data — the **Bai–Perron test**, **Autometrics with indicator saturation (SIS/MIS)**, and **Markov switching** — all run on the same simulated dataset with one planted break (intercept 1→3, slope 0.5→2, at 2000Q1), so every method's output can be checked against a known truth. The scripts carry detailed comments and are meant to be read as much as run.

## The programs, in order

| Program | What it does |
|---|---|
| `demo-0-data.ox` | Simulates the two-regime data, saves `workshop3-data.in7`, plots the series. |
| `demo-0b-estimation.ox` | The same estimations three ways: point-and-click logic in PcGive batch code, the OxRegimes equivalent, and rolling-window estimates (watch the sharp break become a 10-year ramp). |
| `demo-1-baiperron.ox` | Known date → Chow test; unknown date → sup-F search (with the break-profile plot); multiple breaks → the Bai–Perron procedure. |
| `demo-2-autometrics.ox` | The break as indicator variables at a known date; then indicators at *every* date, selected by Autometrics (SIS + MIS). |
| `demo-3-switching.ox` | Markov switching with K = 2 (regime probabilities), and choosing K by information criteria. |

`workshop3-data.in7` + `workshop3-data.bn7` are the saved simulated data (an OxMetrics database is a pair — keep the two files together), so demos 0b–3 run without running demo-0 first. Every script ends with a plot of the estimated parameter paths against the true DGP.

## Requirements

- **OxMetrics 8 with PcGive Professional** (the university license covers you).
- **The [OxRegimes](https://github.com/knightianuncertainty/OxRegimes) package.** Install so that `#import <OxRegimes/oxregimes>` resolves, in one of two ways:
  1. copy the `OxRegimes` folder into `ox\packages\` of the OxMetrics installation, or
  2. add the folder that *contains* `OxRegimes` to the `OX8PATH` environment variable (keeping the two default entries) and restart OxMetrics — see the [install section](https://github.com/knightianuncertainty/OxRegimes#install) of the OxRegimes README for the exact command.

## How to run

Open a script in OxMetrics and run it (Model → Run, or Ctrl+R) — output appears in the results window, figures in graphics windows. From the command line: `oxl demo-1-baiperron.ox` from this folder (with OxRegimes on `OX8PATH`, or via `oxl -i"<path to the folder containing OxRegimes>"`).

The natural experiment after class: change the break date, the sizes of the shifts, or the noise in `demo-0-data.ox`, rerun it, and see which methods still find the break — and when they start to miss it.

## Guided exercise (Workshop 4)

The Workshop 3 demos ran on simulated data. The exercise runs the same toolbox on the *real* course data — the forecast-error regression from notebook 02 — and you write the code yourself, one step at a time.

| File | What it is |
|---|---|
| `exercise-01-your-turn.ox` | Fill-in-the-blanks version of the forecast-error regression with breaks: you write the code, the comments say what each step does and what the output should be, so you can check yourself. Uses `forecast-errors.in7`. |
| `exercise-01-solution.ox` | The solved version: the same steps and comments with the code filled in, readable on its own. Look after trying. |
| `import-data-template.ox` | Getting your own CSV (FRED, Philadelphia Fed, ECB) into a dated OxMetrics database. Two routes: through the interface, or in code. |
| `forecast-errors.in7` / `.bn7` | The Workshop 1 dataset as an OxMetrics database (quarterly 1970Q1–2024Q2): `error_avg`, `revision_avg`, `F_avg`, `pi_avg`, `pi_lag`. |
