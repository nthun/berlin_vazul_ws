# Analysis blinding task

Berlin `vazul` workshop, part 3. Full instructions are in the workshop repo at
`exercises/03_blinding/03b_task_brief.qmd`.

## Checklist

- [ ] **1.** Push this folder to a new public GitHub repo, send the URL to your partner
- [ ] **2.** Write `R/01_blind_data.R`, then `source("R/check_blinding.R")` until everything passes
- [ ] **3.** Fill in `blinding_log.md` (seed + what you decided)
- [ ] **4.** Fork your partner's repo, add your blinded file, open a pull request
- [ ] **5.** Review and merge their pull request, then `git pull`
- [ ] **6.** **Restart R**, then work through `analysis/02_analysis.qmd`
- [ ] **7.** Render, commit, push

## Files

```
R/00_preprocess.R    given to you -- loads MARP, builds the composites
R/01_blind_data.R    YOUR JOB -- write the blinding
R/check_blinding.R   given to you -- verifies your blinded file
analysis/02_analysis.qmd   the analysis, with hints
blinding_log.md      your decisions, written down before you unblind
data/processed/      blinded files live here
```

## Setup

```r
install.packages(c("vazul", "tidyverse", "lme4"))
```
