Your Name

---

execute: false 2\|title: “Probiotic Target Identification” 3\|params:
4\| name: “03-probiotic-target-identification” 5\|— 6\| 7\|# Probiotic
Target Identification 8\| 9\|## Setup 10\|
11\|`{r setup}     12|here::i_am(paste0(params$name, ".qmd"), uuid = "c3d4e5f6-a7b8-9012-cdef-1234567890")     13|     14|qproj::proj_create_dir_target(params$name)     15|path_target <- qproj::path_target(params$name)     16|path_source <- qproj::path_source(params$name)     17|     18|# Read upstream data     19|path_01 <- qproj::path_source("01-public-data-mining")     20|path_02 <- qproj::path_source("02-phage-host-prediction")     21|`
22\| 23\|## Load Packages 24\|
25\|`{r packages}     26|library(tidyverse)     27|library(here)     28|library(qproj)     29|library(ggplot2)     30|`
31\| 32\|## 1. Objective 33\| 34\|Identify which probiotic bacteria
benefit most from phage-mediated niche clearing: 35\| 36\|- **Target
probiotics**: *Lactobacillus*, *Bifidobacterium*, *Bacillus*,
*Enterococcus* 37\|- **Goal**: Understand colonization requirements,
receptor usage, metabolic dependencies 38\|- **Outcome**: Rank
probiotics by expected synergy with phages 39\| 40\|## 2. Probiotic
Colonization Requirements 41\| 42\|### 2.1 Key Factors for Gut
Colonization 43\| 44\|Based on NotebookLM literature review: 45\| 46\|\|
Factor \| Description \| Relevance to Synergy \|
47\|\|——–\|————-\|———————\| 48\|\| Adhesion molecules \| Bind to gut
epithelial cells \| Phage clearing competitors → more adhesion sites \|
49\|\| Metabolic flexibility \| Utilize diverse carbon sources \|
Survive after pathogen removal \| 50\|\| Bile tolerance \| Survive gut
environment \| Essential for delivery \| 51\|\| Competitive exclusion \|
Outcompete pathogens \| Enhanced by phage predation \| 52\|\| Immune
modulation \| Regulate host immune response \| Complementary to phage
action \| 53\| 54\|### 2.2 Receptor Landscape Analysis 55\| 56\|Analyze
what receptors/pathways probiotics use for colonization. 57\|
58\|`{r receptor-analysis-template}     59|#| eval: false     60|     61|# Template: Analyze probiotic genome for adhesion factors     62|# Key gene families to search:     63|# - Mub (mucin-binding protein)     64|# - SpaCBA (sortase-anchored pilus)     65|# - LBA (lactobacillus adhesin)     66|# - S-layer proteins     67|     68|# Example using eggnog-mapper results (if available)     69|# probiotic_genes <- read_tsv(file.path(path_02, "processed", "probiotic_annotation.tsv"))     70|     71|# Filter for adhesion-related genes     72|# adhesion_genes <- probiotic_genes %>%     73|#   filter(grepl("adhesin|mucin|pilus|pilin|S-layer", description, ignore.case = TRUE))     74|     75|# knitr::kable(head(adhesion_genes, 10), caption = "Adhesion-Related Genes in Probiotics")     76|`
77\| 78\|## 3. Probiotic Fitness Knowledge Graph (Strategy 3
Enhancement) 79\| 80\|### 3.1 Knowledge Graph Construction 81\|
82\|Build a knowledge graph integrating multiple databases for objective
probiotic scoring. 83\|
84\|`{python knowledge-graph}     85|#| eval: false     86|     87|# Knowledge graph using NetworkX (Python)     88|import networkx as nx     89|import pandas as pd     90|import json     91|     92|# Initialize knowledge graph     93|G = nx.DiGraph()     94|     95|# === Node types ===     96|# 1. Probiotic strains (from ProbiMed/BacMap)     97|probiotics = pd.DataFrame({     98|    'strain': ['Lactobacillus_acidophilus_NCFM', 'Bifidobacterium_lactis_BB12',      99|               'Bacillus_subtilis_NRRL_B-30809', 'Enterococcus_faecium_NCIMB_10415'],    100|    'genome_size': [1.9, 2.2, 4.2, 2.8],  # Mbp    101|    'GC_content': [35.2, 58.1, 43.5, 37.8],    102|    'origin': ['human', 'animal', 'soil', 'animal']    103|})    104|    105|# Add probiotic nodes    106|for _, row in probiotics.iterrows():    107|    G.add_node(row['strain'], type='probiotic', **row.to_dict())    108|    109|# 2. Functional modules (from KEGG/BacMap)    110|functional_modules = [    111|    ('bacteriocin_synthesis', 'pathway', {'category': 'antimicrobial'}),    112|    ('adhesion_proteins', 'pathway', {'category': 'colonization'}),    113|    ('bile_salt_hydrolase', 'pathway', {'category': 'survival'}),    114|    ('short_chain_fatty_acid', 'pathway', {'category': 'metabolism'}),    115|    ('CRISPR_Cas', 'pathway', {'category': 'defense'})    116|]    117|    118|G.add_nodes_from([(m[0], m[2]) for m in functional_modules])    119|    120|# 3.Edgetypes: has_pathway, inhibits, enhances_synergy    121|# Example edges (would be populated from real DB queries)    122|edges = [    123|    ('Lactobacillus_acidophilus_NCFM', 'adhesion_proteins', {'weight': 0.9}),    124|    ('Lactobacillus_acidophilus_NCFM', 'bacteriocin_synthesis', {'weight': 0.8}),    125|    ('bacteriocin_synthesis', 'pathogen_suppression', {'weight': 0.85}),    126|    ('adhesion_proteins', 'gut_colonization', {'weight': 0.9})    127|]    128|    129|G.add_edges_from(edges)    130|    131|print(f"Knowledge graph created: {G.number_of_nodes()} nodes, {G.number_of_edges()} edges")    132|`
133\| 134\|### 3.2 Feature Engineering for ML Scoring 135\| 136\|Extract
quantifiable features from genomes and knowledge graph. 137\|
138\|`{python feature-engineering}    139|#| eval: false    140|    141|import numpy as np    142|from sklearn.preprocessing import StandardScaler    143|    144|# Feature matrix (example - would be computed from real data)    145|features = pd.DataFrame({    146|    'strain': probiotics['strain'],    147|    'genome_size_mbp': probiotics['genome_size'],    148|    'gc_content': probiotics['GC_content'],    149|    'bacteriocin_genes': [5, 3, 8, 6],  # Count from genome annotation    150|    'adhesion_genes': [12, 8, 4, 10],    151|    'bile_tolerance_score': [0.9, 0.85, 0.6, 0.8],  # From experiments    152|    'gut_colonization_score': [0.85, 0.8, 0.5, 0.75],  # From animal trials    153|    'cr CRISPR_spacers': [15, 22, 8, 18],  # From CRISPR array analysis    154|    'niche_overlap_pathogen': [0.7, 0.6, 0.4, 0.65]  # Computed from niche modeling    155|})    156|    157|# Target variable: synergy score (to be predicted/validated)    158|# This would come from literature + experimental validation    159|features['synergy_score'] = [0.82, 0.78, 0.55, 0.75]  # Placeholder    160|    161|print("Feature matrix shape:", features.shape)    162|print(features.head())    163|`
164\| 165\|### 3.3 XGBoost Model for Probiotic Ranking 166\| 167\|Train
ML model to predict probiotic synergy potential with hyperparameter
tuning. 168\|
169\|`{python xgboost-model}    170|#| eval: false    171|    172|import xgboost as xgb    173|from sklearn.model_selection import train_test_split, cross_val_score, GridSearchCV    174|from sklearn.metrics import mean_squared_error, r2_score, mean_absolute_error    175|import pandas as pd    176|import numpy as np    177|    178|# Prepare data    179|X = features.drop(['strain', 'synergy_score'], axis=1)    180|y = features['synergy_score']    181|    182|# Train-test split    183|X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)    184|    185|# === Base model ===    186|model = xgb.XGBRegressor(    187|    n_estimators=100,    188|    max_depth=3,    189|    learning_rate=0.1,    190|    random_state=42    191|)    192|model.fit(X_train, y_train)    193|    194|# Predictions    195|y_pred = model.predict(X_test)    196|mse = mean_squared_error(y_test, y_pred)    197|r2 = r2_score(y_test, y_pred)    198|mae = mean_absolute_error(y_test, y_pred)    199|    200|print(f"Base Model Performance:")    201|print(f"  MSE: {mse:.4f}")    202|print(f"  R² Score: {r2:.4f}")    203|print(f"  MAE: {mae:.4f}")    204|    205|# === Cross-validation ===    206|print(f"\n=== Cross-Validation (5-fold) ===")    207|cv_scores = cross_val_score(model, X, y, cv=5, scoring='r2')    208|print(f"  R² scores: {cv_scores}")    209|print(f"  Mean R²: {cv_scores.mean():.4f} (+/- {cv_scores.std():.4f})")    210|    211|# === Hyperparameter Tuning ===    212|print(f"\n=== Hyperparameter Tuning (GridSearch) ===")    213|param_grid = {    214|    'n_estimators': [50, 100, 200],    215|    'max_depth': [3, 5, 7],    216|    'learning_rate': [0.01, 0.1, 0.3],    217|    'subsample': [0.8, 1.0],    218|    'colsample_bytree': [0.8, 1.0]    219|}    220|    221|grid_search = GridSearchCV(    222|    xgb.XGBRegressor(random_state=42),    223|    param_grid,    224|    cv=5,    225|    scoring='r2',    226|    n_jobs=-1,    227|    verbose=1    228|)    229|grid_search.fit(X_train, y_train)    230|    231|print(f"\nBest parameters: {grid_search.best_params_}")    232|print(f"Best cross-validation R²: {grid_search.best_score_:.4f}")    233|    234|# Use best model    235|best_model = grid_search.best_estimator_    236|y_pred_best = best_model.predict(X_test)    237|r2_best = r2_score(y_test, y_pred_best)    238|print(f"Test R² with tuned model: {r2_best:.4f}")    239|    240|# === Feature Importance (from best model) ===    241|importance = pd.DataFrame({    242|    'feature': X.columns,    243|    'importance': best_model.feature_importances_    244|}).sort_values('importance', ascending=False)    245|    246|print(f"\nFeature Importance (Tuned Model):")    247|print(importance)    248|    249|# === Save model ===    250|import joblib    251|joblib.dump(best_model, 'probiotic_synergy_model.pkl')    252|print(f"\n✓ Model saved to probiotic_synergy_model.pkl")    253|`
254\| 255\|### 3.4 Visualization with Cytoscape 256\| 257\|Visualize
knowledge graph and feature importance. 258\|
259\|`{r cytoscape-viz}    260|#| eval: false    261|    262|# R interface to Cytoscape (if available)    263|if (requireNamespace("RCy3", quietly = TRUE)) {    264|  library(RCy3)    265|      266|  # Create Cytoscape network from Python-computed graph    267|  # (Integration would require exporting G to CSV/JSON)    268|      269|  # Example: Bar plot of feature importance    270|  library(ggplot2)    271|      272|  ggplot(importance, aes(x = reorder(feature, importance), y = importance)) +    273|    geom_bar(stat = "identity", fill = "steelblue") +    274|    coord_flip() +    275|    theme_minimal() +    276|    labs(title = "Feature Importance for Probiotic Synergy Prediction",    277|         x = "Feature", y = "Importance (XGBoost)")    278|}    279|`
280\| 281\|## 4. Niche Competition Modeling 282\| 283\|### 4.1
Ecological Niche Overlap 284\| 285\|Model the competitive relationship
between pathogens and probiotics. 286\|
287\|`{r niche-overlap-template}    288|#| eval: false    289|    290|# Template: Calculate niche overlap index    291|# Based on:    292|# - Carbon source utilization profiles    293|# - Oxygen tolerance    294|# - pH optima    295|# - Temperature range    296|# - Receptor usage    297|    298|# Example data structure    299|niche_data <- tibble(    300|  species = c("C. perfringens", "L. acidophilus", "S. enterica", "B. subtilis"),    301|  temp_opt (c(37, 37, 37, 30)),  # Celsius    302|  pH_opt (c(6.5, 6.0, 7.0, 7.5)),    303|  oxygen = c("anaerobic", "microaerophilic", "facultative", "aerobic"),    304|  carbon_sources = c(4, 6, 8, 10)  # Number of carbon sources utilized    305|)    306|    307|# Calculate overlap score (simplified)    308|# Overlap = 1 / (1 + |temp_diff| + |pH_diff| + |carbon_diff|)    309|`
310\| 311\|### 3.2 Phage Impact Simulation 312\| 313\|Simulate how phage
predation on pathogens opens niche space for probiotics. 314\|
315\|`{r phage-impact-simulation}    316|#| eval: false    317|    318|# Template: Simple competition model    319|# Initial abundances    320|initial_state <- tibble(    321|  species = c("Pathogen", "Probiotic", "Commensal1", "Commensal2"),    322|  abundance = c(100, 10, 50, 40),    323|  growth_rate = c(1.2, 0.8, 0.9, 0.7),    324|  susceptibility = c(1.0, 0.0, 0.3, 0.2)  # Phage susceptibility    325|)    326|    327|# Simulation parameters    328|phage_mortality <- 0.8  # Pathogen mortality due to phage    329|    330|# Simulate after phage treatment    331|post_phage <- initial_state %>%    332|  mutate(    333|    new_abundance = ifelse(susceptibility > 0,    334|      abundance * (1 - susceptibility * phage_mortality),    335|      abundance * (1 + growth_rate * 0.1))    336|  )    337|    338|# Visualize    339|# ggplot(post_phage, aes(x = species, y = new_abundance, fill = species)) +    340|#   geom_bar(stat = "identity") +    341|#   theme_minimal() +    342|#   labs(title = "Abundance After Phage Treatment",    343|#        y = "Relative Abundance", x = "")    344|`
345\| 346\|## 4. Probiotic Ranking 347\| 348\|### 4.1 Ranking Criteria
349\| 350\|From the Research Master Plan: 351\| 352\|\| Criterion \|
Weight \| Description \| 353\|\|———–\|——–\|————-\| 354\|\| Niche overlap
with pathogen \| 0.3 \| Higher overlap = more benefit from phage \|
355\|\| Lytic phage availability \| 0.25 \| Ensure effective phages
exist \| 356\|\| Commercial availability \| 0.2 \| Ready for application
\| 357\|\| Safety profile \| 0.15 \| GRAS status, no virulence \|
358\|\| Mechanism clarity \| 0.1 \| Understanding of synergy \| 359\|
360\|### 4.2 Preliminary Ranking 361\| 362\|*To be populated after
analysis* 363\| 364\|\| Rank \| Probiotic \| Target Pathogen \| Niche
Overlap \| Phage Available \| Score \|
365\|\|——\|————\|—————–\|—————\|——————\|——-\| 366\|\| 1 \| TBD \| TBD
\| - \| - \| - \| 367\|\| 2 \| TBD \| TBD \| - \| - \| - \| 368\|\| 3 \|
TBD \| TBD \| - \| - \| - \| 369\| 370\|## 5. Genomic Analysis 371\|
372\|### 5.1 Probiotic Genome Features 373\| 374\|Analyze probiotic
genomes for synergy-relevant features. 375\|
376\|`{r genome-features-template}    377|#| eval: false    378|    379|# Template: Analyze probiotic genomes    380|# Load probiotic genome annotations    381|# probiotic_gff <- rtracklayer::import.gff3(file.path(path_02, "raw", "probiotic_genomes.gff"))    382|    383|# Extract features of interest    384|# - Bacteriocin genes (competitive advantage)    385|# - Carbohydrate utilization loci (niche exploitation)    386|# - Stress response genes (survival)    387|# - Bile salt hydrolase (gut adaptation)    388|`
389\| 390\|### 5.2 Comparative Genomics 391\| 392\|Compare probiotic
strains for optimal selection. 393\|
394\|`{r comparative-genomics}    395|#| eval: false    396|    397|# Template: Compare multiple strains of same species    398|# Identify core and accessory genome    399|# Focus on strains with proven efficacy in animal trials    400|`
401\| 402\|## 6. NotebookLM Validation 403\| 404\|### 6.1 Query for
Probiotic Evidence 405\| 406\|Use NotebookLM to validate probiotic
selection. 407\|
408\|`bash    409|nlm notebook query phage-synergy "Which Lactobacillus strains show best colonization in poultry gut?"    410|`
411\| 412\|### 6.2 Add Analysis Results 413\| 414\|After generating
ranking, add to NotebookLM for literature cross-validation. 415\|
416\|`bash    417|nlm source add phage-synergy --text "$(cat probiotic_ranking.txt)" --title "Probiotic Ranking pr0117"    418|`
419\| 420\|## 7. Session Info 421\|
422\|`{r session-info}    423|sessionInfo()    424|` 425\| 426\|## 8.
Next Steps 427\| 428\|1. **Complete genomic analysis** of top probiotic
candidates 429\|2. **Finalize ranking** based on multi-criteria
assessment 430\|3. **Cross-validate** with NotebookLM literature 431\|4.
**Proceed to Module 04** (`04-synergy-scoring.qmd`) 432\| 433\|—
434\|*Generated by qproj workflow for pr0117-PhageProbioticSynergy*
435\| 436\|
