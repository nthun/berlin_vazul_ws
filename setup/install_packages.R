# Run this BEFORE the workshop. It should finish without errors.

pkgs <- c(
  "tidyverse",   # data wrangling and plots
  "vazul",       # analysis blinding
  "lme4",        # multilevel models
  "quarto",      # rendering
  "usethis"      # git/github helpers
)

to_install <- setdiff(pkgs, rownames(installed.packages()))
if (length(to_install)) install.packages(to_install)

# Check that everything loads and the data is there.
suppressPackageStartupMessages({
  library(tidyverse)
  library(vazul)
  library(lme4)
})

data(marp)
data(williams)

stopifnot(nrow(marp) == 10535, nrow(williams) == 224)

cat("\nAll set.\n",
    "  R:      ", as.character(getRversion()), "\n",
    "  vazul:  ", as.character(packageVersion("vazul")), "\n",
    "  quarto: ", tryCatch(as.character(quarto::quarto_version()),
                           error = function(e) "NOT FOUND -- install from quarto.org"), "\n",
    sep = "")
