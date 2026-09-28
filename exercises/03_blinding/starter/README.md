# Analysis blinding task

Blind analysis workshop, part 3. Full instructions are in the workshop repo at
`exercises/03_blinding/03b_task_brief.qmd`.

## Checklist

- [ ] **1.** Set up this repo (GitHub first, then RStudio), push, send the URL to your partner
- [ ] **2.** Write `R/01_blind_data.R`, then `source("R/check_blinding.R")` until everything passes
- [ ] **3.** Note your seed and choices in `blinding_log.md`
- [ ] **4.** Upload your `outbox/marp_blinded.csv` to your partner's `data/processed/` as a pull request
- [ ] **5.** Merge the pull request they sent you, then **Pull** in RStudio
- [ ] **6.** **Restart R**, then work through `analysis/02_analysis.qmd`
- [ ] **7.** Render, commit, push

## Files

```
R/00_preprocess.R          given -- loads MARP, builds the composites
R/01_blind_data.R          YOUR JOB -- write the blinding
R/check_blinding.R         given -- verifies your blinded file
outbox/                    your blinded file for your partner (ignored by git)
data/processed/            your partner's blinded file arrives here
analysis/02_analysis.qmd   the analysis, with hints
blinding_log.md            your decisions, written before you unblind
_quarto.yml                runs code from the project root, renders to docs/
```

## Setup

```r
install.packages(c("vazul", "tidyverse", "lme4"))
```
