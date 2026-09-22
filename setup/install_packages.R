# Run this once before the workshop. It should end with "All set."

pkgs <- c(
  "tidyverse",  # data wrangling and plots
  "vazul",      # analysis blinding (part 3)
  "lme4",       # multilevel models (part 3)
  "usethis",    # git and GitHub setup from R (part 1)
  "gitcreds"    # stores your GitHub token (part 1)
)

install.packages(setdiff(pkgs, rownames(installed.packages())))

# Check the datasets are there.
data(marp, package = "vazul")
data(williams, package = "vazul")
stopifnot(nrow(marp) == 10535, nrow(williams) == 112)

cat("\nAll set.  R", as.character(getRversion()),
    " | vazul", as.character(packageVersion("vazul")), "\n\n")

# You also need, installed outside R:
#   git     https://git-scm.com/downloads
#   Quarto  https://quarto.org/docs/get-started/  (bundled with recent RStudio)
#   a GitHub account
