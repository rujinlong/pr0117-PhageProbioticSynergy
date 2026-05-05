# Phage-Host Prediction Analysis
Your Name

- [<span class="toc-section-number">1</span> Phage-Host Prediction for
  Animal Pathogens](#phage-host-prediction-for-animal-pathogens)
  - [<span class="toc-section-number">1.1</span> Setup](#setup)
  - [<span class="toc-section-number">1.2</span> Load
    Packages](#load-packages)
  - [<span class="toc-section-number">1.3</span> 1.
    Objective](#1-objective)
  - [<span class="toc-section-number">1.4</span> 2. Phage-Host
    Prediction Tools Review](#2-phage-host-prediction-tools-review)
    - [<span class="toc-section-number">1.4.1</span> 2.1 Sequence-Based
      Methods](#21-sequence-based-methods)
    - [<span class="toc-section-number">1.4.2</span> 2.2 Structure-Based
      Methods](#22-structure-based-methods)
    - [<span class="toc-section-number">1.4.3</span> 2.3 Integrated
      Pipelines](#23-integrated-pipelines)
  - [<span class="toc-section-number">1.5</span> 3. Database
    Integration](#3-database-integration)
    - [<span class="toc-section-number">1.5.1</span> 3.1 Download Phage
      Genomes from RefSeq](#31-download-phage-genomes-from-refseq)
    - [<span class="toc-section-number">1.5.2</span> 3.2 Load Existing
      Database](#32-load-existing-database)
  - [<span class="toc-section-number">1.6</span> 4. Host Prediction
    Analysis](#4-host-prediction-analysis)
    - [<span class="toc-section-number">1.6.1</span> 4.1 Using
      ViroProfiler Pipeline](#41-using-viroprofiler-pipeline)
    - [<span class="toc-section-number">1.6.2</span> 4.2 Using
      vConTACT3](#42-using-vcontact3)
  - [<span class="toc-section-number">1.7</span> 5. Results
    Integration](#5-results-integration)
    - [<span class="toc-section-number">1.7.1</span> 5.1 Parse
      Prediction Results](#51-parse-prediction-results)
    - [<span class="toc-section-number">1.7.2</span> 5.2
      Visualization](#52-visualization)
  - [<span class="toc-section-number">1.8</span> 6. Candidate Phage
    Selection](#6-candidate-phage-selection)
    - [<span class="toc-section-number">1.8.1</span> 6.1 Selection
      Criteria](#61-selection-criteria)
    - [<span class="toc-section-number">1.8.2</span> 6.2 Top Candidates
      Table](#62-top-candidates-table)
  - [<span class="toc-section-number">1.9</span> 7. NotebookLM
    Integration](#7-notebooklm-integration)
    - [<span class="toc-section-number">1.9.1</span> 7.1 Query
      NotebookLM for Validation](#71-query-notebooklm-for-validation)
    - [<span class="toc-section-number">1.9.2</span> 7.2 Add Results to
      NotebookLM](#72-add-results-to-notebooklm)
  - [<span class="toc-section-number">1.10</span> 8. Session
    Info](#8-session-info)
  - [<span class="toc-section-number">1.11</span> 9. Next
    Steps](#9-next-steps)

# Phage-Host Prediction for Animal Pathogens

## Setup

<details class="code-fold">
<summary>Code</summary>

``` r
here::i_am(paste0(params$name, ".qmd"), uuid = "b2c3d4e5-f6a7-8901-bcde-f1234567890")

# qproj setup
qproj::proj_create_dir_target(params$name)
path_target <- qproj::proj_path_target(params$name)()
path_source <- qproj::proj_path_source(params$name)

# Read upstream data
path_upstream <- qproj::proj_path_source("01-public-data-mining")
```

</details>

## Load Packages

<details class="code-fold">
<summary>Code</summary>

``` r
library(tidyverse)
library(here)
library(qproj)
library(ape)
library(ggplot2)
# For phage-host prediction
# library(phageR)      # If available
# library(vConTACT2R)  # If available
```

</details>

## 1. Objective

Predict which phages can effectively target specific animal pathogens: -
**Target pathogens**: *Clostridium perfringens*, *Salmonella enterica*,
*E. coli*, *Vibrio* spp. - **Goal**: Identify lytic phages with broad
host range or specific activity - **Approach**: Use computational
tools + existing databases (phagesDB, MVP, vConTACT3)

## 2. Phage-Host Prediction Tools Review

Based on NotebookLM research (34 sources imported), key tools include:

### 2.1 Sequence-Based Methods

- **vConTACT3**: Viral protein cluster networks, genus-level prediction
- **PHIAF**: Phage-host interaction predictor using k-mer features
- **DeepHost**: Deep learning approach using genomic features
- **WIsH**: k-mer based method

### 2.2 Structure-Based Methods

- **PHP**: Prokaryotic host prediction using structural features
- **VHQS**: Quality scoring for predicted interactions

### 2.3 Integrated Pipelines

- **ViroProfiler** (our existing tool)
- **TPD** (Therapeutic Phage Discovery pipeline)

## 3. Database Integration

### 3.1 Download Phage Genomes from RefSeq

Template for downloading phage genomes targeting our pathogens of
interest.

<details class="code-fold">
<summary>Code</summary>

``` r
# Using entrez to download phage genomes
if (FALSE) {  # Set to TRUE when ready
  library(rentrez)
  
  # Search for phages targeting C. perfringens
  search_cperf <- rentrez::entrez_search(
    db = "nucleotide",
    term = "Clostridium perfringens phage[Organism] AND refseq[filter]",
    retmax = 100
  )
  
  # Download sequences
  phage_seqs <- rentrez::entrez_fetch(
    db = "nucleotide",
    id = search_cperf$ids,
    rettype = "fasta"
  )
  
  # Save
  writeLines(
    phage_seqs,
    file.path(path_target, "raw", "c_perfringens_phages.fasta")
  )
}
```

</details>

### 3.2 Load Existing Database

Load phage-host interaction data from integrated databases.

<details class="code-fold">
<summary>Code</summary>

``` r
# Template: Load phagesDB data
# Source: https://phagesdb.org/download/
phagesdb_url <- "https://phagesdb.org/media/ExportDatasets/"

# Template: Load vConTACT3 results if available
# vcontact_results <- read_tsv(file.path(path_upstream, "processed", "vcontact_results.tsv"))

message("Database loading templates ready")
```

</details>

## 4. Host Prediction Analysis

### 4.1 Using ViroProfiler Pipeline

Our existing ViroProfiler pipeline can be used for phage-host
prediction.

<details class="code-fold">
<summary>Code</summary>

``` r
# Template for running ViroProfiler
# ViroProfiler path (update as needed)
viroprofiler_path <- "~/tools/ViroProfiler"

# Command template
viroprofiler_cmd <- sprintf(
  "cd %s && bash run_viroprofiler.sh -i %s -o %s -t phage_host",
  viroprofiler_path,
  file.path(path_upstream, "raw", "phage_contigs.fasta"),
  file.path(path_target, "processed", "viroprofiler_output")
)

# Execute (when ready)
# system(viroprofiler_cmd)
```

</details>

### 4.2 Using vConTACT3

vConTACT3 for viral cluster-based host prediction.

<details class="code-fold">
<summary>Code</summary>

``` r
# Template for vConTACT3 analysis
# Input: viral protein files
# Output: cluster network with host predictions

vcontact_cmd <- sprintf(
  "vcontact3 --input-file %s --output-dir %s --threads 8",
  file.path(path_upstream, "processed", "viral_proteins.faa"),
  file.path(path_target, "processed", "vcontact3_output")
)

# Execute (when ready)
# system(vcontact_cmd)
```

</details>

## 5. Results Integration

### 5.1 Parse Prediction Results

<details class="code-fold">
<summary>Code</summary>

``` r
# Template: Parse ViroProfiler/vConTACT3 results
# results_df <- read_tsv(file.path(path_target, "processed", "predictions.tsv"))

# Summary table template
# summary_table <- results_df %>%
#   group_by(target_pathogen, phage_id) %>%
#   summarise(
#     prediction_score = mean(score),
#     n_tools = n_distinct(tool),
#     .groups = "drop"
#   ) %>%
#   arrange(desc(prediction_score))

# knitr::kable(summary_table, caption = "Phage-Host Prediction Results")
```

</details>

### 5.2 Visualization

<details class="code-fold">
<summary>Code</summary>

``` r
# Template: Visualize prediction results
# ggplot(summary_table, aes(x = target_pathogen, y = prediction_score, fill = n_tools)) +
#   geom_boxplot() +
#   theme_minimal() +
#   labs(title = "Phage-Host Prediction Scores by Pathogen",
#        x = "Target Pathogen", y = "Prediction Score")
```

</details>

## 6. Candidate Phage Selection

### 6.1 Selection Criteria

Based on the Research Master Plan: 1. **Lytic lifestyle** (not
temperate) 2. **Broad host range** (target multiple strains) 3.
**Genomic stability** (few lysogenic genes) 4. **Safety profile** (no
toxin genes, no AMR genes)

### 6.2 Top Candidates Table

*To be populated after running predictions*

| Phage ID | Target Pathogen | Prediction Score | Lifestyle | Host Range | Notes |
|----------|-----------------|------------------|-----------|------------|-------|
| TBD      | C. perfringens  | \-               | lytic     | \-         | \-    |
| TBD      | S. enterica     | \-               | lytic     | \-         | \-    |
| TBD      | E. coli         | \-               | lytic     | \-         | \-    |
| TBD      | Vibrio spp.     | \-               | lytic     | \-         | \-    |

## 7. NotebookLM Integration

### 7.1 Query NotebookLM for Validation

Use NotebookLM to validate predictions against literature.

``` bash
nlm notebook query phage-synergy "What phages are effective against Clostridium perfringens in poultry?"
```

### 7.2 Add Results to NotebookLM

After generating prediction results, add them as a source to NotebookLM
for cross-referencing with literature.

``` bash
# Convert results to text/PDF and add to NotebookLM
nlm source add phage-synergy --text "$(cat predictions_summary.txt)" --title "Phage-Host Predictions pr0117"
```

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
     [1] ape_5.8-1       qproj_0.1.5     here_1.0.2      lubridate_1.9.5
     [5] forcats_1.0.1   stringr_1.6.0   dplyr_1.2.1     purrr_1.2.1    
     [9] readr_2.2.0     tidyr_1.3.2     tibble_3.3.1    ggplot2_4.0.2  
    [13] tidyverse_2.0.0

    loaded via a namespace (and not attached):
     [1] gtable_0.3.6       jsonlite_2.0.0     compiler_4.5.3     Rcpp_1.1.1        
     [5] tidyselect_1.2.1   parallel_4.5.3     scales_1.4.0       yaml_2.3.12       
     [9] fastmap_1.2.0      lattice_0.22-9     R6_2.6.1           generics_0.1.4    
    [13] knitr_1.51         rprojroot_2.1.1    tzdb_0.5.0         pillar_1.11.1     
    [17] RColorBrewer_1.1-3 rlang_1.2.0        stringi_1.8.7      xfun_0.57         
    [21] fs_2.0.1           S7_0.2.1           otel_0.2.0         timechange_0.4.0  
    [25] cli_3.6.5          withr_3.0.2        magrittr_2.0.5     digest_0.6.39     
    [29] grid_4.5.3         hms_1.1.4          nlme_3.1-168       lifecycle_1.0.5   
    [33] vctrs_0.7.2        evaluate_1.0.5     glue_1.8.0         farver_2.1.2      
    [37] codetools_0.2-20   rmarkdown_2.31     tools_4.5.3        pkgconfig_2.0.3   
    [41] htmltools_0.5.9   

## 9. Next Steps

1.  **Run ViroProfiler** on target phage genomes
2.  **Run vConTACT3** for cluster-based predictions
3.  **Integrate results** from multiple tools
4.  **Validate predictions** using NotebookLM literature
5.  **Proceed to Module 03** (`03-probiotic-target-identification.qmd`)

------------------------------------------------------------------------

*Generated by qproj workflow for pr0117-PhageProbioticSynergy*
