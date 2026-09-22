# Structural Change and Expectations in Macroeconomics and Finance

Course material for the MSc seminar at the University of Copenhagen (AØKK08448U, Autumn 2026). Instructor: Morten Nyboe Tabor.

## Notebooks

| Notebook | What it does | Run it |
|---|---|---|
| [`01-forecast-errors-first-look.ipynb`](notebooks/01-forecast-errors-first-look.ipynb) | Companion to Workshop 1: US survey inflation forecasts, the forecast-error regression, the full-sample rejection of FIRE — and what sample splits reveal about its stability. | [![Open in Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/mortentabor/structural-change-seminar/blob/main/notebooks/01-forecast-errors-first-look.ipynb) |
| [`02-forecast-errors-exhibit.ipynb`](notebooks/02-forecast-errors-exhibit.ipynb) | Workshop 2 exhibit: the forecast-error regression revisited — your own splits vs. the Bai–Perron break dates, and from finding to question. | [![Open in Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/mortentabor/structural-change-seminar/blob/main/notebooks/02-forecast-errors-exhibit.ipynb) |
| [`03-phillips-curve.ipynb`](notebooks/03-phillips-curve.ipynb) | Workshop 2 exhibit: the Phillips curve, 1960–2025 — the full-sample slope, your own sample splits, and the Bai–Perron break dates. | [![Open in Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/mortentabor/structural-change-seminar/blob/main/notebooks/03-phillips-curve.ipynb) |
| [`04-return-predictability.ipynb`](notebooks/04-return-predictability.ipynb) | Workshop 2 exhibit: return predictability, 1927–2021 — the 1990 consensus, and whether it survived more data and real-time forecasting (the Welch–Goyal message). | [![Open in Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/mortentabor/structural-change-seminar/blob/main/notebooks/04-return-predictability.ipynb) |
| [`05-forecasting-horserace.ipynb`](notebooks/05-forecasting-horserace.ipynb) | Workshop 2 exhibit: the forecasting horserace — naive rule vs. recursive AR vs. the professionals. A clear full-sample winner, until the verdict itself turns out to be unstable. | [![Open in Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/mortentabor/structural-change-seminar/blob/main/notebooks/05-forecasting-horserace.ipynb) |

**Run it in the cloud (no installation):** click the **Open in Colab** badge above — the notebook runs in your browser and loads its data straight from this repository.

**Run it locally:** clone the repository; you need Python with `pandas`, `numpy`, `matplotlib`, `statsmodels`, and `scipy`.

**Just read it:** GitHub renders the notebook with all results — click the notebook link above (or use [nbviewer](https://nbviewer.org/github/mortentabor/structural-change-seminar/blob/main/notebooks/01-forecast-errors-first-look.ipynb) if GitHub's preview misbehaves).

## Ox programs (Workshops 3 and 4)

[`ox/`](ox/) holds the live demos from Workshop 3: the three methods for identifying structural change from the data — the Bai–Perron test, Autometrics with indicator saturation, and Markov switching — all run on simulated data with a planted break, so every method can be checked against a known truth. It also holds the Workshop 4 **guided exercise** (`exercise-01-your-turn.ox`, with a solution and a data-import template): the forecast-error regression with breaks on the real course data, written step by step with checkable output. Requirements and run instructions are in [`ox/README.md`](ox/README.md); you need OxMetrics with PcGive (university license) and the OxRegimes package below.

## Packages

The structural-change toolkits behind the course, both open source:

- [**OxRegimes**](https://github.com/knightianuncertainty/OxRegimes) — Ox/OxMetrics: Bai–Perron, indicator saturation with Autometrics, Markov switching, rolling/recursive estimation, forecasting under instability.
- [**regimes**](https://github.com/knightianuncertainty/regimes) — the Python counterpart, built on statsmodels.

## Data

`data/` contains ready-to-use CSVs; every notebook loads its data from here (or straight from this repository when run in Colab).

| File | Contents | Source |
|---|---|---|
| `forecast_errors.csv` | SPF mean forecasts of one-year-ahead GDP-deflator inflation, first-release actuals, forecast errors and revisions, 1970Q1–2024Q2. | Survey of Professional Forecasters and real-time GDP-deflator vintages (Federal Reserve Bank of Philadelphia). Construction follows Frydman & Tabor (2025), *INET Center on Knightian Uncertainty* working papers; data dictionary at the end of notebook 01. Used in notebooks 01, 02, and 05. |
| `inflation_quarterly.csv` | Quarterly US GDP-deflator inflation (first release), 1968Q4–2024Q2. | Same real-time vintages as above. Used in notebook 05. |
| `phillips_curve.csv` | Quarterly US CPI inflation and the unemployment rate, 1960–2025. | FRED (CPIAUCSL, UNRATE). Used in notebook 03. |
| `return_predictability.csv` | Annual US stock returns and the dividend–price ratio, 1927–2021. | Robert Shiller's long-run S&P dataset. Used in notebook 04. |
