# Blind analysis workshop

A three-hour hands-on workshop on reproducible, bias-resistant analysis
workflows, built around the [`vazul`](https://nthun.github.io/vazul/) R package.

**Instructor:** Tamás Nagy (ELTE PPK) · [nthun](https://github.com/nthun)

## What we cover

| | Part | Time |
|---|---|---|
| 1 | **Version control** — git and GitHub | 45 min |
| 2 | **Literate programming** — Rmd and Quarto | 45 min |
| 3 | **Analysis blinding** — the `vazul` package | 90 min |

The three parts build on each other. By the end you will have blinded a real
dataset, sent it to a colleague through a pull request, analysed the one they
sent you without knowing what was in it, and unblinded.

## Before you arrive

You need **R (≥ 4.1)**, **RStudio** (or Positron), **Quarto**, and **git**, plus
a **GitHub account**. Then run:

```r
source("setup/install_packages.R")
```

It should print `All set.` If it does not, come ten minutes early.

You should be comfortable writing R code and using the tidyverse. You do not
need to know multilevel models — where the statistics get ahead of the group,
the code is given to you.

## Repository layout

```
slides/          presentation for each part
exercises/       run-along material and the task briefs
  03_blinding/
    03a_vazul_walkthrough.qmd   run this alongside part 3
    03b_task_brief.qmd           the independent task
    starter/                    copy this into your own repo
R/               shared helper scripts
data/            fallback data
solutions/       reference answers -- try not to look first
docs/            rendered output
```

Every `.qmd` here renders standalone (`embed-resources: true`), so you can open
and render any one of them without building the whole project.

## Part 3 in one paragraph

Blind analysis means making your analytical decisions — exclusions, covariates,
model form, outlier handling — while the effect you are testing is hidden from
you. `vazul` hides it by masking labels and scrambling values. The hard part is
not the functions; it is knowing which analyses your blinding still permits. That
is what the walkthrough and the task are about.

## Further reading

- MacCoun, R., & Perlmutter, S. (2015). Blind analysis: Hide results to seek the
  truth. *Nature*, 526, 187–189. <https://doi.org/10.1038/526187a>
- Dutilh, G., Sarafoglou, A., & Wagenmakers, E.-J. (2019). Flexible yet fair:
  Blinding analyses in experimental psychology. *Synthese*.
  <https://doi.org/10.1007/s11229-019-02456-7>
- Hoogeveen, S. et al. (2022). A many-analysts approach to the relation between
  religiosity and well-being. <https://doi.org/10.31234/osf.io/dpex6>

## License

Materials: CC BY 4.0. Code: MIT.
