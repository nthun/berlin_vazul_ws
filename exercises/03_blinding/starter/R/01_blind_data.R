# ---------------------------------------------------------------------------
# 01_blind_data.R -- YOUR JOB
#
# Write the blinding script. There is no single right answer, but there are
# wrong ones: your partner has to be able to do a real analysis on the result.
#
# The full specification is in 03b_task_brief.qmd. The short version:
#
#   MASK      country          -- the analyst must not know which country is which
#   SCRAMBLE  the religiosity block: rel_1 ... rel_9, rel_mean
#             ...subject to two constraints:
#                 (a) rel_mean must stay consistent with the rel_* items,
#                     i.e. the block has to move as a unit
#                 (b) country-level means must be unchanged, i.e. values must
#                     not move between countries
#   INTACT    everything else, cnorm_* included
#
# Do NOT clean the data. No filtering, no recoding. That is the analyst's job.
#
# When you are done, run R/check_blinding.R before you open the pull request.
# ---------------------------------------------------------------------------

library(vazul)
library(dplyr)

source("R/00_preprocess.R")

# Pick your own seed and write it down in blinding_log.md. Do not share it with
# the person who will analyse this data.
set.seed(  )   # <- TODO

marp_blinded <-
  marp_prep |>
  # TODO: mask the country
  # TODO: scramble the religiosity block -- mind constraints (a) and (b) above
  identity()

# ---------------------------------------------------------------------------
# Write the file your partner will receive.
# ---------------------------------------------------------------------------

dir.create("data/processed", recursive = TRUE, showWarnings = FALSE)
readr::write_csv(marp_blinded, "data/processed/marp_blinded.csv")

# ---------------------------------------------------------------------------
# Now: source("R/check_blinding.R")
# ---------------------------------------------------------------------------
