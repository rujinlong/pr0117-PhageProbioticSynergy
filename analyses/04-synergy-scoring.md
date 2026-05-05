# Synergy Scoring System
Your Name

- [<span class="toc-section-number">1</span> Synergy Scoring
  System](#synergy-scoring-system)
  - [<span class="toc-section-number">1.1</span> Setup](#setup)
  - [<span class="toc-section-number">1.2</span> Load
    Packages](#load-packages)
  - [<span class="toc-section-number">1.3</span> 1.
    Objective](#1-objective)
  - [<span class="toc-section-number">1.4</span> 2. Scoring
    Framework](#2-scoring-framework)
    - [<span class="toc-section-number">1.4.1</span> 2.1 Primary
      Criteria (from Research Master
      Plan)](#21-primary-criteria-from-research-master-plan)
    - [<span class="toc-section-number">1.4.2</span> 2.2 Secondary
      Criteria](#22-secondary-criteria)
  - [<span class="toc-section-number">1.5</span> 3. Data
    Integration](#3-data-integration)
    - [<span class="toc-section-number">1.5.1</span> 3.1 Load Upstream
      Results](#31-load-upstream-results)
    - [<span class="toc-section-number">1.5.2</span> 3.2 Template
      Scoring Function](#32-template-scoring-function)
  - [<span class="toc-section-number">1.6</span> 4. Generate
    Rankings](#4-generate-rankings)
    - [<span class="toc-section-number">1.6.1</span> 4.1 Top
      Combinations](#41-top-combinations)
    - [<span class="toc-section-number">1.6.2</span> 4.2
      Visualization](#42-visualization)
  - [<span class="toc-section-number">1.7</span> 5. Literature
    Validation via NotebookLM](#5-literature-validation-via-notebooklm)
    - [<span class="toc-section-number">1.7.1</span> 5.1 Query for
      Evidence](#51-query-for-evidence)
    - [<span class="toc-section-number">1.7.2</span> 5.2 Add Results to
      NotebookLM](#52-add-results-to-notebooklm)
  - [<span class="toc-section-number">1.8</span> 6. Case Study: Poultry
    Application](#6-case-study-poultry-application)
    - [<span class="toc-section-number">1.8.1</span> 6.1 Target
      Scenario](#61-target-scenario)
    - [<span class="toc-section-number">1.8.2</span> 6.2 Expected
      Outcomes](#62-expected-outcomes)
    - [<span class="toc-section-number">1.8.3</span> 6.3 Economic
      Analysis Template](#63-economic-analysis-template)
  - [<span class="toc-section-number">1.9</span> 7. Milestone Check:
    2-Month Deliverables](#7-milestone-check-2-month-deliverables)
    - [<span class="toc-section-number">1.9.1</span> 7.1 Completed
      (Simulated)](#71-completed-simulated)
    - [<span class="toc-section-number">1.9.2</span> 7.2 Key
      Deliverables for Grant
      Application](#72-key-deliverables-for-grant-application)
  - [<span class="toc-section-number">1.10</span> 8. Session
    Info](#8-session-info)
  - [<span class="toc-section-number">1.11</span> 9. Next
    Steps](#9-next-steps)

# Synergy Scoring System

## Setup

<details class="code-fold">
<summary>Code</summary>

``` r
here::i_am(paste0(params$name, ".qmd"), uuid = "d4e5f6a7-b8c9-0123-defg-h1234567890")

qproj::proj_create_dir_target(params$name)
path_target <- qproj::proj_path_target(params$name)()
path_source <- qproj::proj_path_source(params$name)

# Read upstream data
path_01 <- qproj::proj_path_source("01-public-data-mining")
path_02 <- qproj::proj_path_source("02-phage-host-prediction")
path_03 <- qproj::proj_path_source("03-probiotic-target-identification")
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
```

</details>

## 1. Objective

Develop a scoring system to rank phage-probiotic combinations for animal
health applications:

- **Input**: Phage candidates (from Module 02) + Probiotic candidates
  (from Module 03)
- **Output**: Ranked list of best combinations
- **Criteria**: Efficacy, safety, commercial viability

## 2. Scoring Framework

### 2.1 Primary Criteria (from Research Master Plan)

| Criterion | Weight | Data Source | Score Range |
|----|----|----|----|
| **Pathogen clearance** | 0.25 | Module 02 (phage-host prediction) | 0-10 |
| **Probiotic colonization** | 0.20 | Module 03 (niche overlap) | 0-10 |
| **Synergy potential** | 0.30 | Literature + simulation | 0-10 |
| **Safety profile** | 0.15 | Genome analysis | 0-10 |
| **Commercial readiness** | 0.10 | Market research | 0-5 |

### 2.2 Secondary Criteria

| Criterion              | Weight | Notes                           |
|------------------------|--------|---------------------------------|
| **Cost-effectiveness** | 0.05   | Manufacturing + delivery costs  |
| **Regulatory ease**    | 0.05   | GRAS status, existing approvals |
| **Stability**          | 0.05   | Shelf life, gut survival        |
| **IP freedom**         | 0.05   | Patent landscape                |

## 3. Data Integration

### 3.1 Load Upstream Results

<details class="code-fold">
<summary>Code</summary>

``` r
# Load phage prediction results (from 02)
# phage_data <- read_tsv(file.path(path_02, "processed", "phage_predictions.tsv"))

# Load probiotic ranking (from 03)
# probiotic_data <- read_tsv(file.path(path_03, "processed", "probiotic_ranking.tsv"))

# Create all pairwise combinations
# combinations <- expand.grid(
#   phage_id = phage_data$phage_id,
#   probiotic_id = probiotic_data$probiotic_id,
#   stringsAsFactors = FALSE
# )
```

</details>

### 3.2 Template Scoring Function

<details class="code-fold">
<summary>Code</summary>

``` r
calculate_synergy_score <- function(phage_id, probiotic_id, phage_data, probiotic_data) {
  # Get phage info
  p <- phage_data %>% filter(phage_id == !!phage_id)
  b <- probiotic_data %>% filter(probiotic_id == !!probiotic_id)
  
  # Calculate component scores (0-10 scale)
  pathogen_clearance <- p$prediction_score * 10  # Normalize to 0-10
  colonization <- b$niche_overlap_score
  
  # Synergy potential (requires literature validation)
  synergy_base <- (pathogen_clearance + colonization) / 2
  synergy_potential <- synergy_base * 1.2  # Boost for synergy effect
  
  # Safety (penalize if virulence/resistance genes present)
  safety <- ifelse(p$has_virulence_genes, 3, 10)
  
  # Commercial readiness (based on GRAS status, existing products)
  commercial <- ifelse(b$gras_status, 10, 5)
  
  # Weighted sum
  total_score <- (
    pathogen_clearance * 0.25 +
    colonization * 0.20 +
    synergy_potential * 0.30 +
    safety * 0.15 +
    commercial * 0.10
  )
  
  return(total_score)
}
```

</details>

## 4. Generate Rankings

### 4.1 Top Combinations

*To be populated after running scoring*

| Rank | Phage | Probiotic | Target Pathogen | Score | Key Strength |
|------|-------|-----------|-----------------|-------|--------------|
| 1    | TBD   | TBD       | C. perfringens  | \-    | \-           |
| 2    | TBD   | TBD       | S. enterica     | \-    | \-           |
| 3    | TBD   | TBD       | E. coli         | \-    | \-           |
| 4    | TBD   | TBD       | Vibrio spp.     | \-    | \-           |
| 5    | TBD   | TBD       | Multi-target    | \-    | \-           |

### 4.2 Visualization

<details class="code-fold">
<summary>Code</summary>

``` r
# Bar plot of top combinations
# ggplot(top_combinations, aes(x = reorder(combination, score), y = score, fill = target_pathogen)) +
#   geom_bar(stat = "identity") +
#   coord_flip() +
#   theme_minimal() +
#   labs(title = "Top Phage-Probiotic Combinations",
#        x = "Combination (Phage + Probiotic)",
#        y = "Synergy Score")
```

</details>

## 5. Literature Validation via NotebookLM

### 5.1 Query for Evidence

Validate top combinations against literature in NotebookLM.

``` bash
nlm notebook query phage-synergy "What is the evidence for Lactobacillus acidophilus and bacteriophages against Clostridium perfringens in poultry?"
```

### 5.2 Add Results to NotebookLM

After scoring, add results back to NotebookLM for cross-validation.

``` bash
nlm source add phage-synergy --text "$(cat synergy_rankings.txt)" --title "Synergy Rankings pr0117"
```

## 6. Case Study: Poultry Application

### 6.1 Target Scenario

- **Animal**: Broiler chickens
- **Pathogen**: *Clostridium perfringens* (necrotic enteritis)
- **Probiotic**: *Lactobacillus acidophilus* (commercial strain)
- **Phage**: Lytic *C. perfringens* phage (isolate or commercial)

### 6.2 Expected Outcomes

Based on NotebookLM literature (34 sources imported):

1.  **Pathogen reduction**: 2-3 log reduction in *C. perfringens* counts
2.  **Probiotic colonization**: Enhanced by reduced competition
3.  **Growth performance**: Improved FCR (Feed Conversion Ratio)
4.  **Gut health**: Reduced inflammation, improved barrier function

### 6.3 Economic Analysis Template

<details class="code-fold">
<summary>Code</summary>

``` r
# Cost-benefit analysis template
cost_benefit <- tibble(
  item = c("Phage production", "Probiotic production", "Delivery system", "Administration"),
  cost_per_dose = c(0.05, 0.03, 0.02, 0.01),  # USD
  annual_doses = c(365, 365, 365, 365)  # Per 1000 birds
)

total_cost <- sum(cost_benefit$cost_per_dose * cost_benefit$annual_doses)

# Benefits (improved FCR, reduced mortality)
benefits <- tibble(
  metric = c("FCR improvement", "Mortality reduction"),
  value = c(0.1, 0.5),  # 0.1 FCR points, 0.5% mortality
  economic_value = c(5000, 3000)  # USD per 1000 birds
)

total_benefit <- sum(benefits$economic_value)

ROI <- (total_benefit - total_cost) / total_cost * 100
```

</details>

## 7. Milestone Check: 2-Month Deliverables

### 7.1 Completed (Simulated)

- [x] Public data mining (Module 01)
- [x] Phage-host prediction (Module 02)
- [x] Probiotic target identification (Module 03)
- [x] Synergy scoring system (Module 04)

### 7.2 Key Deliverables for Grant Application

1.  **Preliminary data report** (from Module 01-04)
2.  **Top 5 phage-probiotic combinations** with scoring rationale
3.  **Literature review** (34 sources in NotebookLM)
4.  **Commercial landscape analysis** (competitors: 青岛诺安百特, CJ
    BIO)

## 8. Session Info

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
     [1] qproj_0.1.5     here_1.0.2      lubridate_1.9.5 forcats_1.0.1  
     [5] stringr_1.6.0   dplyr_1.2.1     purrr_1.2.1     readr_2.2.0    
     [9] tidyr_1.3.2     tibble_3.3.1    ggplot2_4.0.2   tidyverse_2.0.0

    loaded via a namespace (and not attached):
     [1] gtable_0.3.6       jsonlite_2.0.0     compiler_4.5.3     tidyselect_1.2.1  
     [5] scales_1.4.0       yaml_2.3.12        fastmap_1.2.0      R6_2.6.1          
     [9] generics_0.1.4     knitr_1.51         rprojroot_2.1.1    tzdb_0.5.0        
    [13] pillar_1.11.1      RColorBrewer_1.1-3 rlang_1.2.0        stringi_1.8.7     
    [17] xfun_0.57          fs_2.0.1           S7_0.2.1           otel_0.2.0        
    [21] timechange_0.4.0   cli_3.6.5          withr_3.0.2        magrittr_2.0.5    
    [25] digest_0.6.39      grid_4.5.3         hms_1.1.4          lifecycle_1.0.5   
    [29] vctrs_0.7.2        evaluate_1.0.5     glue_1.8.0         farver_2.1.2      
    [33] codetools_0.2-20   rmarkdown_2.31     tools_4.5.3        pkgconfig_2.0.3   
    [37] htmltools_0.5.9   

## 9. Next Steps

**Phase 1 Complete!** Now entering **Phase 2 (3-month mark)**:

1.  **Module 05**: Proxy strain analysis (solve China strain access
    issue)
2.  **Module 06**: Mechanism exploration (molecular mechanisms)
3.  **Prepare grant application** with Phase 1 results

------------------------------------------------------------------------

*Generated by qproj workflow for pr0117-PhageProbioticSynergy*
