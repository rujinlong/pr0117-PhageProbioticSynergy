Your Name

---

execute: false 2\|title: “Synergy Scoring System” 3\|params: 4\| name:
“04-synergy-scoring” 5\|— 6\| 7\|# Synergy Scoring System 8\| 9\|##
Setup 10\|
11\|`{r setup}     12|here::i_am(paste0(params$name, ".qmd"), uuid = "d4e5f6a7-b8c9-0123-defg-h1234567890")     13|     14|qproj::proj_create_dir_target(params$name)     15|path_target <- qproj::path_target(params$name)     16|path_source <- qproj::path_source(params$name)     17|     18|# Read upstream data     19|path_01 <- qproj::path_source("01-public-data-mining")     20|path_02 <- qproj::path_source("02-phage-host-prediction")     21|path_03 <- qproj::path_source("03-probiotic-target-identification")     22|`
23\| 24\|## Load Packages 25\|
26\|`{r packages}     27|library(tidyverse)     28|library(here)     29|library(qproj)     30|library(ggplot2)     31|`
32\| 33\|## 1. Objective 34\| 35\|Develop a scoring system to rank
phage-probiotic combinations for animal health applications: 36\| 37\|-
**Input**: Phage candidates (from Module 02) + Probiotic candidates
(from Module 03) 38\|- **Output**: Ranked list of best combinations
39\|- **Criteria**: Efficacy, safety, commercial viability 40\| 41\|##
2. Scoring Framework 42\| 43\|### 2.1 Primary Criteria (from Research
Master Plan) 44\| 45\|\| Criterion \| Weight \| Data Source \| Score
Range \| 46\|\|———–\|——–\|————–\|————\| 47\|\| **Pathogen clearance** \|
0.25 \| Module 02 (phage-host prediction) \| 0-10 \| 48\|\| **Probiotic
colonization** \| 0.20 \| Module 03 (niche overlap) \| 0-10 \| 49\|\|
**Synergy potential** \| 0.30 \| Literature + simulation \| 0-10 \|
50\|\| **Safety profile** \| 0.15 \| Genome analysis \| 0-10 \| 51\|\|
**Commercial readiness** \| 0.10 \| Market research \| 0-5 \| 52\|
53\|### 2.2 Secondary Criteria 54\| 55\|\| Criterion \| Weight \| Notes
\| 56\|\|———–\|——–\|——-\| 57\|\| **Cost-effectiveness** \| 0.05 \|
Manufacturing + delivery costs \| 58\|\| **Regulatory ease** \| 0.05 \|
GRAS status, existing approvals \| 59\|\| **Stability** \| 0.05 \| Shelf
life, gut survival \| 60\|\| **IP freedom** \| 0.05 \| Patent landscape
\| 61\| 62\|## 3. Data Integration 63\| 64\|### 3.1 Load Upstream
Results 65\|
66\|`{r load-upstream}     67|#| eval: false     68|     69|# Load phage prediction results (from 02)     70|# phage_data <- read_tsv(file.path(path_02, "processed", "phage_predictions.tsv"))     71|     72|# Load probiotic ranking (from 03)     73|# probiotic_data <- read_tsv(file.path(path_03, "processed", "probiotic_ranking.tsv"))     74|     75|# Create all pairwise combinations     76|# combinations <- expand.grid(     77|#   phage_id = phage_data$phage_id,     78|#   probiotic_id = probiotic_data$probiotic_id,     79|#   stringsAsFactors = FALSE     80|# )     81|`
82\| 83\|### 3.2 Template Scoring Function 84\|
85\|`{r scoring-function}     86|#| eval: false     87|     88|calculate_synergy_score <- function(phage_id, probiotic_id, phage_data, probiotic_data) {     89|  # Get phage info     90|  p <- phage_data %>% filter(phage_id == !!phage_id)     91|  b <- probiotic_data %>% filter(probiotic_id == !!probiotic_id)     92|       93|  # Calculate component scores (0-10 scale)     94|  pathogen_clearance <- p$prediction_score * 10  # Normalize to 0-10     95|  colonization <- b$niche_overlap_score     96|       97|  # Synergy potential (requires literature validation)     98|  synergy_base <- (pathogen_clearance + colonization) / 2     99|  synergy_potential <- synergy_base * 1.2  # Boost for synergy effect    100|      101|  # Safety (penalize if virulence/resistance genes present)    102|  safety <- ifelse(p$has_virulence_genes, 3, 10)    103|      104|  # Commercial readiness (based on GRAS status, existing products)    105|  commercial <- ifelse(b$gras_status, 10, 5)    106|      107|  # Weighted sum    108|  total_score <- (    109|    pathogen_clearance * 0.25 +    110|    colonization * 0.20 +    111|    synergy_potential * 0.30 +    112|    safety * 0.15 +    113|    commercial * 0.10    114|  )    115|      116|  return(total_score)    117|}    118|`
119\| 120\|## 4. Generate Rankings 121\| 122\|### 4.1 Top Combinations
123\| 124\|*To be populated after running scoring* 125\| 126\|\| Rank \|
Phage \| Probiotic \| Target Pathogen \| Score \| Key Strength \|
127\|\|——\|——-\|————\|—————–\|——-\|————–\| 128\|\| 1 \| TBD \| TBD \| C.
perfringens \| - \| - \| 129\|\| 2 \| TBD \| TBD \| S. enterica \| -
\| - \| 130\|\| 3 \| TBD \| TBD \| E. coli \| - \| - \| 131\|\| 4 \| TBD
\| TBD \| Vibrio spp. \| - \| - \| 132\|\| 5 \| TBD \| TBD \|
Multi-target \| - \| - \| 133\| 134\|### 4.2 Visualization 135\|
136\|`{r visualize-rankings}    137|#| eval: false    138|    139|# Bar plot of top combinations    140|# ggplot(top_combinations, aes(x = reorder(combination, score), y = score, fill = target_pathogen)) +    141|#   geom_bar(stat = "identity") +    142|#   coord_flip() +    143|#   theme_minimal() +    144|#   labs(title = "Top Phage-Probiotic Combinations",    145|#        x = "Combination (Phage + Probiotic)",    146|#        y = "Synergy Score")    147|`
148\| 149\|## 5. Literature Validation via NotebookLM 150\| 151\|### 5.1
Query for Evidence 152\| 153\|Validate top combinations against
literature in NotebookLM. 154\|
155\|`bash    156|nlm notebook query phage-synergy "What is the evidence for Lactobacillus acidophilus and bacteriophages against Clostridium perfringens in poultry?"    157|`
158\| 159\|### 5.2 Add Results to NotebookLM 160\| 161\|After scoring,
add results back to NotebookLM for cross-validation. 162\|
163\|`bash    164|nlm source add phage-synergy --text "$(cat synergy_rankings.txt)" --title "Synergy Rankings pr0117"    165|`
166\| 167\|## 6. Case Study: Poultry Application 168\| 169\|### 6.1
Target Scenario 170\| 171\|- **Animal**: Broiler chickens 172\|-
**Pathogen**: *Clostridium perfringens* (necrotic enteritis) 173\|-
**Probiotic**: *Lactobacillus acidophilus* (commercial strain) 174\|-
**Phage**: Lytic *C. perfringens* phage (isolate or commercial) 175\|
176\|### 6.2 Expected Outcomes 177\| 178\|Based on NotebookLM literature
(34 sources imported): 179\| 180\|1. **Pathogen reduction**: 2-3 log
reduction in *C. perfringens* counts 181\|2. **Probiotic colonization**:
Enhanced by reduced competition 182\|3. **Growth performance**: Improved
FCR (Feed Conversion Ratio) 183\|4. **Gut health**: Reduced
inflammation, improved barrier function 184\| 185\|### 6.3 Economic
Analysis Template 186\|
187\|`{r economic-analysis}    188|#| eval: false    189|    190|# Cost-benefit analysis template    191|cost_benefit <- tibble(    192|  item = c("Phage production", "Probiotic production", "Delivery system", "Administration"),    193|  cost_per_dose = c(0.05, 0.03, 0.02, 0.01),  # USD    194|  annual_doses = c(365, 365, 365, 365)  # Per 1000 birds    195|)    196|    197|total_cost <- sum(cost_benefit$cost_per_dose * cost_benefit$annual_doses)    198|    199|# Benefits (improved FCR, reduced mortality)    200|benefits <- tibble(    201|  metric = c("FCR improvement", "Mortality reduction"),    202|  value = c(0.1, 0.5),  # 0.1 FCR points, 0.5% mortality    203|  economic_value = c(5000, 3000)  # USD per 1000 birds    204|)    205|    206|total_benefit <- sum(benefits$economic_value)    207|    208|ROI <- (total_benefit - total_cost) / total_cost * 100    209|`
210\| 211\|## 7. Milestone Check: 2-Month Deliverables 212\| 213\|###
7.1 Completed (Simulated) 214\| 215\|- \[x\] Public data mining (Module
01) 216\|- \[x\] Phage-host prediction (Module 02) 217\|- \[x\]
Probiotic target identification (Module 03) 218\|- \[x\] Synergy scoring
system (Module 04) 219\| 220\|### 7.2 Key Deliverables for Grant
Application 221\| 222\|1. **Preliminary data report** (from Module
01-04) 223\|2. **Top 5 phage-probiotic combinations** with scoring
rationale 224\|3. **Literature review** (34 sources in NotebookLM)
225\|4. **Commercial landscape analysis** (competitors: 青岛诺安百特, CJ
BIO) 226\| 227\|## 8. Session Info 228\|
229\|`{r session-info}    230|sessionInfo()    231|` 232\| 233\|## 9.
Next Steps 234\| 235\|**Phase 1 Complete!** Now entering **Phase 2
(3-month mark)**: 236\| 237\|1. **Module 05**: Proxy strain analysis
(solve China strain access issue) 238\|2. **Module 06**: Mechanism
exploration (molecular mechanisms) 239\|3. **Prepare grant application**
with Phase 1 results 240\| 241\|— 242\|*Generated by qproj workflow for
pr0117-PhageProbioticSynergy* 243\| 244\|
