# Probiotic Target Identification
Your Name

- [<span class="toc-section-number">1</span> Probiotic Target
  Identification](#probiotic-target-identification)
  - [<span class="toc-section-number">1.1</span> Setup](#setup)
  - [<span class="toc-section-number">1.2</span> Load
    Packages](#load-packages)
  - [<span class="toc-section-number">1.3</span> 1.
    Objective](#1-objective)
  - [<span class="toc-section-number">1.4</span> 2. Probiotic
    Colonization Requirements](#2-probiotic-colonization-requirements)
    - [<span class="toc-section-number">1.4.1</span> 2.1 Key Factors for
      Gut Colonization](#21-key-factors-for-gut-colonization)
    - [<span class="toc-section-number">1.4.2</span> 2.2 Receptor
      Landscape Analysis](#22-receptor-landscape-analysis)
  - [<span class="toc-section-number">1.5</span> 3. Probiotic Fitness
    Knowledge Graph (Strategy 3
    Enhancement)](#3-probiotic-fitness-knowledge-graph-strategy-3-enhancement)
    - [<span class="toc-section-number">1.5.1</span> 3.1 Knowledge Graph
      Construction](#31-knowledge-graph-construction)
    - [<span class="toc-section-number">1.5.2</span> 3.2 Feature
      Engineering for ML
      Scoring](#32-feature-engineering-for-ml-scoring)
    - [<span class="toc-section-number">1.5.3</span> 3.3 XGBoost Model
      for Probiotic Ranking](#33-xgboost-model-for-probiotic-ranking)
    - [<span class="toc-section-number">1.5.4</span> 3.4 Visualization
      with Cytoscape](#34-visualization-with-cytoscape)
  - [<span class="toc-section-number">1.6</span> 4. Niche Competition
    Modeling](#4-niche-competition-modeling)
    - [<span class="toc-section-number">1.6.1</span> 4.1 Ecological
      Niche Overlap](#41-ecological-niche-overlap)
    - [<span class="toc-section-number">1.6.2</span> 3.2 Phage Impact
      Simulation](#32-phage-impact-simulation)
  - [<span class="toc-section-number">1.7</span> 4. Probiotic
    Ranking](#4-probiotic-ranking)
    - [<span class="toc-section-number">1.7.1</span> 4.1 Ranking
      Criteria](#41-ranking-criteria)
    - [<span class="toc-section-number">1.7.2</span> 4.2 Preliminary
      Ranking](#42-preliminary-ranking)
  - [<span class="toc-section-number">1.8</span> 5. Genomic
    Analysis](#5-genomic-analysis)
    - [<span class="toc-section-number">1.8.1</span> 5.1 Probiotic
      Genome Features](#51-probiotic-genome-features)
    - [<span class="toc-section-number">1.8.2</span> 5.2 Comparative
      Genomics](#52-comparative-genomics)
  - [<span class="toc-section-number">1.9</span> 6. NotebookLM
    Validation](#6-notebooklm-validation)
    - [<span class="toc-section-number">1.9.1</span> 6.1 Query for
      Probiotic Evidence](#61-query-for-probiotic-evidence)
    - [<span class="toc-section-number">1.9.2</span> 6.2 Add Analysis
      Results](#62-add-analysis-results)
  - [<span class="toc-section-number">1.10</span> 7. Session
    Info](#7-session-info)
  - [<span class="toc-section-number">1.11</span> 8. Next
    Steps](#8-next-steps)

# Probiotic Target Identification

## Setup

<details class="code-fold">
<summary>Code</summary>

``` r
here::i_am(paste0(params$name, ".qmd"), uuid = "c3d4e5f6-a7b8-9012-cdef-1234567890")

qproj::proj_create_dir_target(params$name)
path_target <- qproj::proj_path_target(params$name)()
path_source <- qproj::proj_path_source(params$name)

# Read upstream data
path_01 <- qproj::proj_path_source("01-public-data-mining")
path_02 <- qproj::proj_path_source("02-phage-host-prediction")
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

Identify which probiotic bacteria benefit most from phage-mediated niche
clearing:

- **Target probiotics**: *Lactobacillus*, *Bifidobacterium*, *Bacillus*,
  *Enterococcus*
- **Goal**: Understand colonization requirements, receptor usage,
  metabolic dependencies
- **Outcome**: Rank probiotics by expected synergy with phages

## 2. Probiotic Colonization Requirements

### 2.1 Key Factors for Gut Colonization

Based on NotebookLM literature review:

| Factor | Description | Relevance to Synergy |
|----|----|----|
| Adhesion molecules | Bind to gut epithelial cells | Phage clearing competitors → more adhesion sites |
| Metabolic flexibility | Utilize diverse carbon sources | Survive after pathogen removal |
| Bile tolerance | Survive gut environment | Essential for delivery |
| Competitive exclusion | Outcompete pathogens | Enhanced by phage predation |
| Immune modulation | Regulate host immune response | Complementary to phage action |

### 2.2 Receptor Landscape Analysis

Analyze what receptors/pathways probiotics use for colonization.

<details class="code-fold">
<summary>Code</summary>

``` r
# Template: Analyze probiotic genome for adhesion factors
# Key gene families to search:
# - Mub (mucin-binding protein)
# - SpaCBA (sortase-anchored pilus)
# - LBA (lactobacillus adhesin)
# - S-layer proteins

# Example using eggnog-mapper results (if available)
# probiotic_genes <- read_tsv(file.path(path_02, "processed", "probiotic_annotation.tsv"))

# Filter for adhesion-related genes
# adhesion_genes <- probiotic_genes %>%
#   filter(grepl("adhesin|mucin|pilus|pilin|S-layer", description, ignore.case = TRUE))

# knitr::kable(head(adhesion_genes, 10), caption = "Adhesion-Related Genes in Probiotics")
```

</details>

## 3. Probiotic Fitness Knowledge Graph (Strategy 3 Enhancement)

### 3.1 Knowledge Graph Construction

Build a knowledge graph integrating multiple databases for objective
probiotic scoring.

<details class="code-fold">
<summary>Code</summary>

``` python
# Knowledge graph using NetworkX (Python)
import networkx as nx
import pandas as pd
import json

# Initialize knowledge graph
G = nx.DiGraph()

# === Node types ===
# 1. Probiotic strains (from ProbiMed/BacMap)
probiotics = pd.DataFrame({
    'strain': ['Lactobacillus_acidophilus_NCFM', 'Bifidobacterium_lactis_BB12', 
               'Bacillus_subtilis_NRRL_B-30809', 'Enterococcus_faecium_NCIMB_10415'],
    'genome_size': [1.9, 2.2, 4.2, 2.8],  # Mbp
    'GC_content': [35.2, 58.1, 43.5, 37.8],
    'origin': ['human', 'animal', 'soil', 'animal']
})

# Add probiotic nodes
for _, row in probiotics.iterrows():
    G.add_node(row['strain'], type='probiotic', **row.to_dict())

# 2. Functional modules (from KEGG/BacMap)
functional_modules = [
    ('bacteriocin_synthesis', 'pathway', {'category': 'antimicrobial'}),
    ('adhesion_proteins', 'pathway', {'category': 'colonization'}),
    ('bile_salt_hydrolase', 'pathway', {'category': 'survival'}),
    ('short_chain_fatty_acid', 'pathway', {'category': 'metabolism'}),
    ('CRISPR_Cas', 'pathway', {'category': 'defense'})
]

G.add_nodes_from([(m[0], m[2]) for m in functional_modules])

# 3.Edgetypes: has_pathway, inhibits, enhances_synergy
# Example edges (would be populated from real DB queries)
edges = [
    ('Lactobacillus_acidophilus_NCFM', 'adhesion_proteins', {'weight': 0.9}),
    ('Lactobacillus_acidophilus_NCFM', 'bacteriocin_synthesis', {'weight': 0.8}),
    ('bacteriocin_synthesis', 'pathogen_suppression', {'weight': 0.85}),
    ('adhesion_proteins', 'gut_colonization', {'weight': 0.9})
]

G.add_edges_from(edges)

print(f"Knowledge graph created: {G.number_of_nodes()} nodes, {G.number_of_edges()} edges")
```

</details>

### 3.2 Feature Engineering for ML Scoring

Extract quantifiable features from genomes and knowledge graph.

<details class="code-fold">
<summary>Code</summary>

``` python
import numpy as np
from sklearn.preprocessing import StandardScaler

# Feature matrix (example - would be computed from real data)
features = pd.DataFrame({
    'strain': probiotics['strain'],
    'genome_size_mbp': probiotics['genome_size'],
    'gc_content': probiotics['GC_content'],
    'bacteriocin_genes': [5, 3, 8, 6],  # Count from genome annotation
    'adhesion_genes': [12, 8, 4, 10],
    'bile_tolerance_score': [0.9, 0.85, 0.6, 0.8],  # From experiments
    'gut_colonization_score': [0.85, 0.8, 0.5, 0.75],  # From animal trials
    'cr CRISPR_spacers': [15, 22, 8, 18],  # From CRISPR array analysis
    'niche_overlap_pathogen': [0.7, 0.6, 0.4, 0.65]  # Computed from niche modeling
})

# Target variable: synergy score (to be predicted/validated)
# This would come from literature + experimental validation
features['synergy_score'] = [0.82, 0.78, 0.55, 0.75]  # Placeholder

print("Feature matrix shape:", features.shape)
print(features.head())
```

</details>

### 3.3 XGBoost Model for Probiotic Ranking

Train ML model to predict probiotic synergy potential with
hyperparameter tuning.

<details class="code-fold">
<summary>Code</summary>

``` python
import xgboost as xgb
from sklearn.model_selection import train_test_split, cross_val_score, GridSearchCV
from sklearn.metrics import mean_squared_error, r2_score, mean_absolute_error
import pandas as pd
import numpy as np

# Prepare data
X = features.drop(['strain', 'synergy_score'], axis=1)
y = features['synergy_score']

# Train-test split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

# === Base model ===
model = xgb.XGBRegressor(
    n_estimators=100,
    max_depth=3,
    learning_rate=0.1,
    random_state=42
)
model.fit(X_train, y_train)

# Predictions
y_pred = model.predict(X_test)
mse = mean_squared_error(y_test, y_pred)
r2 = r2_score(y_test, y_pred)
mae = mean_absolute_error(y_test, y_pred)

print(f"Base Model Performance:")
print(f"  MSE: {mse:.4f}")
print(f"  R² Score: {r2:.4f}")
print(f"  MAE: {mae:.4f}")

# === Cross-validation ===
print(f"\n=== Cross-Validation (5-fold) ===")
cv_scores = cross_val_score(model, X, y, cv=5, scoring='r2')
print(f"  R² scores: {cv_scores}")
print(f"  Mean R²: {cv_scores.mean():.4f} (+/- {cv_scores.std():.4f})")

# === Hyperparameter Tuning ===
print(f"\n=== Hyperparameter Tuning (GridSearch) ===")
param_grid = {
    'n_estimators': [50, 100, 200],
    'max_depth': [3, 5, 7],
    'learning_rate': [0.01, 0.1, 0.3],
    'subsample': [0.8, 1.0],
    'colsample_bytree': [0.8, 1.0]
}

grid_search = GridSearchCV(
    xgb.XGBRegressor(random_state=42),
    param_grid,
    cv=5,
    scoring='r2',
    n_jobs=-1,
    verbose=1
)
grid_search.fit(X_train, y_train)

print(f"\nBest parameters: {grid_search.best_params_}")
print(f"Best cross-validation R²: {grid_search.best_score_:.4f}")

# Use best model
best_model = grid_search.best_estimator_
y_pred_best = best_model.predict(X_test)
r2_best = r2_score(y_test, y_pred_best)
print(f"Test R² with tuned model: {r2_best:.4f}")

# === Feature Importance (from best model) ===
importance = pd.DataFrame({
    'feature': X.columns,
    'importance': best_model.feature_importances_
}).sort_values('importance', ascending=False)

print(f"\nFeature Importance (Tuned Model):")
print(importance)

# === Save model ===
import joblib
joblib.dump(best_model, 'probiotic_synergy_model.pkl')
print(f"\n✓ Model saved to probiotic_synergy_model.pkl")
```

</details>

### 3.4 Visualization with Cytoscape

Visualize knowledge graph and feature importance.

<details class="code-fold">
<summary>Code</summary>

``` r
# R interface to Cytoscape (if available)
if (requireNamespace("RCy3", quietly = TRUE)) {
  library(RCy3)
  
  # Create Cytoscape network from Python-computed graph
  # (Integration would require exporting G to CSV/JSON)
  
  # Example: Bar plot of feature importance
  library(ggplot2)
  
  ggplot(importance, aes(x = reorder(feature, importance), y = importance)) +
    geom_bar(stat = "identity", fill = "steelblue") +
    coord_flip() +
    theme_minimal() +
    labs(title = "Feature Importance for Probiotic Synergy Prediction",
         x = "Feature", y = "Importance (XGBoost)")
}
```

</details>

## 4. Niche Competition Modeling

### 4.1 Ecological Niche Overlap

Model the competitive relationship between pathogens and probiotics.

<details class="code-fold">
<summary>Code</summary>

``` r
# Template: Calculate niche overlap index
# Based on:
# - Carbon source utilization profiles
# - Oxygen tolerance
# - pH optima
# - Temperature range
# - Receptor usage

# Example data structure
niche_data <- tibble(
  species = c("C. perfringens", "L. acidophilus", "S. enterica", "B. subtilis"),
  temp_opt (c(37, 37, 37, 30)),  # Celsius
  pH_opt (c(6.5, 6.0, 7.0, 7.5)),
  oxygen = c("anaerobic", "microaerophilic", "facultative", "aerobic"),
  carbon_sources = c(4, 6, 8, 10)  # Number of carbon sources utilized
)

# Calculate overlap score (simplified)
# Overlap = 1 / (1 + |temp_diff| + |pH_diff| + |carbon_diff|)
```

</details>

### 3.2 Phage Impact Simulation

Simulate how phage predation on pathogens opens niche space for
probiotics.

<details class="code-fold">
<summary>Code</summary>

``` r
# Template: Simple competition model
# Initial abundances
initial_state <- tibble(
  species = c("Pathogen", "Probiotic", "Commensal1", "Commensal2"),
  abundance = c(100, 10, 50, 40),
  growth_rate = c(1.2, 0.8, 0.9, 0.7),
  susceptibility = c(1.0, 0.0, 0.3, 0.2)  # Phage susceptibility
)

# Simulation parameters
phage_mortality <- 0.8  # Pathogen mortality due to phage

# Simulate after phage treatment
post_phage <- initial_state %>%
  mutate(
    new_abundance = ifelse(susceptibility > 0,
      abundance * (1 - susceptibility * phage_mortality),
      abundance * (1 + growth_rate * 0.1))
  )

# Visualize
# ggplot(post_phage, aes(x = species, y = new_abundance, fill = species)) +
#   geom_bar(stat = "identity") +
#   theme_minimal() +
#   labs(title = "Abundance After Phage Treatment",
#        y = "Relative Abundance", x = "")
```

</details>

## 4. Probiotic Ranking

### 4.1 Ranking Criteria

From the Research Master Plan:

| Criterion | Weight | Description |
|----|----|----|
| Niche overlap with pathogen | 0.3 | Higher overlap = more benefit from phage |
| Lytic phage availability | 0.25 | Ensure effective phages exist |
| Commercial availability | 0.2 | Ready for application |
| Safety profile | 0.15 | GRAS status, no virulence |
| Mechanism clarity | 0.1 | Understanding of synergy |

### 4.2 Preliminary Ranking

*To be populated after analysis*

| Rank | Probiotic | Target Pathogen | Niche Overlap | Phage Available | Score |
|------|-----------|-----------------|---------------|-----------------|-------|
| 1    | TBD       | TBD             | \-            | \-              | \-    |
| 2    | TBD       | TBD             | \-            | \-              | \-    |
| 3    | TBD       | TBD             | \-            | \-              | \-    |

## 5. Genomic Analysis

### 5.1 Probiotic Genome Features

Analyze probiotic genomes for synergy-relevant features.

<details class="code-fold">
<summary>Code</summary>

``` r
# Template: Analyze probiotic genomes
# Load probiotic genome annotations
# probiotic_gff <- rtracklayer::import.gff3(file.path(path_02, "raw", "probiotic_genomes.gff"))

# Extract features of interest
# - Bacteriocin genes (competitive advantage)
# - Carbohydrate utilization loci (niche exploitation)
# - Stress response genes (survival)
# - Bile salt hydrolase (gut adaptation)
```

</details>

### 5.2 Comparative Genomics

Compare probiotic strains for optimal selection.

<details class="code-fold">
<summary>Code</summary>

``` r
# Template: Compare multiple strains of same species
# Identify core and accessory genome
# Focus on strains with proven efficacy in animal trials
```

</details>

## 6. NotebookLM Validation

### 6.1 Query for Probiotic Evidence

Use NotebookLM to validate probiotic selection.

``` bash
nlm notebook query phage-synergy "Which Lactobacillus strains show best colonization in poultry gut?"
```

### 6.2 Add Analysis Results

After generating ranking, add to NotebookLM for literature
cross-validation.

``` bash
nlm source add phage-synergy --text "$(cat probiotic_ranking.txt)" --title "Probiotic Ranking pr0117"
```

## 7. Session Info

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
     [1] Matrix_1.7-4       gtable_0.3.6       jsonlite_2.0.0     compiler_4.5.3    
     [5] Rcpp_1.1.1         tidyselect_1.2.1   png_0.1-9          scales_1.4.0      
     [9] yaml_2.3.12        fastmap_1.2.0      lattice_0.22-9     reticulate_1.46.0 
    [13] R6_2.6.1           generics_0.1.4     knitr_1.51         rprojroot_2.1.1   
    [17] tzdb_0.5.0         pillar_1.11.1      RColorBrewer_1.1-3 rlang_1.2.0       
    [21] stringi_1.8.7      xfun_0.57          fs_2.0.1           S7_0.2.1          
    [25] otel_0.2.0         timechange_0.4.0   cli_3.6.5          withr_3.0.2       
    [29] magrittr_2.0.5     digest_0.6.39      grid_4.5.3         hms_1.1.4         
    [33] lifecycle_1.0.5    vctrs_0.7.2        evaluate_1.0.5     glue_1.8.0        
    [37] farver_2.1.2       codetools_0.2-20   rmarkdown_2.31     tools_4.5.3       
    [41] pkgconfig_2.0.3    htmltools_0.5.9   

## 8. Next Steps

1.  **Complete genomic analysis** of top probiotic candidates
2.  **Finalize ranking** based on multi-criteria assessment
3.  **Cross-validate** with NotebookLM literature
4.  **Proceed to Module 04** (`04-synergy-scoring.qmd`)

------------------------------------------------------------------------

*Generated by qproj workflow for pr0117-PhageProbioticSynergy*
