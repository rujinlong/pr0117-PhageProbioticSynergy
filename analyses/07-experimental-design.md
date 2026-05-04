Your Name

     1|     1|---
     2|     2|title: "Experimental Design"
     3|     3|params:
     4|     4|  name: "07-experimental-design"
     5|     5|---
     6|     6|
     7|     7|# Experimental Design
     8|     8|
     9|     9|## Setup
    10|    10|
    11|    11|```\{r\}
    12|    12|#| label: setup
    13|    13|params <- list(name = "07-experimental-design")
    14|    14|here::i_am(paste0(params$name, ".qmd"), uuid = "g7h8i9j0-k1l2-3456-mnop-q1234567890")
    15|    15|
    16|    16|qproj::proj_create_dir_target(params$name)
    17|    17|path_target <- qproj::path_target(params$name)
    18|    18|path_source <- qproj::path_source(params$name)
    19|    19|
    20|    20|# Read upstream data
    21|    21|path_02 <- qproj::path_source("02-phage-host-prediction")
    22|    22|path_03 <- qproj::path_source("03-probiotic-target-identification")
    23|    23|path_04 <- qproj::path_source("04-synergy-scoring")
    24|    24|path_05 <- qproj::path_source("05-proxy-strain-analysis")
    25|    25|path_06 <- qproj::path_source("06-mechanism-exploration")
    26|    26|```
    27|    27|
    28|    28|## Load Packages
    29|    29|
    30|    30|```\{r\}
    31|    31|#| label: packages
    32|    32|library(tidyverse)
    33|    33|library(here)
    34|    34|library(qproj)
    35|    35|library(ggplot2)
    36|    36|library(agricolae)  # For experimental design
    37|    37|```
    38|    38|
    39|    39|## 1. Experimental Strategy
    40|    40|
    41|    41|### 1.1 From Bioinformatics to Bench
    42|    42|
    43|    43|Based on Notion Research Master Plan Section 11 (Experimental Design Philosophy):
    44|    44|
    45|    45|**Germany (Lab Validation)**:
    46|    46|- Phage isolation & characterization
    47|    47|- Proxy strain validation (Module 05)
    48|    48|- In vitro synergy tests
    49|    49|- Mechanism exploration (Module 06)
    50|    50|
    51|    51|**China (Animal Trials)**:
    52|    52|- Formal animal experiments
    53|    53|- Clinical trials
    54|    54|- Commercialization preparation
    55|    55|
    56|    56|### 1.2 Design Principles
    57|    57|
    58|    58|| Principle | Description |
    59|    59||-----------|-------------|
    60|    60|| **Bioinformatics-First** | All decisions data-driven (Modules 01-04) |
    61|    61|| **Proxy Validation** | Validate on German strains, transfer to China |
    62|    62|| **Modular Design** | Each experiment builds on previous results |
    63|    63|| **Replication** | Biological triplicates, technical duplicates |
    64|    64|| **Controls** | Negative (PBS), Positive (antibiotics), Mono-therapies |
    65|    65|
    66|    66|## 2. In Vitro Experiments (Germany)
    67|    67|
    68|    68|### 2.1 Phage Isolation & Characterization
    69|    69|
    70|    70|**Objective**: Isolate lytic phages against proxy strains
    71|    71|
    72|    72|**Protocol Template**:
    73|    73|
    74|    74|```\{r\}
    75|    75|#| label: phage-isolation-protocol
    76|    76|#| eval: false
    77|    77|
    78|    78|protocol <- c(
    79|    79|  "# Phage Isolation Protocol",
    80|    80|  "",
    81|    81|  "## Sample Collection",
    82|    82|  "- Source: Feces/gut content from healthy/sick animals",
    83|    83|  "- Transport: Anaerobic buffer, 4°C, <2h",
    84|    84|  "- Storage: -80°C with glycerol (for long-term)",
    85|    85|  "",
    86|    86|  "## Enrichment",
    87|    87|  "- Add sample to TSB (37°C, anaerobic, 24h)",
    88|    88|  "- Add CaCl2 to 10mM (enhance phage adsorption)",
    89|    89|  "- Centrifuge 5000g, 10min, 4°C",
    90|    90|  "- Filter supernatant (0.22μm)",
    91|    91|  "",
    92|    92|  "## Phage Assay (Double Agar Layer)",
    93|    93|  "- Host: Overnight culture (OD600 = 0.3)",
    94|    94|  "- Mix: 100μL host + 5mL soft agar + 10-100μL sample",
    95|    95|  "- Pour onto pre-warmed TSA plate",
    96|    96|  "- Incubate 24-48h at 37°C",
    97|    97|  "- Count plaques, calculate titer (PFU/mL)",
    98|    98|  "",
    99|    99|  "## Characterization",

100\| 100\| “- TEM: Negative staining, observe morphology”, 101\| 101\|
“- Host range: Spot test on 10+ strains”, 102\| 102\| “- Stability: pH
3-10, temperature 4-60°C”, 103\| 103\| “- One-step growth curve: Latent
period, burst size” 104\| 104\|) 105\| 105\| 106\| 106\|write_lines(
107\| 107\| protocol, 108\| 108\| file.path(path_target, “protocols”,
“phage_isolation.txt”) 109\| 109\|) 110\| 110\| 111\|
111\|dir.create(file.path(path_target, “protocols”), showWarnings =
FALSE) 112\|
112\|`113|   113|    114|   114|### 2.2 Synergy Testing (In Vitro)    115|   115|    116|   116|**Design**: 2×2 factorial (Phage ± Probiotic)    117|   117|    118|   118|| Treatment | Phage | Probiotic | Expected Outcome |    119|   119||-----------|--------|------------|-------------------|    120|   120|| Control | - | - | Baseline pathogen growth |    121|   121|| Phage only | ✓ | - | Pathogen reduction |    122|   122|| Probiotic only | - | ✓ | Moderate colonization |    123|   123|| **Synergy** | ✓ | ✓ | **Max clearance + colonization** |    124|   124|    125|   125|**Measurement Metrics**:    126|   126|    127|   127|`{r}
128\| 128\|#\| label: synergy-metrics 129\| 129\|#\| eval: false 130\|
130\| 131\| 131\|metrics \<- tibble( 132\| 132\| metric = c(“Pathogen
CFU”, “Probiotic CFU”, “Short-chain fatty acids”, 133\| 133\| “pH”,
“Bile acid profile”, “Inflammatory markers”), 134\| 134\| method =
c(“Plate count”, “Plate count”, “GC-MS”, 135\| 135\| “pH meter”,
“LC-MS”, “ELISA/qPCR”), 136\| 136\| frequency = c(“Daily”, “Daily”,
“Endpoint”, “Daily”, “Endpoint”, “Endpoint”) 137\| 137\|) 138\| 138\|
139\| 139\|knitr::kable(metrics, caption = “In Vitro Synergy Metrics”)
140\|
140\|`141|   141|    142|   142|## 3. Animal Experiments (Germany → China Transfer)    143|   143|    144|   144|### 3.1 Poultry Model (Broiler Chickens)    145|   145|    146|   146|**Design**: Randomized Complete Block Design    147|   147|    148|   148|**Factors**:    149|   149|- Treatment (4 levels: Control, Phage, Probiotic, Synergy)    150|   150|- Time (5 levels: Day 0, 7, 14, 21, 35)    151|   151|- Block (3 levels: Rack position in incubator)    152|   152|    153|   153|**Response Variables**:    154|   154|    155|   155|`{r}
156\| 156\|#\| label: poultry-design 157\| 157\|#\| eval: false 158\|
158\| 159\| 159\|# Generate experimental design 160\|
160\|library(agricolae) 161\| 161\| 162\| 162\|treatments \<-
c(“Control”, “Phage”, “Probiotic”, “Synergy”) 163\| 163\|timepoints \<-
c(0, 7, 14, 21, 35) 164\| 164\|blocks \<- 1:3 165\| 165\| 166\|
166\|design \<- design.rcbd( 167\| 167\| treatments, 168\| 168\| r =
length(blocks) \* length(timepoints), 169\| 169\| serie = 2 \# Randomize
within blocks 170\| 170\|) 171\| 171\| 172\| 172\|# Add metadata 173\|
173\|design$timepoint <- rep(timepoints, each = length(treatments) * length(blocks))
   174|   174|design$block \<- rep(blocks, each = length(treatments),
times = length(timepoints)) 175\| 175\| 176\|
176\|knitr::kable(head(design, 10), caption = “Poultry Experiment Design
(RCBD)”) 177\|
177\|`178|   178|    179|   179|### 3.2 Sample Size Calculation    180|   180|    181|   181|**Power Analysis** (based on expected effect size):    182|   182|    183|   183|`{r}
184\| 184\|#\| label: power-analysis 185\| 185\|#\| eval: false 186\|
186\| 187\| 187\|# Template: Power analysis for ANOVA 188\| 188\|#
Expected effect size: d = 0.8 (large) 189\| 189\|# Alpha = 0.05, Power =
0.80 190\| 190\| 191\| 191\|# Using pwr package (if available) 192\|
192\|if (requireNamespace(“pwr”, quietly = TRUE)) { 193\| 193\|
library(pwr) 194\| 194\| power_result \<- pwr.anova.test( 195\| 195\| k
= 4, \# 4 treatments 196\| 196\| f = 0.4, \# Cohen’s f (medium-large
effect) 197\| 197\| sig.level = 0.05, 198\| 198\| power = 0.80 199\|
199\| ) 200\| 200\| print(power_result) 201\| 201\|} 202\| 202\| 203\|
203\|# Rule of thumb: 8-10 birds per treatment per timepoint 204\|
204\|# Total: 4 treatments × 5 timepoints × 10 birds = 200 birds 205\|
205\|`206|   206|    207|   207|## 4. China Animal Trials    208|   208|    209|   209|### 4.1 Regulatory Compliance    210|   210|    211|   211|From Notion Document Section 6.1 (Geographic & Regulatory Constraints):    212|   212|    213|   213|- **Germany**: Animal experimentation approval is slow → focus on in vitro    214|   214|- **China**: Collaborating institutions can conduct formal trials    215|   215|- **Transfer**: Send validated phages/probiotics to China partner    216|   216|    217|   217|### 4.2 Trial Design (China)    218|   218|    219|   219|**Target**: Broiler chickens, commercial farm setting    220|   220|    221|   221|| Parameter | Specification |    222|   222||-----------|---------------|    223|   223|| **Animals** | 1000 broilers, day-old |    224|   224|| **Duration** | 42 days (standard production cycle) |    225|   225|| **Treatments** | 4 groups × 250 birds |    226|   226|| **Replicates** | 5 pens per treatment (50 birds/pen) |    227|   227|| **Metrics** | FCR, mortality, lesion scores, gut microbiota |    228|   228|    229|   229|**Economic Analysis**:    230|   230|    231|   231|`{r}
232\| 232\|#\| label: economic-model 233\| 233\|#\| eval: false 234\|
234\| 235\| 235\|economics \<- tibble( 236\| 236\| item = c(“Phage
production (per dose)”, “Probiotic (per dose)”, 237\| 237\|
“Administration”, “Labor”, “FCR improvement”, “Mortality reduction”),
238\| 238\| cost = c(0.05, 0.03, 0.01, 0.02, -0.10, -0.50), \# Negative
= savings 239\| 239\| unit = c(“USD”, “USD”, “USD”, “USD”, “FCR points”,
“%”) 240\| 240\|) 241\| 241\| 242\| 242\|total_cost_per_bird \<-
sum(economics$cost[economics$cost \> 0\]) 243\| 243\|total_savings \<-
abs(sum(economics$cost[economics$cost \< 0\])) 244\| 244\| 245\|
245\|ROI \<- (total_savings - total_cost_per_bird) / total_cost_per_bird
\* 100 246\| 246\| 247\| 247\|message(“Cost per bird: \$”,
total_cost_per_bird) 248\| 248\|message(“Savings per bird:
$", total_savings)
   249|   249|message("ROI: ", round(ROI, 1), "%")
   250|   250|```
   251|   251|
   252|   252|## 5. Laboratory Workflow
   253|   253|
   254|   254|### 5.1 Sample Collection & Processing
   255|   255|
   256|   256|**Timeline for Germany Lab**:
   257|   257|
   258|   258|| Week | Activity | Module Reference |
   259|   259||-------|-----------|------------------|
   260|   260|| 1-2 | Phage isolation from samples | - |
   261|   261|| 3-4 | Host range testing (proxy strains) | Module 05 |
   262|   262|| 5-6 | In vitro synergy tests | Module 04 |
   263|   263|| 7-8 | Mechanism validation (receptor, metabolic) | Module 06 |
   264|   264|| 9-10 | Prepare samples for China transfer | - |
   265|   265|
   266|   266|### 5.2 Data Management
   267|   267|
   268|   268|**Folder Structure**:
   269|   269|
   270|   270|```\{r\}
   271|   271|#| label: data-management
   272|   272|#| eval: false
   273|   273|
   274|   274|dirs <- c(
   275|   275|  "raw/phage_isolation",
   276|   276|  "raw/synergy_assays",
   277|   277|  "raw/metagenomics",
   278|   278|  "processed/phage_characterization",
   279|   279|  "processed/synergy_results",
   280|   280|  "processed/microbiome_analysis",
   281|   281|  "metadata/animal_records",
   282|   282|  "metadata/sample_tracking",
   283|   283|  "figures/virology",
   284|   284|  "figures/microbiome",
   285|   285|  "figures/economics"
   286|   286|)
   287|   287|
   288|   288|for (d in dirs) {
   289|   289|  dir.create(file.path(path_target, d), recursive = TRUE, showWarnings = FALSE)
   290|   290|}
   291|   291|
   292|   292|write_lines(
   293|   293|  c("Data Management Plan", "==================", "", paste("Created:", dirs)),
   294|   294|  file.path(path_target, "README_data_management.txt")
   295|   295|)
   296|   296|```
   297|   297|
   298|   298|## 6. Safety & Ethics
   299|   299|
   300|   300|### 6.1 Biosafety Considerations
   301|   301|
   302|   302|| Risk | Mitigation |
   303|   303||------|-------------|
   304|   304|| **Phage resistance evolution** | Use phage cocktails (3+ phages) |
   305|   305|| **Horizontal gene transfer** | Screen for AMR/virulence genes |
   306|   306|| **Probiotic translocation** | Use GRAS strains only |
   307|   307|| **Allergic reactions** | Monitor bird health daily |
   308|   308|
   309|   309|### 6.2 Ethical Approval
   310|   310|
   311|   311|- **Germany**: Application to local animal ethics committee (需时 2-3 月)
   312|   312|- **China**: Collaborating institution handles approval
   313|   313|- **Timeline**: Start paperwork NOW if targeting 6-month milestone
   314|   314|
   315|   315|## 7. NotebookLM Integration
   316|   316|
   317|   317|### 7.1 Query for Experimental Validation
   318|   318|
   319|   319|Use NotebookLM to validate experimental design:
   320|   320|
   321|   321|```bash
   322|   322|nlm notebook query phage-synergy "What are the best practices for phage therapy trials in poultry?"
   323|   323|```
   324|   324|
   325|   325|### 7.2 Add Design to NotebookLM
   326|   326|
   327|   327|After finalizing design, add to NotebookLM:
   328|   328|
   329|   329|```bash
   330|   330|nlm source add phage-synergy --text "$(cat
experimental_design_summary.txt)”  
331\| 331\| –title “Experimental Design pr0117” 332\|
332\|`333|   333|    334|   334|## 8. Session Info    335|   335|    336|   336|`{r}
337\| 337\|#\| label: session-info 338\| 338\|sessionInfo() 339\|
339\|\`\``340|   340|    341|   341|## 9. Next Steps    342|   342|    343|   343|1. **Submit ethics application** (Germany) — critical path item    344|   344|2. **Order proxy strains** (DSMZ/ATCC) — Module 05 results    345|   345|3. **Begin phage isolation** — start with available samples    346|   346|4. **Prepare China transfer documents** — shipping, import permits    347|   347|5. **Proceed to Module 08** (`08-manuscript-draft.qmd\`)
348\| 348\| 349\| 349\|— 350\| 350\|*Generated by qproj workflow for
pr0117-PhageProbioticSynergy* 351\| 351\|
