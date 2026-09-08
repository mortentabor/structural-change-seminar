# Structural Change and Expectations in Macroeconomics and Finance

Course material for the MSc seminar at the University of Copenhagen (AØKK08448U, Autumn 2026). Instructor: Morten Nyboe Tabor.

## Notebooks

| Notebook | What it does | Run it |
|---|---|---|
| [`01-forecast-errors-first-look.ipynb`](notebooks/01-forecast-errors-first-look.ipynb) | Companion to Workshop 1: US survey inflation forecasts, the forecast-error regression, the full-sample rejection of FIRE — and what sample splits reveal about its stability. | [![Open in Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/mortentabor/structural-change-seminar/blob/main/notebooks/01-forecast-errors-first-look.ipynb) |
| [`02-forecast-errors-exhibit.ipynb`](notebooks/02-forecast-errors-exhibit.ipynb) | Workshop 2 exhibit: the forecast-error regression revisited — your own splits vs. the Bai–Perron break dates, and from finding to question. | [![Open in Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/mortentabor/structural-change-seminar/blob/main/notebooks/02-forecast-errors-exhibit.ipynb) |
| [`03-phillips-curve.ipynb`](notebooks/03-phillips-curve.ipynb) | Workshop 2 exhibit: the Phillips curve, 1960–2025 — the full-sample slope, your own sample splits, and the Bai–Perron break dates. | [![Open in Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/mortentabor/structural-change-seminar/blob/main/notebooks/03-phillips-curve.ipynb) |
| [`04-return-predictability.ipynb`](notebooks/04-return-predictability.ipynb) | Workshop 2 exhibit: return predictability, 1927–2021 — the 1990 consensus, and whether it survived more data and real-time forecasting (the Welch–Goyal message). | [![Open in Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/mortentabor/structural-change-seminar/blob/main/notebooks/04-return-predictability.ipynb) |
| [`07-forecasting-horserace.ipynb`](notebooks/07-forecasting-horserace.ipynb) | Workshop 2 exhibit: the forecasting horserace — naive rule vs. recursive AR vs. the professionals. A clear full-sample winner, until the verdict itself turns out to be unstable. | [![Open in Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/mortentabor/structural-change-seminar/blob/main/notebooks/07-forecasting-horserace.ipynb) |

**Run it in the cloud (no installation):** click the **Open in Colab** badge above — the notebook runs in your browser and loads its data straight from this repository.

**Run it locally:** clone the repository; you need Python with `pandas`, `numpy`, `matplotlib`, `statsmodels`, and `scipy`.

**Just read it:** GitHub renders the notebook with all results — click the notebook link above (or use [nbviewer](https://nbviewer.org/github/mortentabor/structural-change-seminar/blob/main/notebooks/01-forecast-errors-first-look.ipynb) if GitHub's preview misbehaves).

## Data

`data/` contains ready-to-use CSVs built from the Survey of Professional Forecasters and real-time GDP-deflator vintages (Federal Reserve Bank of Philadelphia). See the data dictionary at the end of the notebook. Dataset construction follows Frydman & Tabor (2025), *INET Center on Knightian Uncertainty* working papers.
