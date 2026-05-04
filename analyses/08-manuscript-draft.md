# 08-manuscript-draft
Your Name
2026-05-04

- [<span class="toc-section-number">1</span> Tasks](#tasks)
  - [<span class="toc-section-number">1.1</span> Task 1: Data
    import](#task-1-data-import)
- [<span class="toc-section-number">2</span> Files
  written](#files-written)

**Updated: 2026-05-04 22:51:53 CET.**

<details class="code-fold">
<summary>Code</summary>

``` r
suppressPackageStartupMessages({
  library(here)
  library(conflicted)
  library(tidyverse)
  library(data.table)
  devtools::load_all()
})
# Resolve common dplyr / data.table / stats name clashes up front.
# Add more `conflicts_prefer()` calls below as needed.
conflicted::conflicts_prefer(
  dplyr::filter,
  dplyr::lag,
  dplyr::first,
  dplyr::last,
  dplyr::between,
  .quiet = TRUE
)
```

</details>

## Tasks

This section is designated for your workflow implementation. **Please
write all your analysis and processing code here.**

Maintaining your code within this section ensures a clean project
structure and facilitates reproducibility. We recommend organizing your
workflow into modular tasks—such as data cleaning, analysis, and
visualization—using distinct code chunks.

> [!NOTE]
>
> ### Example structure
>
> This is an example structure to get you started. You can modify it as
> per your needs.

### Task 1: Data import

<details class="code-fold">
<summary>Code</summary>

``` r
# Your data import code here
```

</details>

## Files written

These files have been written to the target directory,
data/08-manuscript-draft:

<details class="code-fold">
<summary>Code</summary>

``` r
knitr::kable(qproj::proj_dir_info(path_target(), tz = "CET"))
```

</details>

| path | type | size | modification_time |
|:-----|:-----|-----:|:------------------|
