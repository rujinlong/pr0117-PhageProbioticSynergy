# Proxy Strain Analysis for China Market
Your Name

- [<span class="toc-section-number">1</span> Proxy Strain Analysis for
  China Market](#proxy-strain-analysis-for-china-market)
  - [<span class="toc-section-number">1.1</span> Setup](#setup)
  - [<span class="toc-section-number">1.2</span> Load
    Packages](#load-packages)
  - [<span class="toc-section-number">1.3</span> 1. Problem
    Statement](#1-problem-statement)
    - [<span class="toc-section-number">1.3.1</span> 1.1 The “Proxy
      Strain” Challenge](#11-the-proxy-strain-challenge)
    - [<span class="toc-section-number">1.3.2</span> 1.2 Target
      Pathogens for China Market](#12-target-pathogens-for-china-market)
  - [<span class="toc-section-number">1.4</span> 2. Proxy Strain
    Selection Strategy](#2-proxy-strain-selection-strategy)
    - [<span class="toc-section-number">1.4.1</span> 2.1 Selection
      Criteria](#21-selection-criteria)
    - [<span class="toc-section-number">1.4.2</span> 2.2 Data Sources
      for Strain Comparison](#22-data-sources-for-strain-comparison)
  - [<span class="toc-section-number">1.5</span> 3. Strain Comparison
    Analysis](#3-strain-comparison-analysis)
    - [<span class="toc-section-number">1.5.1</span> 3.1 ANI Calculation
      Template](#31-ani-calculation-template)
    - [<span class="toc-section-number">1.5.2</span> 3.2 Phage Receptor
      Profile Comparison](#32-phage-receptor-profile-comparison)
  - [<span class="toc-section-number">1.6</span> 4. Proxy Strain
    Candidates](#4-proxy-strain-candidates)
    - [<span class="toc-section-number">1.6.1</span> 4.1 *Clostridium
      perfringens* Proxies](#41-clostridium-perfringens-proxies)
    - [<span class="toc-section-number">1.6.2</span> 4.2 *Salmonella
      enterica* Proxies](#42-salmonella-enterica-proxies)
    - [<span class="toc-section-number">1.6.3</span> 4.3 *Vibrio* spp.
      Proxies (Aquaculture)](#43-vibrio-spp-proxies-aquaculture)
  - [<span class="toc-section-number">1.7</span> 5. Experimental
    Validation Plan](#5-experimental-validation-plan)
    - [<span class="toc-section-number">1.7.1</span> 5.1 Proxy
      Validation Workflow](#51-proxy-validation-workflow)
    - [<span class="toc-section-number">1.7.2</span> 5.2 Validation
      Metrics](#52-validation-metrics)
  - [<span class="toc-section-number">1.8</span> 6. Commercial
    Implications](#6-commercial-implications)
    - [<span class="toc-section-number">1.8.1</span> 6.1 China Market
      Access Strategy](#61-china-market-access-strategy)
    - [<span class="toc-section-number">1.8.2</span> 6.2 IP
      Considerations](#62-ip-considerations)
  - [<span class="toc-section-number">1.9</span> 7. NotebookLM
    Validation](#7-notebooklm-validation)
    - [<span class="toc-section-number">1.9.1</span> 7.1 Query for
      Evidence](#71-query-for-evidence)
    - [<span class="toc-section-number">1.9.2</span> 7.2 Add Results to
      NotebookLM](#72-add-results-to-notebooklm)
  - [<span class="toc-section-number">1.10</span> 8. Session
    Info](#8-session-info)
  - [<span class="toc-section-number">1.11</span> 9. Next
    Steps](#9-next-steps)

# Proxy Strain Analysis for China Market

## Setup

<details class="code-fold">
<summary>Code</summary>

``` r
here::i_am(paste0(params$name, ".qmd"), uuid = "e5f6a7b8-c9d0-1234-efgh-i1234567890")

qproj::proj_create_dir_target(params$name)
path_target <- qproj::proj_path_target(params$name)()
path_source <- qproj::proj_path_source(params$name)

# Read upstream data
path_01 <- qproj::proj_path_source("01-public-data-mining")
path_02 <- qproj::proj_path_source("02-phage-host-prediction")
path_04 <- qproj::proj_path_source("04-synergy-scoring")
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
library(ggtree)
```

</details>

## 1. Problem Statement

### 1.1 The “Proxy Strain” Challenge

**核心问题**：无法在德国获取中国本地病原体菌株，但需要在德国进行湿实验验证。

**Notion 文档 Section 6.2**： -
由于无法获取中国本地病原体菌株，策略是识别**可获得的国际参考菌株** -
关键约束：代理菌株必须与中国本地菌株在基因组和表型上高度相似

### 1.2 Target Pathogens for China Market

| Pathogen | Disease | Target Animal | China Market Priority |
|----|----|----|----|
| *Clostridium perfringens* | 坏死性肠炎 | 家禽 (poultry) | ⭐⭐⭐⭐⭐ |
| *Salmonella enterica* | 沙门氏菌病 | 家禽/牲畜 | ⭐⭐⭐⭐ |
| *Escherichia coli* (pathogenic) | 大肠杆菌病 | 家禽/水产 | ⭐⭐⭐⭐ |
| *Vibrio parahaemolyticus* | 急性肠胃炎 | 水产 (aquaculture) | ⭐⭐⭐ |
| *Streptococcus suis* | 猪链球菌病 | 生猪 (pig) | ⭐⭐⭐ |

## 2. Proxy Strain Selection Strategy

### 2.1 Selection Criteria

Based on Notion Research Master Plan:

1.  **Genomic similarity** \> 95% ANI (Average Nucleotide Identity)
2.  **Phage susceptibility** (similar phage receptor profiles)
3.  **Availability** (can obtain from DSMZ, ATCC, etc.)
4.  **Safety** (moderate virulence for lab work)
5.  **Publication track record** (well-characterized in literature)

### 2.2 Data Sources for Strain Comparison

<details class="code-fold">
<summary>Code</summary>

``` r
# Template: Search NCBI for available strains
if (FALSE) {
  library(rentrez)
  
  # Search for C. perfringens strains in NCBI BioSample
  search_query <- 'Clostridium perfringens[Organism] AND "China"[Geolocation] AND ("strain" OR "isolate") AND ("genome" OR "complete genome")'
  
  strains_search <- rentrez::entrez_search(
    db = "biosample",
    term = search_query,
    retmax = 100
  )
  
  # Save for analysis
  write_lines(
    strains_search$ids,
    file.path(path_target, "raw", "c_perfringens_china_strains.txt")
  )
}
```

</details>

## 3. Strain Comparison Analysis

### 3.1 ANI Calculation Template

<details class="code-fold">
<summary>Code</summary>

``` r
# Template for ANI calculation using pyani (Python) or fastANI
# Install: conda install -c bioconda pyani fastani

ani_script <- c(
  "#!/bin/bash",
  "# ANI calculation script",
  paste0("TARGET_DIR=", path_target, "/processed/ani_results"),
  "mkdir -p $TARGET_DIR",
  "",
  "# Run fastANI",
  "# fastANI -q query_genome.fasta -r reference_genome.fasta -o $TARGET_DIR/ani_output.txt",
  "",
  "# Batch ANI for multiple strains",
  "# for q in strains/*.fasta; do",
  "#   for r in reference/*.fasta; do",
  "#     fastANI -q $q -r $r -o $TARGET_DIR/$(basename $q)_vs_$(basename $r).txt",
  "#   done",
  "# done"
)

write_lines(
  ani_script,
  file.path(path_target, "scripts", "run_ani.sh")
)

# Make executable
Sys.chmod(file.path(path_target, "scripts", "run_ani.sh"), "755")
```

</details>

### 3.2 Phage Receptor Profile Comparison

<details class="code-fold">
<summary>Code</summary>

``` r
# Template: Compare phage receptor genes
# Key receptors to check:
# - LPS (Lipopolysaccharide) biosynthesis genes
# - T4P (Type IV Pilus) genes
# - Cell wall teichoic acid genes
# - Capsular polysaccharide genes

# Load genome annotations (from eggNOG-mapper or Prokka)
# query_annotation <- read_tsv(file.path(path_02, "processed", "query_annotation.tsv"))
# reference_annotation <- read_tsv(file.path(path_02, "processed", "reference_annotation.tsv"))

# Extract receptor-related genes
# receptor_genes <- c("lpx", "waa", "pil", "tat", "cap", "wzy")

# Compare presence/absence
# comparison_table <- bind_rows(
#   query_annotation %>% mutate(type = "query"),
#   reference_annotation %>% mutate(type = "reference")
# ) %>%
#   filter(grepl(paste(receptor_genes, collapse = "|"), gene_id, ignore.case = TRUE)) %>%
#   group_by(type, gene_id) %>%
#   summarise(count = n(), .groups = "drop")

# knitr::kable(comparison_table, caption = "Phage Receptor Gene Comparison")
```

</details>

## 4. Proxy Strain Candidates

### 4.1 *Clostridium perfringens* Proxies

*To be populated after analysis*

| Strain | Origin | ANI to China Isolate | Phage Susceptibility | Availability | Score |
|----|----|----|----|----|----|
| ATCC 13124 | USA | \- | Known | ATCC/DSMZ | \- |
| DSM 756 | Germany | \- | Moderate | DSMZ | \- |
| TYPE B STRAIN | \- | \- | \- | \- | \- |

### 4.2 *Salmonella enterica* Proxies

| Strain | Serovar | ANI to China Isolate | Phage Susceptibility | Availability | Score |
|----|----|----|----|----|----|
| ATCC 14028 | Typhimurium | \- | High | ATCC | \- |
| DSM 554 | Enteritidis | \- | Moderate | DSMZ | \- |

### 4.3 *Vibrio* spp. Proxies (Aquaculture)

| Strain     | Species             | Origin  | ANI | Host Range | Score |
|------------|---------------------|---------|-----|------------|-------|
| ATCC 17802 | V. parahaemolyticus | USA     | \-  | Known      | \-    |
| DSM 10027  | V. cholerae         | Germany | \-  | Moderate   | \-    |

## 5. Experimental Validation Plan

### 5.1 Proxy Validation Workflow

Based on Notion document Section 7 (The Bioinformatics-First Strategy):

**Step 1**: In silico validation - ANI \> 95% to China isolates - Phage
receptor profile match \> 80% - Metabolic capability similarity

**Step 2**: In vitro validation (Germany) - Phage isolation using proxy
strain - Efficiency of plating (EOP) test - Lytic spectrum confirmation

**Step 3**: Technology transfer to China - Send validated phages to
China collaborator - Validate on local China isolates - Compare efficacy
(German proxy vs. China local)

### 5.2 Validation Metrics

<details class="code-fold">
<summary>Code</summary>

``` r
validation_criteria <- tibble(
  metric = c("ANI similarity", "Receptor match", "Phage susceptibility", "Lytic spectrum", "Growth inhibition"),
  threshold = c("> 95%", "> 80%", "> 90%", "> 5 strains", "> 2 log reduction"),
  method = c("fastANI", "Gene presence/absence", "EOP assay", "Spot test", "In vitro co-culture")
)

knitr::kable(validation_criteria, caption = "Proxy Strain Validation Criteria")
```

</details>

## 6. Commercial Implications

### 6.1 China Market Access Strategy

From Notion document: - **Competing companies**: 青岛诺安百特 (Qingdao
Nuo’anbai), CJ BIO (Korea) - **Strategy**: Use German lab for R&D, China
partner for trials + commercialization - **Timeline**: Proxy validation
(3 months) → China validation (6 months) → Market entry (12 months)

### 6.2 IP Considerations

- Patent strategy must cover **both** proxy and local strain
  applications
- Phage cocktails should be broad enough to cover strain variations
- Probiotic combinations need to be effective across strain spectra

## 7. NotebookLM Validation

### 7.1 Query for Evidence

Use NotebookLM to validate proxy strain strategy:

``` bash
nlm notebook query phage-synergy "What proxy strains are used for Clostridium perfringens research in Europe?"
```

### 7.2 Add Results to NotebookLM

After completing proxy analysis, add to NotebookLM:

``` bash
nlm source add phage-synergy --text "$(cat proxy_strain_report.txt)" --title "Proxy Strain Analysis pr0117"
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
     [1] ggtree_4.0.5    ape_5.8-1       qproj_0.1.5     here_1.0.2     
     [5] lubridate_1.9.5 forcats_1.0.1   stringr_1.6.0   dplyr_1.2.1    
     [9] purrr_1.2.1     readr_2.2.0     tidyr_1.3.2     tibble_3.3.1   
    [13] ggplot2_4.0.2   tidyverse_2.0.0

    loaded via a namespace (and not attached):
     [1] gtable_0.3.6            xfun_0.57               htmlwidgets_1.6.4      
     [4] lattice_0.22-9          tzdb_0.5.0              vctrs_0.7.2            
     [7] tools_4.5.3             generics_0.1.4          yulab.utils_0.2.4      
    [10] parallel_4.5.3          pkgconfig_2.0.3         ggplotify_0.1.3        
    [13] RColorBrewer_1.1-3      S7_0.2.1                lifecycle_1.0.5        
    [16] compiler_4.5.3          farver_2.1.2            treeio_1.34.0          
    [19] codetools_0.2-20        ggfun_0.2.0             fontquiver_0.2.1       
    [22] fontLiberation_0.1.0    htmltools_0.5.9         yaml_2.3.12            
    [25] lazyeval_0.2.3          pillar_1.11.1           MASS_7.3-65            
    [28] nlme_3.1-168            fontBitstreamVera_0.1.1 tidyselect_1.2.1       
    [31] aplot_0.2.9             digest_0.6.39           stringi_1.8.7          
    [34] rprojroot_2.1.1         fastmap_1.2.0           grid_4.5.3             
    [37] cli_3.6.5               magrittr_2.0.5          patchwork_1.3.2        
    [40] withr_3.0.2             gdtools_0.5.0           scales_1.4.0           
    [43] rappdirs_0.3.4          timechange_0.4.0        rmarkdown_2.31         
    [46] otel_0.2.0              hms_1.1.4               evaluate_1.0.5         
    [49] knitr_1.51              gridGraphics_0.5-1      rlang_1.2.0            
    [52] ggiraph_0.9.6           Rcpp_1.1.1              glue_1.8.0             
    [55] tidytree_0.4.7          jsonlite_2.0.0          R6_2.6.1               
    [58] systemfonts_1.3.2       fs_2.0.1               

## 9. Next Steps

1.  **Complete ANI analysis** for top candidate strains
2.  **Validate phage receptor profiles** against literature
3.  **Order proxy strains** from DSMZ/ATCC
4.  **Design validation experiments** (Germany lab)
5.  **Proceed to Module 06** (`06-mechanism-exploration.qmd`)

------------------------------------------------------------------------

*Generated by qproj workflow for pr0117-PhageProbioticSynergy*
