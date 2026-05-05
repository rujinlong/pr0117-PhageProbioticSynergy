Your Name

---

execute: false 2\|title: “Proxy Strain Analysis for China Market”
3\|params: 4\| name: “05-proxy-strain-analysis” 5\|— 6\| 7\|# Proxy
Strain Analysis for China Market 8\| 9\|## Setup 10\|
11\|`{r setup}     12|params <- list(name = "05-proxy-strain-analysis")     13|here::i_am(paste0(params$name, ".qmd"), uuid = "e5f6a7b8-c9d0-1234-efgh-i1234567890")     14|     15|qproj::proj_create_dir_target(params$name)     16|path_target <- qproj::path_target(params$name)     17|path_source <- qproj::path_source(params$name)     18|     19|# Read upstream data     20|path_01 <- qproj::path_source("01-public-data-mining")     21|path_02 <- qproj::path_source("02-phage-host-prediction")     22|path_04 <- qproj::path_source("04-synergy-scoring")     23|`
24\| 25\|## Load Packages 26\|
27\|`{r packages}     28|library(tidyverse)     29|library(here)     30|library(qproj)     31|library(ape)     32|library(ggplot2)     33|library(ggtree)     34|`
35\| 36\|## 1. Problem Statement 37\| 38\|### 1.1 The “Proxy Strain”
Challenge 39\|
40\|**核心问题**：无法在德国获取中国本地病原体菌株，但需要在德国进行湿实验验证。
41\| 42\|**Notion 文档 Section 6.2**： 43\|-
由于无法获取中国本地病原体菌株，策略是识别**可获得的国际参考菌株** 44\|-
关键约束：代理菌株必须与中国本地菌株在基因组和表型上高度相似 45\|
46\|### 1.2 Target Pathogens for China Market 47\| 48\|\| Pathogen \|
Disease \| Target Animal \| China Market Priority \|
49\|\|———-\|———\|—————\|———————-\| 50\|\| *Clostridium perfringens* \|
坏死性肠炎 \| 家禽 (poultry) \| ⭐⭐⭐⭐⭐ \| 51\|\| *Salmonella
enterica* \| 沙门氏菌病 \| 家禽/牲畜 \| ⭐⭐⭐⭐ \| 52\|\| *Escherichia
coli* (pathogenic) \| 大肠杆菌病 \| 家禽/水产 \| ⭐⭐⭐⭐ \| 53\|\|
*Vibrio parahaemolyticus* \| 急性肠胃炎 \| 水产 (aquaculture) \| ⭐⭐⭐
\| 54\|\| *Streptococcus suis* \| 猪链球菌病 \| 生猪 (pig) \| ⭐⭐⭐ \|
55\| 56\|## 2. Proxy Strain Selection Strategy 57\| 58\|### 2.1
Selection Criteria 59\| 60\|Based on Notion Research Master Plan: 61\|
62\|1. **Genomic similarity** \> 95% ANI (Average Nucleotide Identity)
63\|2. **Phage susceptibility** (similar phage receptor profiles) 64\|3.
**Availability** (can obtain from DSMZ, ATCC, etc.) 65\|4. **Safety**
(moderate virulence for lab work) 66\|5. **Publication track record**
(well-characterized in literature) 67\| 68\|### 2.2 Data Sources for
Strain Comparison 69\|
70\|`{r data-sources}     71|#| eval: false     72|     73|# Template: Search NCBI for available strains     74|if (FALSE) {     75|  library(rentrez)     76|       77|  # Search for C. perfringens strains in NCBI BioSample     78|  search_query <- 'Clostridium perfringens[Organism] AND "China"[Geolocation] AND ("strain" OR "isolate") AND ("genome" OR "complete genome")'     79|       80|  strains_search <- rentrez::entrez_search(     81|    db = "biosample",     82|    term = search_query,     83|    retmax = 100     84|  )     85|       86|  # Save for analysis     87|  write_lines(     88|    strains_search$ids,     89|    file.path(path_target, "raw", "c_perfringens_china_strains.txt")     90|  )     91|}     92|`
93\| 94\|## 3. Strain Comparison Analysis 95\| 96\|### 3.1 ANI
Calculation Template 97\|
98\|`{r ani-template}     99|#| eval: false    100|    101|# Template for ANI calculation using pyani (Python) or fastANI    102|# Install: conda install -c bioconda pyani fastani    103|    104|ani_script <- c(    105|  "#!/bin/bash",    106|  "# ANI calculation script",    107|  paste0("TARGET_DIR=", path_target, "/processed/ani_results"),    108|  "mkdir -p $TARGET_DIR",    109|  "",    110|  "# Run fastANI",    111|  "# fastANI -q query_genome.fasta -r reference_genome.fasta -o $TARGET_DIR/ani_output.txt",    112|  "",    113|  "# Batch ANI for multiple strains",    114|  "# for q in strains/*.fasta; do",    115|  "#   for r in reference/*.fasta; do",    116|  "#     fastANI -q $q -r $r -o $TARGET_DIR/$(basename $q)_vs_$(basename $r).txt",    117|  "#   done",    118|  "# done"    119|)    120|    121|write_lines(    122|  ani_script,    123|  file.path(path_target, "scripts", "run_ani.sh")    124|)    125|    126|# Make executable    127|Sys.chmod(file.path(path_target, "scripts", "run_ani.sh"), "755")    128|`
129\| 130\|### 3.2 Phage Receptor Profile Comparison 131\|
132\|`{r receptor-comparison}    133|#| eval: false    134|    135|# Template: Compare phage receptor genes    136|# Key receptors to check:    137|# - LPS (Lipopolysaccharide) biosynthesis genes    138|# - T4P (Type IV Pilus) genes    139|# - Cell wall teichoic acid genes    140|# - Capsular polysaccharide genes    141|    142|# Load genome annotations (from eggNOG-mapper or Prokka)    143|# query_annotation <- read_tsv(file.path(path_02, "processed", "query_annotation.tsv"))    144|# reference_annotation <- read_tsv(file.path(path_02, "processed", "reference_annotation.tsv"))    145|    146|# Extract receptor-related genes    147|# receptor_genes <- c("lpx", "waa", "pil", "tat", "cap", "wzy")    148|    149|# Compare presence/absence    150|# comparison_table <- bind_rows(    151|#   query_annotation %>% mutate(type = "query"),    152|#   reference_annotation %>% mutate(type = "reference")    153|# ) %>%    154|#   filter(grepl(paste(receptor_genes, collapse = "|"), gene_id, ignore.case = TRUE)) %>%    155|#   group_by(type, gene_id) %>%    156|#   summarise(count = n(), .groups = "drop")    157|    158|# knitr::kable(comparison_table, caption = "Phage Receptor Gene Comparison")    159|`
160\| 161\|## 4. Proxy Strain Candidates 162\| 163\|### 4.1 *Clostridium
perfringens* Proxies 164\| 165\|*To be populated after analysis* 166\|
167\|\| Strain \| Origin \| ANI to China Isolate \| Phage Susceptibility
\| Availability \| Score \|
168\|\|——–\|——–\|———————\|———————-\|————–\|——-\| 169\|\| ATCC 13124 \|
USA \| - \| Known \| ATCC/DSMZ \| - \| 170\|\| DSM 756 \| Germany \| -
\| Moderate \| DSMZ \| - \| 171\|\| TYPE B STRAIN \| - \| - \| - \| -
\| - \| 172\| 173\|### 4.2 *Salmonella enterica* Proxies 174\| 175\|\|
Strain \| Serovar \| ANI to China Isolate \| Phage Susceptibility \|
Availability \| Score \|
176\|\|——–\|———\|———————\|———————-\|————–\|——-\| 177\|\| ATCC 14028 \|
Typhimurium \| - \| High \| ATCC \| - \| 178\|\| DSM 554 \| Enteritidis
\| - \| Moderate \| DSMZ \| - \| 179\| 180\|### 4.3 *Vibrio* spp.
Proxies (Aquaculture) 181\| 182\|\| Strain \| Species \| Origin \| ANI
\| Host Range \| Score \| 183\|\|——–\|———\|——–\|—–\|————\|——-\| 184\|\|
ATCC 17802 \| V. parahaemolyticus \| USA \| - \| Known \| - \| 185\|\|
DSM 10027 \| V. cholerae \| Germany \| - \| Moderate \| - \| 186\|
187\|## 5. Experimental Validation Plan 188\| 189\|### 5.1 Proxy
Validation Workflow 190\| 191\|Based on Notion document Section 7 (The
Bioinformatics-First Strategy): 192\| 193\|**Step 1**: In silico
validation 194\|- ANI \> 95% to China isolates 195\|- Phage receptor
profile match \> 80% 196\|- Metabolic capability similarity 197\|
198\|**Step 2**: In vitro validation (Germany) 199\|- Phage isolation
using proxy strain 200\|- Efficiency of plating (EOP) test 201\|- Lytic
spectrum confirmation 202\| 203\|**Step 3**: Technology transfer to
China 204\|- Send validated phages to China collaborator 205\|- Validate
on local China isolates 206\|- Compare efficacy (German proxy vs. China
local) 207\| 208\|### 5.2 Validation Metrics 209\|
210\|`{r validation-metrics}    211|#| eval: false    212|    213|validation_criteria <- tibble(    214|  metric = c("ANI similarity", "Receptor match", "Phage susceptibility", "Lytic spectrum", "Growth inhibition"),    215|  threshold = c("> 95%", "> 80%", "> 90%", "> 5 strains", "> 2 log reduction"),    216|  method = c("fastANI", "Gene presence/absence", "EOP assay", "Spot test", "In vitro co-culture")    217|)    218|    219|knitr::kable(validation_criteria, caption = "Proxy Strain Validation Criteria")    220|`
221\| 222\|## 6. Commercial Implications 223\| 224\|### 6.1 China Market
Access Strategy 225\| 226\|From Notion document: 227\|- **Competing
companies**: 青岛诺安百特 (Qingdao Nuo’anbai), CJ BIO (Korea) 228\|-
**Strategy**: Use German lab for R&D, China partner for trials +
commercialization 229\|- **Timeline**: Proxy validation (3 months) →
China validation (6 months) → Market entry (12 months) 230\| 231\|###
6.2 IP Considerations 232\| 233\|- Patent strategy must cover **both**
proxy and local strain applications 234\|- Phage cocktails should be
broad enough to cover strain variations 235\|- Probiotic combinations
need to be effective across strain spectra 236\| 237\|## 7. NotebookLM
Validation 238\| 239\|### 7.1 Query for Evidence 240\| 241\|Use
NotebookLM to validate proxy strain strategy: 242\|
243\|`bash    244|nlm notebook query phage-synergy "What proxy strains are used for Clostridium perfringens research in Europe?"    245|`
246\| 247\|### 7.2 Add Results to NotebookLM 248\| 249\|After completing
proxy analysis, add to NotebookLM: 250\|
251\|`bash    252|nlm source add phage-synergy --text "$(cat proxy_strain_report.txt)" --title "Proxy Strain Analysis pr0117"    253|`
254\| 255\|## 8. Session Info 256\|
257\|`{r session-info}    258|sessionInfo()    259|` 260\| 261\|## 9.
Next Steps 262\| 263\|1. **Complete ANI analysis** for top candidate
strains 264\|2. **Validate phage receptor profiles** against literature
265\|3. **Order proxy strains** from DSMZ/ATCC 266\|4. **Design
validation experiments** (Germany lab) 267\|5. **Proceed to Module 06**
(`06-mechanism-exploration.qmd`) 268\| 269\|— 270\|*Generated by qproj
workflow for pr0117-PhageProbioticSynergy* 271\| 272\|
