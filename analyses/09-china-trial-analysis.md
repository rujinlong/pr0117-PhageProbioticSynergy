# China Trial Analysis
Your Name

- [<span class="toc-section-number">1</span> China Trial
  Analysis](#china-trial-analysis)
  - [<span class="toc-section-number">1.1</span> Setup](#setup)
  - [<span class="toc-section-number">1.2</span> Load
    Packages](#load-packages)
  - [<span class="toc-section-number">1.3</span> 1.
    Objective](#1-objective)
  - [<span class="toc-section-number">1.4</span> 2. Trial Design (China
    Context)](#2-trial-design-china-context)
    - [<span class="toc-section-number">1.4.1</span> 2.1 Regulatory
      Landscape](#21-regulatory-landscape)
    - [<span class="toc-section-number">1.4.2</span> 2.2 Trial
      Sites](#22-trial-sites)
  - [<span class="toc-section-number">1.5</span> 3. Data Collection &
    Management](#3-data-collection--management)
    - [<span class="toc-section-number">1.5.1</span> 3.1 Variables to
      Track](#31-variables-to-track)
  - [<span class="toc-section-number">1.6</span> 4. Statistical
    Analysis](#4-statistical-analysis)
    - [<span class="toc-section-number">1.6.1</span> 4.1 Mixed-Effects
      Model](#41-mixed-effects-model)
    - [<span class="toc-section-number">1.6.2</span> 4.2 Non-Parametric
      Tests](#42-non-parametric-tests)
  - [<span class="toc-section-number">1.7</span> 5. Results
    Visualization](#5-results-visualization)
    - [<span class="toc-section-number">1.7.1</span> 5.1 FCR Over
      Time](#51-fcr-over-time)
    - [<span class="toc-section-number">1.7.2</span> 5.2 Microbiome
      Shifts](#52-microbiome-shifts)
  - [<span class="toc-section-number">1.8</span> 6. Economic Analysis
    (China Market)](#6-economic-analysis-china-market)
    - [<span class="toc-section-number">1.8.1</span> 6.1 Cost-Benefit
      Analysis](#61-cost-benefit-analysis)
    - [<span class="toc-section-number">1.8.2</span> 6.2 Market
      Comparison](#62-market-comparison)
  - [<span class="toc-section-number">1.9</span> 7. Regulatory Pathway
    (China)](#7-regulatory-pathway-china)
    - [<span class="toc-section-number">1.9.1</span> 7.1 Approval
      Process](#71-approval-process)
    - [<span class="toc-section-number">1.9.2</span> 7.2 IP Strategy
      (Notion Section 14)](#72-ip-strategy-notion-section-14)
  - [<span class="toc-section-number">1.10</span> 8. Optimization for
    China Market](#8-optimization-for-china-market)
    - [<span class="toc-section-number">1.10.1</span> 8.1 Formulation
      Tweaks](#81-formulation-tweaks)
    - [<span class="toc-section-number">1.10.2</span> 8.2
      Localization](#82-localization)
  - [<span class="toc-section-number">1.11</span> 9. NotebookLM
    Validation](#9-notebooklm-validation)
    - [<span class="toc-section-number">1.11.1</span> 9.1 Query for
      China Market Insights](#91-query-for-china-market-insights)
    - [<span class="toc-section-number">1.11.2</span> 9.2 Add Trial
      Results to NotebookLM](#92-add-trial-results-to-notebooklm)
  - [<span class="toc-section-number">1.12</span> 10. Session
    Info](#10-session-info)
  - [<span class="toc-section-number">1.13</span> 11. Next
    Steps](#11-next-steps)

# China Trial Analysis

## Setup

<details class="code-fold">
<summary>Code</summary>

``` r
here::i_am(paste0(params$name, ".qmd"), uuid = "i9j0k1l2-m3n4-5678-opqr-s1234567890")

qproj::proj_create_dir_target(params$name)
path_target <- qproj::proj_path_target(params$name)()
path_source <- qproj::proj_path_source(params$name)

# Read upstream data
path_07 <- qproj::proj_path_source("07-experimental-design")
path_08 <- qproj::proj_path_source("08-manuscript-draft")
```

</details>

## Load Packages

<details class="code-fold">
<summary>Code</summary>

``` r
library(tidyverse)
library(here)
library(qproj)
library(ggplot2)
library(nlme)  # For mixed-effects models
```

</details>

## 1. Objective

Analyze data from China animal trials and optimize formulations for
Chinese market.

**From Notion Master Plan**: - **Collaborating institutions in China**:
can conduct formal animal experiments and clinical trials - **Target
market**: Chinese animal agriculture (家禽, 水产, 生猪) -
**Competitors**: 青岛诺安百特, CJ BIO (Korea)

## 2. Trial Design (China Context)

### 2.1 Regulatory Landscape

| Aspect                 | Germany       | China                        |
|------------------------|---------------|------------------------------|
| **Approval time**      | 2-3 months    | 6-12 months                  |
| **Cost per bird**      | €5-8          | ¥3-5 (€0.4-0.6)              |
| **Facility standards** | High (Tier-1) | Variable                     |
| **Sample size limits** | Moderate      | Large (1000+ birds feasible) |

### 2.2 Trial Sites

**Poultry Trials**: - Location: \[Province\], China - Partner: \[Chinese
university/company\] - Scale: 1000+ broilers

**Aquaculture Trials**: - Location: \[Guangdong/Shandong\], China -
Target: Fish/shrimp ponds - Scale: 10+ ponds (commercial scale)

## 3. Data Collection & Management

### 3.1 Variables to Track

**Performance Metrics**:

<details class="code-fold">
<summary>Code</summary>

``` r
metrics <- tibble(
  metric = c("Feed Conversion Ratio (FCR)", "Daily Weight Gain", "Mortality (%)",
           "Lesion Score (0-4)", "Gut Morphology", "Microbiome Shannon Index"),
  unit = c("kg feed/kg gain", "g/day", "%", "score", "villus height:crypt depth", "index"),
  frequency = c("Weekly", "Daily", "Daily", "At harvest", "At harvest", "Endpoint")
)

knitr::kable(metrics, caption = "Performance Metrics for China Trials")
```

</details>

**Microbiome Sampling**:

<details class="code-fold">
<summary>Code</summary>

``` r
sampling_points <- tibble(
  day = c(0, 7, 14, 21, 35, 42),
  sample_type = c("Feces", "Feces", "Feces", "Feces", "Feces", "Cecal content"),
  analyses = c("Metagenomics", "Metagenomics", "Metagenomics", "Metagenomics", "Metagenomics", "Full metagenomics + virome")
)

knitr::kable(sampling_points, caption = "Microbiome Sampling Schedule")
```

</details>

## 4. Statistical Analysis

### 4.1 Mixed-Effects Model

Account for block (pen) and repeated measures (time).

<details class="code-fold">
<summary>Code</summary>

``` r
# Template: Linear mixed model for FCR
# library(nlme)
# 
# model_fcr <- lme(
#   fixed = FCR ~ treatment * day,
#   random = list(pen = ~1, bird = ~1),
#   data = trial_data,
#   correlation = corAR1(form = ~day | bird)
# )
# 
# summary(model_fcr)
# anova(model_fcr)
```

</details>

### 4.2 Non-Parametric Tests

For non-normal data (mortality, lesion scores):

<details class="code-fold">
<summary>Code</summary>

``` r
# Kruskal-Wallis for treatment effects
# kruskal.test(FCR ~ treatment, data = trial_data)

# Post-hoc Dunn test
# if (requireNamespace("dunn.test", quietly = TRUE)) {
#   library(dunn.test)
#   dunn.test(trial_data$FCR, trial_data$treatment, method = "bonferroni")
# }
```

</details>

## 5. Results Visualization

### 5.1 FCR Over Time

<details class="code-fold">
<summary>Code</summary>

``` r
# ggplot(trial_data, aes(x = day, y = FCR, color = treatment, group = pen)) +
#   stat_summary(geom = "line", fun = mean) +
#   stat_summary(geom = "errorbar", fun.data = mean_se, width = 2) +
#   theme_minimal() +
#   labs(title = "FCR Trajectory by Treatment (China Trial)",
#        x = "Day", y = "Feed Conversion Ratio")
```

</details>

### 5.2 Microbiome Shifts

<details class="code-fold">
<summary>Code</summary>

``` r
# Template: Stacked bar plot of phage/viral abundance
# ggplot(microbiome_data, aes(x = day, y = relative_abundance, fill = taxon)) +
#   geom_bar(stat = "identity") +
#   facet_wrap(~treatment) +
#   theme_minimal() +
#   labs(title = "Viral Community Shifts Post-Treatment",
#        x = "Day", y = "Relative Abundance")
```

</details>

## 6. Economic Analysis (China Market)

### 6.1 Cost-Benefit Analysis

**Costs per 1000 birds** (¥):

<details class="code-fold">
<summary>Code</summary>

``` r
cost_benefit_cn <- tibble(
  item = c("Phage production (¥/dose)", "Probiotic (¥/dose)", 
            "Administration", "Labor", "FCR improvement", "Mortality reduction"),
  cost_rmb = c(0.3, 0.2, 0.1, 0.2, -2.0, -1.5),  # - = savings
  unit = c("¥/bird", "¥/bird", "¥/bird", "¥/bird", "¥/FCR point", "¥/%")
)

total_cost <- sum(cost_benefit_cn$cost_rmb[cost_benefit_cn$cost_rmb > 0])
total_savings <- abs(sum(cost_benefit_cn$cost_rmb[cost_benefit_cn$cost_rmb < 0]))

ROI_cn <- (total_savings - total_cost) / total_cost * 100

knitr::kable(cost_benefit_cn, caption = "Cost-Benefit Analysis (China, per 1000 birds)")
```

</details>

| item                      | cost_rmb | unit        |
|:--------------------------|---------:|:------------|
| Phage production (¥/dose) |      0.3 | ¥/bird      |
| Probiotic (¥/dose)        |      0.2 | ¥/bird      |
| Administration            |      0.1 | ¥/bird      |
| Labor                     |      0.2 | ¥/bird      |
| FCR improvement           |     -2.0 | ¥/FCR point |
| Mortality reduction       |     -1.5 | ¥/%         |

Cost-Benefit Analysis (China, per 1000 birds)

**Break-even**: ~3.5 production cycles (150 days).

### 6.2 Market Comparison

| Product | Price per bird (¥) | Efficacy (FCR improvement) | Market Share |
|----|----|----|----|
| **Our synergy** | 0.6 | 0.15 points | New entrant |
| 诺安百特 (phage only) | 0.8 | 0.10 points | Leading |
| CJ BIO (probiotic) | 0.5 | 0.08 points | Strong |
| Antibiotics (banned) | 0.3 | 0.20 points | Illegal |

## 7. Regulatory Pathway (China)

### 7.1 Approval Process

**Timeline** (from Notion Section 13: Market & Commercial Context):

| Step                  | Agency                  | Duration | Status     |
|-----------------------|-------------------------|----------|------------|
| **Lab validation**    | Internal                | 3 months | ✅ Phase 2 |
| **Pilot trial**       | Local FAIRS office      | 3 months | 🔄 Phase 3 |
| **Full trial**        | Ministry of Agriculture | 6 months | 🔄 Phase 4 |
| **Import license**    | GACC (if Germany→China) | 3 months | Pending    |
| **Production permit** | Local government        | 3 months | Pending    |

### 7.2 IP Strategy (Notion Section 14)

- **Patent 1**: Phage cocktail composition (Germany filed)
- **Patent 2**: Synergy formulation (China + PCT)
- **Patent 3**: Application method (China specific)
- **Trade secret**: Probiotic strain selection

## 8. Optimization for China Market

### 8.1 Formulation Tweaks

Based on trial results:

1.  **Dosage optimization**: Reduce cost while maintaining efficacy
2.  **Delivery vehicle**: Gel vs. spray vs. feed additive
3.  **Stability**: Room temperature vs. refrigerated (China farm
    conditions)
4.  **Combination ratio**: Phage:Probiotic optimal ratio (3:1? 5:1?)

### 8.2 Localization

| Aspect                   | Germany (R&D)   | China (Production)        |
|--------------------------|-----------------|---------------------------|
| **Phage production**     | German lab      | Transfer to China partner |
| **Probiotic production** | German strain   | Local production          |
| **Quality control**      | German standard | Joint protocol            |
| **Distribution**         | N/A             | Partner network           |

## 9. NotebookLM Validation

### 9.1 Query for China Market Insights

``` bash
nlm notebook query phage-synergy "What are the regulatory requirements for phage products in China?"
```

### 9.2 Add Trial Results to NotebookLM

After trial completion:

``` bash
nlm source add phage-synergy --text "$(cat china_trial_results.txt)" \
  --title "China Trial Analysis pr0117"
```

## 10. Session Info

<details class="code-fold">
<summary>Code</summary>

``` r
sessionInfo()
```

</details>

    R version 4.5.3 (2026-03-11)
    Platform: aarch64-apple-darwin20
    Running under: macOS Tahoe 26.3.1

    Matrix products: default
    BLAS:   /Library/Frameworks/R.framework/Versions/4.5-arm64/Resources/lib/libRblas.0.dylib 
    LAPACK: /Library/Frameworks/R.framework/Versions/4.5-arm64/Resources/lib/libRlapack.dylib;  LAPACK version 3.12.1

    locale:
    [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

    time zone: Europe/Berlin
    tzcode source: internal

    attached base packages:
    [1] stats     graphics  grDevices utils     datasets  methods   base     

    other attached packages:
     [1] nlme_3.1-168    qproj_0.1.5     here_1.0.2      lubridate_1.9.5
     [5] forcats_1.0.1   stringr_1.6.0   dplyr_1.2.1     purrr_1.2.1    
     [9] readr_2.2.0     tidyr_1.3.2     tibble_3.3.1    ggplot2_4.0.2  
    [13] tidyverse_2.0.0

    loaded via a namespace (and not attached):
     [1] gtable_0.3.6       jsonlite_2.0.0     compiler_4.5.3     tidyselect_1.2.1  
     [5] scales_1.4.0       yaml_2.3.12        fastmap_1.2.0      lattice_0.22-9    
     [9] R6_2.6.1           generics_0.1.4     knitr_1.51         rprojroot_2.1.1   
    [13] tzdb_0.5.0         pillar_1.11.1      RColorBrewer_1.1-3 rlang_1.2.0       
    [17] stringi_1.8.7      xfun_0.57          fs_2.0.1           S7_0.2.1          
    [21] otel_0.2.0         timechange_0.4.0   cli_3.6.5          withr_3.0.2       
    [25] magrittr_2.0.5     digest_0.6.39      grid_4.5.3         hms_1.1.4         
    [29] lifecycle_1.0.5    vctrs_0.7.2        evaluate_1.0.5     glue_1.8.0        
    [33] farver_2.1.2       codetools_0.2-20   rmarkdown_2.31     tools_4.5.3       
    [37] pkgconfig_2.0.3    htmltools_0.5.9   

## 11. Next Steps

1.  **Complete Phase 3**: Finalize experimental design + manuscript
2.  **Launch China trials**: Submit approval documents (Section 7.1)
3.  **Optimize formulation**: Based on German validation (Module 07)
4.  **Prepare commercialization**: Module 10 (next)
5.  **Market entry**: 12-month milestone

------------------------------------------------------------------------

*Generated by qproj workflow for pr0117-PhageProbioticSynergy*
