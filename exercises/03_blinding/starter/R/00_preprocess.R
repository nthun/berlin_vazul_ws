# ---------------------------------------------------------------------------
# 00_preprocess.R -- run this FIRST, before you blind anything
#
# This script is given to you complete. It does the boring part: loading the
# MARP data and building the two composite scores you would otherwise have to
# construct by hand.
#
# It does NOT clean the data. Data cleaning decisions belong to the analyst,
# and the analyst is your partner -- so leave them something to find.
#
# Output: `marp_prep`, a data frame in your environment.
# ---------------------------------------------------------------------------

library(vazul)
library(dplyr)

data(marp)

marp_prep <-
  marp |>
  mutate(
    # Religiosity composite: the nine rel_* items are already scaled 0-1,
    # so a row mean is a reasonable summary.
    rel_mean = rowMeans(across(rel_1:rel_9), na.rm = TRUE),

    # Perceived cultural norm of religiosity: two items, also 0-1.
    cnorm_mean = rowMeans(across(c(cnorm_1, cnorm_2)), na.rm = TRUE)
  ) |>
  # Columns that would let an analyst work out which country is which, or
  # reconstruct religiosity from something other than the rel_* items.
  # See the task brief for why each one goes.
  select(-gdp, -gdp_scaled, -ethnicity, -denomination)

# A quick look at what you are about to blind.
glimpse(marp_prep)
