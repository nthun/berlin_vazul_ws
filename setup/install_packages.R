# Run this once before the workshop. It should end with "All set."

pkgs <- c(
  "tidyverse",  # data wrangling and plots
  "vazul",      # analysis blinding (part 3)
  "lme4",       # multilevel models (part 3)
  "usethis",    # git and GitHub setup from R (part 1)
  "gitcreds",   # stores your GitHub token (part 1)
  "here"        # file paths in the instructor solutions
)

install.packages(setdiff(pkgs, rownames(installed.packages())))

# Check the datasets are there.
data(marp, package = "vazul")
data(williams, package = "vazul")
stopifnot(nrow(marp) == 10535, nrow(williams) == 112)

# Check git actually runs. Testing that it merely exists is not enough: macOS
# ships a stub at /usr/bin/git that is present even when git is not installed.
git_version <- tryCatch(
  suppressWarnings(system2("git", "--version", stdout = TRUE, stderr = TRUE)),
  error = function(e) character(0)
)
git_ok <- length(git_version) > 0 && grepl("^git version", git_version[1])

if (git_ok) {
  cat("\nAll set.  R", as.character(getRversion()),
      " | vazul", as.character(packageVersion("vazul")),
      " |", git_version[1], "\n\n")
} else {
  cat("\nAlmost there: git is not working yet.\n")
  if (Sys.info()[["sysname"]] == "Darwin") {
    cat("  On a Mac, open Terminal and run:   xcode-select --install\n",
        "  and accept the prompt. It can take 10-20 minutes.\n", sep = "")
  } else {
    cat("  Install it from https://git-scm.com/downloads\n")
  }
  cat("  Then restart RStudio and run this script again.\n\n")
}

# You also need, installed outside R:
#   git     see above
#   Quarto  bundled with recent RStudio; otherwise https://quarto.org
#   a GitHub account
