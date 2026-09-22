# ---------------------------------------------------------------------------
# check_blinding.R -- run this before you open the pull request.
#
# This is a test, not a solution. It compares the file you are about to send
# against the original data and tells you whether it meets the specification.
#
# You can only run this because you still have the original data. Your partner
# cannot run it, which is exactly the point: verifying a blinding is the
# blinder's responsibility.
#
# Usage:  source("R/check_blinding.R")
# ---------------------------------------------------------------------------

library(dplyr)

if (!exists("marp_prep")) source("R/00_preprocess.R")

blinded_path <- "data/processed/marp_blinded.csv"

stopifnot("No blinded file found -- run R/01_blind_data.R first" =
            file.exists(blinded_path))

blinded <- readr::read_csv(blinded_path, show_col_types = FALSE)

# --- helpers ---------------------------------------------------------------

results <- list()

check <- function(label, passed, hint = NULL) {
  results[[length(results) + 1L]] <<-
    list(label = label, passed = isTRUE(passed), hint = hint)
  invisible(NULL)
}

# tolerant comparison of two sets of numbers, ignoring order
same_multiset <- function(a, b, tol = 1e-8) {
  a <- sort(a[!is.na(a)]); b <- sort(b[!is.na(b)])
  length(a) == length(b) && max(abs(a - b)) < tol
}

# pooled within-country correlation
within_cor <- function(d, cluster, x, y) {
  d |>
    group_by(.data[[cluster]]) |>
    mutate(across(all_of(c(x, y)), ~ .x - mean(.x, na.rm = TRUE))) |>
    ungroup() |>
    summarise(r = cor(.data[[x]], .data[[y]], use = "complete.obs")) |>
    pull(r)
}

country_col <- grep("^country", names(blinded), value = TRUE)[1]

# --- 1. structure ----------------------------------------------------------

check(
  "All expected columns are present",
  all(c("subject", "rel_mean", "cnorm_mean", "wb_overall_mean",
        "age", "gender", "ses", "education", "attention_check") %in% names(blinded)) &&
    !is.na(country_col),
  "Something got dropped. Compare names(blinded) with names(marp_prep)."
)

check(
  "No country-identifying columns left in",
  !any(c("gdp", "gdp_scaled", "ethnicity", "denomination") %in% names(blinded)),
  "These let an analyst look up which country is which. 00_preprocess.R removes them."
)

check(
  "Row count is unchanged",
  nrow(blinded) == nrow(marp_prep),
  "Blinding should not drop cases. Did you filter something?"
)

# --- 2. is it actually blinded? --------------------------------------------

check(
  "Country names are masked",
  !is.na(country_col) && !any(unique(marp_prep$country) %in% unique(blinded[[country_col]])),
  "At least one real country name survived. Did mask_variables() run on the right column?"
)

check(
  "All countries are still distinguishable",
  !is.na(country_col) &&
    n_distinct(blinded[[country_col]]) == n_distinct(marp_prep$country),
  "The number of masked groups should equal the number of countries (24)."
)

# --- 3. the link under test is broken --------------------------------------

r_orig <- within_cor(mutate(marp_prep, .cl = country), ".cl", "rel_mean", "wb_overall_mean")
r_blind <- within_cor(rename(blinded, .cl = all_of(country_col)), ".cl", "rel_mean", "wb_overall_mean")

check(
  sprintf("Religiosity-wellbeing link is broken (within-country r: %.3f -> %.3f)",
          r_orig, r_blind),
  abs(r_blind) < 0.02,
  "The association is still there. Did the scramble actually run?"
)

# --- 4. what must survive, survives ----------------------------------------

check(
  "Composite is still consistent with its items",
  {
    recomputed <- rowMeans(select(blinded, rel_1:rel_9), na.rm = TRUE)
    max(abs(recomputed - blinded$rel_mean), na.rm = TRUE) < 1e-8
  },
  paste("rel_mean no longer equals the mean of rel_1:rel_9. The items and the",
        "composite were scrambled independently -- you need them to move as a block.")
)

check(
  "Outcome data is untouched",
  same_multiset(blinded$wb_overall_mean, marp_prep$wb_overall_mean),
  "Well-being should not be blinded at all. Check your column selection."
)

check(
  "Country-level religiosity means are preserved",
  {
    a <- marp_prep |> group_by(country) |>
      summarise(m = mean(rel_mean, na.rm = TRUE), .groups = "drop") |> pull(m)
    b <- blinded |> group_by(.data[[country_col]]) |>
      summarise(m = mean(rel_mean, na.rm = TRUE), .groups = "drop") |> pull(m)
    same_multiset(a, b, tol = 1e-8)
  },
  paste("Values moved between countries, so between-country differences are gone.",
        "Scramble within country instead.")
)

check(
  "Covariates are untouched",
  same_multiset(blinded$age, marp_prep$age) &&
    same_multiset(blinded$ses, marp_prep$ses),
  "Covariates should pass through unchanged so the analyst can adjust for them."
)

check(
  "Data has NOT been cleaned for the analyst",
  n_distinct(blinded$attention_check) > 1,
  "Only participants who passed the attention check are left. Cleaning is the analyst's job -- send the raw thing."
)

# --- report ----------------------------------------------------------------

cat("\n", strrep("-", 66), "\n", sep = "")
cat("BLINDING CHECK\n")
cat(strrep("-", 66), "\n", sep = "")

for (r in results) {
  cat(if (r$passed) "  PASS  " else "  FAIL  ", r$label, "\n", sep = "")
  if (!r$passed && !is.null(r$hint)) cat("        -> ", r$hint, "\n", sep = "")
}

n_fail <- sum(!vapply(results, `[[`, logical(1), "passed"))

cat(strrep("-", 66), "\n", sep = "")
if (n_fail == 0) {
  cat("All checks passed. Commit the file and open your pull request.\n\n")
} else {
  cat(n_fail, " check(s) failed. Fix 01_blind_data.R and run this again.\n\n", sep = "")
}
