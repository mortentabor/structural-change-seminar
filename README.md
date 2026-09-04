# Structural Change and Expectations in Macroeconomics and Finance

Course material for the MSc seminar at the University of Copenhagen (AØKK08448U, Autumn 2026). Instructor: Morten Nyboe Tabor.

## Notebooks

| Notebook | What it does | Run it |
|---|---|---|
| [`01-forecast-errors-first-look.ipynb`](notebooks/01-forecast-errors-first-look.ipynb) | Companion to Workshop 1: US survey inflation forecasts, the forecast-error regression, the full-sample rejection of FIRE — and what sample splits reveal about its stability. | [![Open in Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/mortentabor/structural-change-seminar/blob/main/notebooks/01-forecast-errors-first-look.ipynb) |
| [`02-phillips-curve.ipynb`](notebooks/02-phillips-curve.ipynb) | Workshop 2 exhibit: the Phillips curve, 1960–2025 — the full-sample slope, your own sample splits, and the Bai–Perron break dates. | [![Open in Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/mortentabor/structural-change-seminar/blob/main/notebooks/02-phillips-curve.ipynb) |
| [`03-return-predictability.ipynb`](notebooks/03-return-predictability.ipynb) | Workshop 2 exhibit: predicting stock returns with the dividend–price ratio, 1927–2021 — where the full sample hides what the subsamples reveal. | [![Open in Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/mortentabor/structural-change-seminar/blob/main/notebooks/03-return-predictability.ipynb) |
| [`04-forecasting-inflation.ipynb`](notebooks/04-forecasting-inflation.ipynb) | Workshop 2 exhibit: professional forecasters vs. a naive rule — an accuracy advantage that collapses exactly when it matters most. | [![Open in Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/mortentabor/structural-change-seminar/blob/main/notebooks/04-forecasting-inflation.ipynb) |

**Run it in the cloud (no installation):** click the **Open in Colab** badge above — the notebook runs in your browser and loads its data straight from this repository.

**Run it locally:** clone the repository; you need Python with `pandas`, `numpy`, `matplotlib`, `statsmodels`, and `scipy`.

**Just read it:** GitHub renders the notebook with all results — click the notebook link above (or use [nbviewer](https://nbviewer.org/github/mortentabor/structural-change-seminar/blob/main/notebooks/01-forecast-errors-first-look.ipynb) if GitHub's preview misbehaves).

## Data

`data/` contains ready-to-use CSVs built from the Survey of Professional Forecasters and real-time GDP-deflator vintages (Federal Reserve Bank of Philadelphia). See the data dictionary at the end of the notebook. Dataset construction follows Frydman & Tabor (2025), *INET Center on Knightian Uncertainty* working papers.
