# ---------------------------------------------------------------------------
# Reference solution for 01_blind_data.R
#
# One valid answer, not the only one. Any script that satisfies the
# specification and passes check_blinding.R is fine.
# ---------------------------------------------------------------------------

library(vazul)
library(dplyr)

source("R/00_preprocess.R")

set.seed(20261109)

marp_blinded <-
  marp_prep |>
  # 1. Mask the country. The analyst can still tell countries apart -- which is
  #    what makes cluster-level problems findable -- but not which is which.
  mask_variables(country) |>
  # 2. Scramble the religiosity block.
  #    .together = TRUE   keeps rel_mean consistent with the rel_* items
  #    .groups = "country" keeps country-level means exactly as they were
  scramble_variables(
    c(rel_1:rel_9, rel_mean, cnorm_1, cnorm_2, cnorm_mean),
    .together = TRUE,
    .groups   = "country"
  ) |>
  # 3. New identifiers, so the file cannot be joined back to the original.
  mutate(subject = sample(seq_len(n()))) |>
  # 4. New row order, so it cannot be lined up by position either.
  slice_sample(prop = 1)

dir.create("data/processed", recursive = TRUE, showWarnings = FALSE)
readr::write_csv(marp_blinded, "data/processed/marp_blinded.csv")

message("Blinded file written. Now run: source('R/check_blinding.R')")
