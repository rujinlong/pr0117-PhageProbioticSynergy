Your Name

---

execute: false 2\|title: “Phage-Host Prediction Analysis” 3\|params: 4\|
name: “02-phage-host-prediction” 5\|— 6\| 7\|# Phage-Host Prediction for
Animal Pathogens 8\| 9\|## Setup 10\|
11\|`{r setup}     12|here::i_am(paste0(params$name, ".qmd"), uuid = "b2c3d4e5-f6a7-8901-bcde-f1234567890")     13|     14|# qproj setup     15|qproj::proj_create_dir_target(params$name)     16|path_target <- qproj::path_target(params$name)     17|path_source <- qproj::path_source(params$name)     18|     19|# Read upstream data     20|path_upstream <- qproj::path_source("01-public-data-mining")     21|`
22\| 23\|## Load Packages 24\|
25\|`{r packages}     26|library(tidyverse)     27|library(here)     28|library(qproj)     29|library(ape)     30|library(ggplot2)     31|# For phage-host prediction     32|# library(phageR)      # If available     33|# library(vConTACT2R)  # If available     34|`
35\| 36\|## 1. Objective 37\| 38\|Predict which phages can effectively
target specific animal pathogens: 39\|- **Target pathogens**:
*Clostridium perfringens*, *Salmonella enterica*, *E. coli*, *Vibrio*
spp. 40\|- **Goal**: Identify lytic phages with broad host range or
specific activity 41\|- **Approach**: Use computational tools + existing
databases (phagesDB, MVP, vConTACT3) 42\| 43\|## 2. Phage-Host
Prediction Tools Review 44\| 45\|Based on NotebookLM research (34
sources imported), key tools include: 46\| 47\|### 2.1 Sequence-Based
Methods 48\|- **vConTACT3**: Viral protein cluster networks, genus-level
prediction 49\|- **PHIAF**: Phage-host interaction predictor using k-mer
features 50\|- **DeepHost**: Deep learning approach using genomic
features 51\|- **WIsH**: k-mer based method 52\| 53\|### 2.2
Structure-Based Methods 54\|- **PHP**: Prokaryotic host prediction using
structural features 55\|- **VHQS**: Quality scoring for predicted
interactions 56\| 57\|### 2.3 Integrated Pipelines 58\|-
**ViroProfiler** (our existing tool) 59\|- **TPD** (Therapeutic Phage
Discovery pipeline) 60\| 61\|## 3. Database Integration 62\| 63\|### 3.1
Download Phage Genomes from RefSeq 64\| 65\|Template for downloading
phage genomes targeting our pathogens of interest. 66\|
67\|`{r download-phage-genomes}     68|#| eval: false     69|     70|# Using entrez to download phage genomes     71|if (FALSE) {  # Set to TRUE when ready     72|  library(rentrez)     73|       74|  # Search for phages targeting C. perfringens     75|  search_cperf <- rentrez::entrez_search(     76|    db = "nucleotide",     77|    term = "Clostridium perfringens phage[Organism] AND refseq[filter]",     78|    retmax = 100     79|  )     80|       81|  # Download sequences     82|  phage_seqs <- rentrez::entrez_fetch(     83|    db = "nucleotide",     84|    id = search_cperf$ids,     85|    rettype = "fasta"     86|  )     87|       88|  # Save     89|  writeLines(     90|    phage_seqs,     91|    file.path(path_target, "raw", "c_perfringens_phages.fasta")     92|  )     93|}     94|`
95\| 96\|### 3.2 Load Existing Database 97\| 98\|Load phage-host
interaction data from integrated databases. 99\|
100\|`{r load-databases}    101|#| eval: false    102|    103|# Template: Load phagesDB data    104|# Source: https://phagesdb.org/download/    105|phagesdb_url <- "https://phagesdb.org/media/ExportDatasets/"    106|    107|# Template: Load vConTACT3 results if available    108|# vcontact_results <- read_tsv(file.path(path_upstream, "processed", "vcontact_results.tsv"))    109|    110|message("Database loading templates ready")    111|`
112\| 113\|## 4. Host Prediction Analysis 114\| 115\|### 4.1 Using
ViroProfiler Pipeline 116\| 117\|Our existing ViroProfiler pipeline can
be used for phage-host prediction. 118\|
119\|`{r viroprofiler-template}    120|#| eval: false    121|    122|# Template for running ViroProfiler    123|# ViroProfiler path (update as needed)    124|viroprofiler_path <- "~/tools/ViroProfiler"    125|    126|# Command template    127|viroprofiler_cmd <- sprintf(    128|  "cd %s && bash run_viroprofiler.sh -i %s -o %s -t phage_host",    129|  viroprofiler_path,    130|  file.path(path_upstream, "raw", "phage_contigs.fasta"),    131|  file.path(path_target, "processed", "viroprofiler_output")    132|)    133|    134|# Execute (when ready)    135|# system(viroprofiler_cmd)    136|`
137\| 138\|### 4.2 Using vConTACT3 139\| 140\|vConTACT3 for viral
cluster-based host prediction. 141\|
142\|`{r vcontact-template}    143|#| eval: false    144|    145|# Template for vConTACT3 analysis    146|# Input: viral protein files    147|# Output: cluster network with host predictions    148|    149|vcontact_cmd <- sprintf(    150|  "vcontact3 --input-file %s --output-dir %s --threads 8",    151|  file.path(path_upstream, "processed", "viral_proteins.faa"),    152|  file.path(path_target, "processed", "vcontact3_output")    153|)    154|    155|# Execute (when ready)    156|# system(vcontact_cmd)    157|`
158\| 159\|## 5. Results Integration 160\| 161\|### 5.1 Parse Prediction
Results 162\|
163\|`{r parse-results}    164|#| eval: false    165|    166|# Template: Parse ViroProfiler/vConTACT3 results    167|# results_df <- read_tsv(file.path(path_target, "processed", "predictions.tsv"))    168|    169|# Summary table template    170|# summary_table <- results_df %>%    171|#   group_by(target_pathogen, phage_id) %>%    172|#   summarise(    173|#     prediction_score = mean(score),    174|#     n_tools = n_distinct(tool),    175|#     .groups = "drop"    176|#   ) %>%    177|#   arrange(desc(prediction_score))    178|    179|# knitr::kable(summary_table, caption = "Phage-Host Prediction Results")    180|`
181\| 182\|### 5.2 Visualization 183\|
184\|`{r visualize-predictions}    185|#| eval: false    186|    187|# Template: Visualize prediction results    188|# ggplot(summary_table, aes(x = target_pathogen, y = prediction_score, fill = n_tools)) +    189|#   geom_boxplot() +    190|#   theme_minimal() +    191|#   labs(title = "Phage-Host Prediction Scores by Pathogen",    192|#        x = "Target Pathogen", y = "Prediction Score")    193|`
194\| 195\|## 6. Candidate Phage Selection 196\| 197\|### 6.1 Selection
Criteria 198\| 199\|Based on the Research Master Plan: 200\|1. **Lytic
lifestyle** (not temperate) 201\|2. **Broad host range** (target
multiple strains) 202\|3. **Genomic stability** (few lysogenic genes)
203\|4. **Safety profile** (no toxin genes, no AMR genes) 204\| 205\|###
6.2 Top Candidates Table 206\| 207\|*To be populated after running
predictions* 208\| 209\|\| Phage ID \| Target Pathogen \| Prediction
Score \| Lifestyle \| Host Range \| Notes \|
210\|\|———–\|—————–\|——————\|————\|————-\|——-\| 211\|\| TBD \| C.
perfringens \| - \| lytic \| - \| - \| 212\|\| TBD \| S. enterica \| -
\| lytic \| - \| - \| 213\|\| TBD \| E. coli \| - \| lytic \| - \| - \|
214\|\| TBD \| Vibrio spp. \| - \| lytic \| - \| - \| 215\| 216\|## 7.
NotebookLM Integration 217\| 218\|### 7.1 Query NotebookLM for
Validation 219\| 220\|Use NotebookLM to validate predictions against
literature. 221\|
222\|`bash    223|nlm notebook query phage-synergy "What phages are effective against Clostridium perfringens in poultry?"    224|`
225\| 226\|### 7.2 Add Results to NotebookLM 227\| 228\|After generating
prediction results, add them as a source to NotebookLM for
cross-referencing with literature. 229\|
230\|`bash    231|# Convert results to text/PDF and add to NotebookLM    232|nlm source add phage-synergy --text "$(cat predictions_summary.txt)" --title "Phage-Host Predictions pr0117"    233|`
234\| 235\|## 8. Session Info 236\|
237\|`{r session-info}    238|sessionInfo()    239|` 240\| 241\|## 9.
Next Steps 242\| 243\|1. **Run ViroProfiler** on target phage genomes
244\|2. **Run vConTACT3** for cluster-based predictions 245\|3.
**Integrate results** from multiple tools 246\|4. **Validate
predictions** using NotebookLM literature 247\|5. **Proceed to Module
03** (`03-probiotic-target-identification.qmd`) 248\| 249\|—
250\|*Generated by qproj workflow for pr0117-PhageProbioticSynergy*
251\| 252\|
