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

Setup takes longer than you expect — installing git on a Mac especially. Please
do all of this **before** the workshop.

1. Install **R** (≥ 4.1), **RStudio** (or Positron) and **git**.
   - **Mac:** open Terminal, run `xcode-select --install`, and accept the
     prompt. It can take 10–20 minutes.
   - **Windows:** <https://git-scm.com/downloads>
2. Create a **GitHub** account.
3. Get these materials: green **Code** button → **Download ZIP**, unzip, and
   open `berlin_vazul_ws.Rproj`.
4. Run:

   ```r
   source("setup/install_packages.R")
   ```

   It should end with **All set.** If it says git is not working, follow the
   message it prints.

You should be comfortable writing R code and using the tidyverse. You do not
need to know multilevel models — where the statistics get ahead of the group,
the code is given to you.

## Repository layout

```
slides/            the three presentations
exercises/
  01_git/          part 1: your first repository
  02_literate/     part 2: the report skeleton
  03_blinding/     part 3: walkthrough, task brief, starter project
images/            figures used in the slides
setup/             install_packages.R
data/              a fallback blinded file for part 3
solutions/         reference answers -- try not to look first
docs/              an example rendered report
```

Every `.qmd` renders standalone (`embed-resources: true`), with one exception:
the part-3 analysis template needs the blinded file your partner sends you.

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
- Hoogeveen, S., Sarafoglou, A., van Elk, M., & Wagenmakers, E.-J. (2022). A
  many-analysts approach to the relation between religiosity and well-being:
  The dataset. *PsyArXiv*. <https://doi.org/10.31234/osf.io/dpex6>

## Rebuilding the HTML

The rendered HTML is committed so the slides and handouts open straight from the
repository, and every file is self-contained. To rebuild one, use the terminal:

```bash
quarto render slides/01_git_github.qmd
```

RStudio's **Render** button runs `quarto preview` for slides, which does not
embed resources and leaves the HTML depending on a `_files/` folder that git
ignores.

## License

© 2026 Tamás Nagy. Licensed under [CC BY 4.0](LICENSE.md): you may share and
adapt these materials, code included, for any purpose, provided you give
appropriate credit.

Not covered: the third-party images in `images/` (the Happy Git with R figure,
the GIFs, and screenshots of RStudio), which remain under their owners' terms,
and the MARP data, which comes from the
[`vazul`](https://nthun.github.io/vazul/) package and its original source.
