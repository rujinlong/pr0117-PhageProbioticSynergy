# RESEARCH_TASKS_v2.md: Phage-Probiotic Synergy in Broiler Chickens
# (Revised per Codex Scientific Review)

**Project Code**: pr0117-PhageProbioticSynergy 
**PI**: Dr. RU Jinlong  
**Revision Date**: 2026-05-05  
**Based on**: Codex Review (Score: 4/10) + Expert Revisions  
**Model**: claude-sonnet-4-6 (Anthropic) via Hermes Agent  
**Skill**: goal-forge (Scientific Research Edition, Tighten Mode)

---

## 1. Project Overview (Scope Contraction)

### 1.1 Title
**Mechanistic dissection of phage-probiotic synergy in broiler chickens: cross-feeding or ecological release?**

### 1.2 Core Concept (Revised)
This project investigates the **interaction effects** of combining bacteriophages (phages) with probiotics (*Lactobacillus rhamnosus* GG) in **broiler chickens** challenged with *Salmonella enterica* Typhimurium.

**Candidate mechanisms** (equally weighted, no prior ranking):
1. **Nutritional cross-feeding**: Phage lysis releases intracellular nutrients utilized by probiotics
2. **Ecological niche release**: Phage removes competitor, freeing resources for probiotics
3. **pH-mediated effects**: Probiotic acid production stabilizes phage/bacteria; phage lysis alters pH
4. **Immune-mediated synergy**: Phage lysis products stimulate innate immunity, enhancing probiotic colonization
5. **Media/artifact effects**: Components of phage lysate (not lysis per se) stimulate growth

### 1.3 Target Species (Single Host)
- **Model**: **Broiler chickens** (*Gallus gallus domesticus*)
- **Rationale**: Standardized gut physiology (pH 6.0-6.5), fast throughput, established *Salmonella* challenge model, direct relevance to poultry industry

### 1.4 Target Pathogen (Single Strain)
- **Pathogen**: *Salmonella enterica* serovar Typhimurium ATCC 14028
- **Accession**: NC_003197
- **Challenge dose**: 10⁶ CFU (established LD₅₀ for 14-day-old broilers)

### 1.5 Target Combination (Single Pair)
| Component | Strain | Rationale |
|-----------|--------|----------|
| **Phage** | **T4-like myovirus** (broad-host-range, ATCC BAA-1025-B1) | High lytic efficiency, stable at pH 6.0-7.0, well-characterized receptor (*ompC/fhuA*) |
| **Probiotic** | ***Lactobacillus rhamnosus* GG** (ATCC 53103) | GRAS status, acid-tolerant (pH 4.0+), clinical evidence in poultry, sequenced genome |

**Alternative probiotic for follow-up**: *Bifidobacterium animalis* subsp. *lactis* BB-12 (if LGG fails)

---

## 2. Core Scientific Hypotheses (Revised - No Prior Ranking)

### H1: Nutritional Cross-Feeding (Candidate Mechanism 1)
**Statement**: Phage lysis of *Salmonella* releases intracellular nutrients (amino acids, peptides, nucleotide precursors) that are preferentially utilized by co-administered *L. rhamnosus* GG, enhancing its competitive fitness.

**Testable Prediction**:  
Probiotic biomass increase in the presence of **phage-lysed** pathogen lysate > **heat-killed** pathogen (80°C, 30 min) control by ≥ 2-fold (measured by CFU, OD600, flow cytometry).

**Falsification Criterion**:  
If no significant difference is observed between lysed and heat-killed controls, H1 is rejected **as primary mechanism**.

**Alternative explanation tested**: Media components from phage propagation (if using broth-grown phage) vs. true lysis products.

---

### H2: Ecological Niche Release (Candidate Mechanism 2)
**Statement**: Phage-mediated removal of *Salmonella* reduces competitive exclusion, allowing *L. rhamnosus* GG to colonize vacant niches (mucus adhesion sites, nutrient patches).

**Testable Prediction**:  
Probiotic adherence to **chicken ileal mucus** (ex vivo) is 2× higher in the presence of phage-lysed *Salmonella* vs. phage-only control (without lysis, using UV-inactivated phage).

**Falsification Criterion**:  
If mucus adherence does not differ between treatments, H2 is rejected **as primary mechanism**.

---

### H3: Measurable Therapeutic Endpoints (Revised Standards)
**Statement**: Phage-probiotic co-administration in broilers achieves:
- ≥ 1.5 log₁₀ CFU/g reduction in cecal *Salmonella* load (vs. phage-only, p<0.01, mixed model)
- ≥ 2× increase in cecal *L. rhamnosus* GG recovery (CFU/g, p<0.001)
- ≥ 10% improvement in feed conversion ratio (FCR, pen-level, p<0.05)
- ≥ 20% reduction in *Salmonella* fecal shedding (qPCR, p<0.01)

**Falsification Criterion**:  
If **any two** endpoints fail to meet thresholds in ≥ 2 independent replicates (separate cohorts), H3 requires revision.

**Note**: Economic ROI analysis is **preliminary scenario modeling** only, not empirical claim.

---

## 3. Experimental Design & Task Decomposition (Revised)

### Task 1: In Vitro Ternary System - Baseline Calibration

**Scientific Question**: What are the baseline growth kinetics of *Salmonella* + *L. rhamnosus* GG in monoculture and co-culture, and how do different media affect these dynamics?

**Hypothesis**:  
Different media (BHI vs. MRS vs. 1:1 mixture) alter the relative fitness of pathogen vs. probiotic, which must be accounted for before testing synergy.

**Methodology**:
- **Baseline growth curves**: 
  - *Salmonella* alone (BHI, 37°C)
  - *L. rhamnosus* GG alone (MRS, 37°C)
  - Co-culture (1:1 BHI:MRS, 37°C)
  - Time points: 0, 2, 4, 6, 8, 12, 24h
  - Readouts: OD600, CFU (selective agar), pH
- **Media calibration**: Test 5 media ratios (100:0, 75:25, 50:50, 25:75, 0:100 BHI:MRS) for co-culture growth

**Controls** (Enhanced per Codex critique):
- D1: Medium only (blank)
- D2: *Salmonella* only (BHI)
- D3: *L. rhamnosus* GG only (MRS)
- D4: Co-culture, no phage (1:1 BHI:MRS)
- D5: **Washed *Salmonella* lysate** (phage-lysed, dialyzed to remove small molecules < 3 kDa) + probiotic
- D6: **Non-lysed *Salmonella* supernatant** (adjusted to same OD) + probiotic
- D7: **Phage propagation medium** (no bacteria) + probiotic (controls for media carryover)

**Deliverable**:  
Figure 1: Baseline growth curves across media conditions  
Table 1: Relative fitness indices (pathogen vs. probiotic) in co-culture  
Statistic: Nonlinear regression (logistic growth model), AUC comparison (CI 95%)

**Validation**:
- Repeat with **different *Salmonella* inoculum densities** (10², 10⁴, 10⁶ CFU/mL)
- Use **alternative probiotic strain** (*B. animalis* BB-12) to test generality within poultry model

**Publication Role**: Methods section, Supplementary Figure 1  
**Dependencies**: None  
**Estimated Effort**: 14 days  
**Tooling**:  
- `terminal`: R (tidyverse, ggplot2, grofit for growth curves)
- `scripts/task1_baseline_calibration.R`

---

### Task 2: Transwell System + Isotope Tracing (Mechanism Dissection)

**Scientific Question**: Is synergy driven by **soluble factors** from phage lysis, **direct contact**, or **both**?

**Hypothesis**:  
Soluble factors (molecules < 0.4 μm) from phage-lysed *Salmonella* account for ≥ 40% of probiotic growth enhancement (not the 60% claimed in v1 — per Codex critique, this was arbitrary).

**Methodology**:
- **System**: Costar Transwell plates (0.4 μm pore, polyester)
  - **Upper**: *Salmonella* + phage (lysis occurs)
  - **Lower**: *L. rhamnosus* GG (no direct contact)
- **Conditions** (n=6 replicates per condition):
  - A: Upper: *Salmonella* alone → Lower: Probiotic (negative control)
  - B: Upper: Phage + *Salmonella* (lysis) → Lower: Probiotic (test)
  - C: Upper: UV-inactivated phage + *Salmonella* → Lower: Probiotic (lysis control)
  - D: Upper: **Dialyzed lysate** (< 3 kDa removed) → Lower: Probiotic (small molecule test)
  - E: Upper: **Retentate only** (> 3 kDa) → Lower: Probiotic (macromolecule test)
  - F: Upper: **Chemically killed *Salmonella*** (sonication) → Lower: Probiotic (non-lytic nutrient control)
- **13C metabolic flux**: Label *Salmonella* with 13C-glucose → track incorporation into probiotic metabolites via LC-MS/MS

**Readouts**:
1. Probiotic growth (OD600, CFU, flow cytometry)
2. **13C enrichment** in lactate, acetate, amino acids (LC-MS/MS)
3. **Targeted metabolomics**: Screen for amino acids, peptides, nucleotides in lysate

**Deliverable**:  
Figure 2: Transwell results + 13C flux data  
Table 2: Metabolite enrichment (fold-change vs. control)  
Statistic: Linear mixed-effects model (growth ~ treatment + time | replicate)

**Validation**:
- **Size-exclusion fractionation**: Test 100 kDa, 10 kDa, 3 kDa fractions for bioactivity
- **Rescue experiment**: Supplement probiotic + killed *Salmonella* with **defined metabolites** (alanine, glutamate, nucleotides) to test sufficiency

**Publication Role**: Results (mechanism), Discussion  
**Dependencies**: Task 1 (baseline growth)  
**Estimated Effort**: 28 days (includes LC-MS/MS time)  
**Tooling**:  
- `terminal`: XCMS (LC-MS processing), MZmine2, IsoCorrectoR
- Collaboration with metabolomics core facility
- `scripts/task2_transwell_metabolomics.R`

---

### Task 3: Delivery-Environment Stability (Revised from pH/Temp Matrix)

**Scientific Question**: How do **chicken-specific GIT conditions** (pH, bile salts, mucin, anaerobic atmosphere) affect phage/probiotic viability during gut transit?

**Hypothesis**:  
Phage T4-like and *L. rhamnosus* GG maintain ≥ 50% viability after 4h exposure to **simulated chicken GIT fluid** (pH 6.0, 0.3% bile salts, 1% mucin, anaerobic).

**Methodology**:
- **Simulated GIT fluid preparation** (per chicken physiology):
  - Crop: pH 4.5, no bile
  - Proventriculus: pH 3.5, pepsin
  - Gizzard: pH 2.5, mechanical grinding
  - Small intestine: pH 6.0, 0.3% bile salts, pancreatin
  - Cecum: pH 6.5, 1% mucin, anaerobic, 10⁸ CFU/mL commensals
- **Stability assay**: 
  - Phage titer (PFU/mL) after 0, 1, 2, 4, 8h exposure
  - Probiotic CFU after same time points
- **Anaerobic chamber**: Test under O₂ < 0.1% (cecal conditions)

**Deliverable**:  
Figure 3: Survival curves across GIT compartments  
Table 3: Half-life (t½) in each compartment  
Statistic: Survival analysis (Cox proportional hazards, HR comparing conditions)

**Validation**:
- **Ex vivo cecal content assay**: Incubate phage/probiotic in fresh chicken cecal content (37°C, anaerobic) → measure viability at 0, 2, 4, 8h
- **Tail fiber integrity**: SDS-PAGE + Western blot (anti-T4 tail fiber) after GIT exposure

**Publication Role**: Results, Methods  
**Dependencies**: Task 1  
**Estimated Effort**: 21 days  
**Tooling**:  
- `terminal`: R (survival package, ggplot2)
- `scripts/task3_git_stability.R`

---

### Task 4: Pilot In Vivo Study (Broilers, n=12/group, 21-day trial)

**Scientific Question**: Does phage-probiotic co-administration improve *Salmonella* clearance, probiotic colonization, and production performance in broilers?

**Experimental Design (Revised per Codex Critique)**:

**Animals**: 48 broilers (day-old Cobb 500), randomized to 4 groups (n=12 birds/group):
- G1: Control (PBS, oral gavage)
- G2: Phage only (10⁸ PFU/day, oral)
- G3: Probiotic only (10⁹ CFU/day, oral)
- G4: Combination (phage 10⁸ PFU + probiotic 10⁹ CFU/day)

**Randomization & Blinding**:
- **Randomization**: Stratified by weight (± 5g) at day 0
- **Blinding**: Personnel collecting samples and reading outcomes blinded to treatment
- **Housing**: 12 pens (4 groups × 3 replicates/pen, 4 birds/pen) — **pen is experimental unit** (not individual bird)

**Challenge**: *Salmonella* Typhimurium (10⁶ CFU, oral) at day 7

**Sampling Schedule**:
| Day | Sample | Readout |
|------|--------|--------|
| 0, 7, 14, 21 | Fecal swab | *Salmonella* load (qPCR), *L. rhamnosus* GG (species-specific qPCR) |
| 7, 14, 21 | Cecal content (3 birds/pen, terminal) | CFU (selective agar), pH, SCFA (LC-MS) |
| 21 | Terminal bleed (all birds) | sIgA (ELISA), cytokines (IL-10, TNF-α, IL-1β) |
| 0, 7, 14, 21 | Body weight (pen-level) | Weight gain, FCR (pen feed intake) |

**Primary Endpoints** (Prospective power calculated):
1. **Cecal *Salmonella* load** (log₁₀ CFU/g, primary efficacy)
2. **Cecal *L. rhamnosus* GG recovery** (log₁₀ CFU/g, primary colonization)
3. **FCR** (pen-level, secondary production)
4. **sIgA response** (ELISA, secondary immunity)

**Sample Size Justification** (Pre-Study Power):
- **Primary endpoint**: Δ = 1.5 log₁₀, σ = 0.8, power = 0.80, α = 0.05 (two-sided)
- **Calculated n**: 8 pens/group → **12 pens/group** (accounting for 30% dropout/technical failure)
- **Pen is unit**: FCR, mortality aggregated at pen level

**Deliverable**:  
Figure 4: *Salmonella* clearance kinetics (longitudinal, mixed model)  
Figure 5: Probiotic colonization + SCFA production  
Table 4: Production performance (weight, FCR, mortality)  
Statistic: Linear mixed model (outcome ~ treatment + time | pen), Cox proportional hazards (mortality)

**Validation**:
- **Independent cohort**: Repeat in second facility (n=12/group, same design)
- **Correlation analysis**: *Salmonella* load vs. *L. rhamnosus* GG (Pearson r, with CI)
- **Confounder adjustment**: Include baseline weight, litter type as covariates

**Publication Role**: Core Results, Tables/Figures for mBio/AEM  
**Dependencies**: Task 1-3 (mechanism + stability)  
**Estimated Effort**: 45 days (including animal trial + turnaround)  
**Tooling**:  
- `terminal`: R (lme4, survival, MASS packages)
- `scripts/task4_in_vivo_analysis.R`

---

### Task 5: Targeted Microbiome & Metabolome (Exploratory, Not Primary)

**Scientific Question (Exploratory)**: How does treatment reshape cecal microbiota and metabolome?

**Hypothesis (Exploratory)**:  
Combination treatment enriches **butyrate-producing taxa** (e.g., *Faecalibacterium*, *Roseburia*) and elevates SCFA (butyrate ≥ +30% vs. control).

**Methodology**:
- **Samples**: Cecal content from Task 4 (n=3 birds/pen × 12 pens = 36 samples)
- **16S rRNA sequencing**: V3-V4 region, Illumina MiSeq (paired-end 2×300)
- **LC-MS metabolomics**: SCFA (acetate, propionate, butyrate), bile acids
- **Analysis**: 
  - Alpha diversity (Shannon, Simpson) — **exploratory only**
  - Differential abundance (DESeq2) — **exploratory only**
  - MaAsLin2 (multivariate, adjust for weight, litter)

**Deliverable**:  
Figure 6: Microbiome composition (PCA, stacked bar) — **Supplementary**  
Table 5: Differential abundant taxa/metabolites — **Supplementary**  
Statistic: PERMANOVA (vegan), DESeq2 (FDR<0.1 for exploratory), MaAsLin2

**Important**: Microbiome data are **exploratory, not primary evidence** for mechanism. Presented in Supplementary Materials only.

**Validation**:
- **qPCR validation**: Top 3 differentially abundant taxa (species-specific primers)
- **Correlation**: SCFA vs. taxa abundance (SparCC, with confidence intervals)

**Publication Role**: Supplementary Materials (not core Results)  
**Dependencies**: Task 4  
**Estimated Effort**: 30 days  
**Tooling**:  
- `terminal`: QIIME2, R (phyloseq, vegan, MaAsLin2)
- `scripts/task5_microbiome_exploratory.R`

---

### Task 6: Preliminary Techno-Economic Modeling (Scenario-Based, Not Empirical)

**Scientific Question**: What is the **theoretical ROI** of phage-probiotic adoption in poultry under different cost scenarios?

**Approach (Revised per Codex Critique)**:  
** NOT an empirical ROI claim**. Instead: **Scenario-based Monte Carlo model** using:
- **Input parameters** (triangular distributions, based on literature + Task 4 data):
  - Treatment cost: $0.05-0.15 per bird (phage production, probiotic fermentation, formulation)
  - Performance gain: 0-15% (FCR improvement, from Task 4)
  - *Salmonella* reduction: 0-2 log₁₀ (from Task 4)
  - Antibiotic cost savings: $0.02-0.10 per bird (reduced treatments)
- **Monte Carlo**: 10,000 iterations, output = ROI distribution

**Deliverable**:  
Figure 7: ROI probability density (Monte Carlo)  
Table 6: Sensitivity analysis (tornado plot, top 5 cost drivers)  
Statistic: Monte Carlo (NumPy/SciPy), Net Present Value (NPV) calculation

**Important**: Explicitly state **"Preliminary scenario model, not empirical farm trial data"** in all outputs.

**Validation**:
- **Sensitivity analysis**: Vary performance gain ± 30%, treatment cost ± 50%
- **Comparison**: Benchmark against published poultry phage therapy economics (literature review)

**Publication Role**: Discussion (translational potential), not Results  
**Dependencies**: Task 4 (FCR, pathogen reduction data)  
**Estimated Effort**: 14 days  
**Tooling**:  
- `terminal`: Python (NumPy, SciPy, pandas, matplotlib)
- `scripts/task6_economic_scenario.py`

---

### Task 7: Statistical Power Re-Estimation (Prospective)

**Scientific Question**: Were the sample sizes in Task 4 sufficient to detect hypothesized effects?

**Methodology**:
- **Post-hoc power analysis**: Use observed effect sizes from Task 4
- **Prospective power tables**: For future replication studies (different pen numbers, effect sizes)
- **Multiple testing**: Account for 4 primary endpoints (Bonferroni-corrected α = 0.0125)

**Deliverable**:  
Table 7: Observed effect sizes, power, 95% CI  
Supplementary Table: Multiple testing correction results  
Statistic: Power analysis (pwr package), FDR correction (Benjamini-Hochberg)

**Publication Role**: Methods (statistical rigor), Supplementary Materials  
**Dependencies**: Task 4  
**Estimated Effort**: 7 days  
**Tooling**:  
- `terminal`: R (pwr, stats packages)
- `scripts/task7_power_analysis.R`

---

### Task 8: Paper Outlining (Realistic Targets)

**Target Journals (Revised per Codex Critique)**:

| Journal | Impact Factor | Rationale for Fit | Realistic Probability |
|---------|--------------|-------------------|----------------------|
| ***Applied and Environmental Microbiology (AEM)*** | 4.5 | Applied translational focus; poultry trial + mechanism fit | **High (primary target)** |
| ***mBio*** | 7.8 | Mechanism-focused (Transwell + 13C flux) | **Medium (if mechanism is strong)** |
| ***Frontiers in Microbiology*** | 5.2 | Open access; methods paper potential | **High (fallback)** |

**Strategy**: Submit to *AEM* first → if rejected, *Frontiers in Microbiology* (Methods section: "Phage-probiotic synergy screening platform").

**Paper Outline** (Single Manuscript, Not Series):
- **Title**: "Phage-probiotic synergy in broiler chickens: mechanisms, efficacy, and translational potential"
- **Abstract**: 250 words (background, methods, results, conclusions)
- **Introduction**: (1.5 pages) *Salmonella* in poultry, phage therapy limitations, probiotic synergy rationale
- **Results**: 
  - Task 1-3: In vitro mechanism (2-3 pages)
  - Task 4: In vivo efficacy (2-3 pages)
  - Task 5: Microbiome/metabolome (1 page, supplementary-heavy)
  - Task 6: Economic scenario (0.5 page, Discussion)
- **Discussion**: (1.5 pages) Mechanism synthesis, limitations, translational outlook
- **Methods**: (2 pages) Detailed protocols, statistics

**Deliverable**:  
- Full paper outline with section word counts
- Draft manuscript (Quarto qmd) with placeholder figures/tables
- Cover letter highlighting novelty: **first mechanistic dissection of phage-probiotic synergy in a single, well-controlled poultry model**

**Publication Role**: Final output  
**Dependencies**: Task 1-7 (all)  
**Estimated Effort**: 30 days  
**Tooling**:  
- `manuscript`: Quarto (qmd) for drafting
- `literature-search` skill for citation mining
- `notion` skill for collaborative writing

---

## 4. Non-Goals (Explicit Exclusions, Expanded)

1. **No cross-species claims**: This study is **exclusively broiler chickens**. No swine, ruminants, or aquaculture (deleted per Codex critique).
2. **No "general ecological principle" claims**: We test mechanisms in one host; generality is for future studies.
3. **No human clinical trials**: Animal models only.
4. **No phage therapy alone**: Monotherapy is control only, not primary investigation.
5. **No genomic evolution of phages**: We use characterized T4-like phage; no long-term passage.
6. **No metagenomic assembly of novel phages**: We use existing, sequenced phages.
7. **No gut-brain axis**: No behavioral/neurological outcomes.
8. **No environmental fate**: No tracking beyond animal gut.
9. **No empirical ROI claims**: Economics are scenario modeling only (Task 6).
10. **No "high-impact journal" overreach**: Target *AEM*/*mBio*, not *Nature Microbiology* (realistic per Codex).

---

## 5. Confounding Factors & Mitigation Strategies (Refined)

| Confounder | Impact | Mitigation Strategy |
|------------|--------|---------------------|
| **Batch effects** (sequencing, LC-MS) | Technical noise | Randomize samples across plates; include batch as covariate |
| **Pen effects** (litter, microclimate) | Pseudoreplication | **Pen is experimental unit**; birds nested within pen |
| **Dietary differences** | Gut microbiome varies | Standardize diet across all pens; record composition |
| **Antibiotic residuals** in feed/water | Interfere with viability | Test feed/water (LC-MS); use antibiotic-free diets |
| **Phage host range variation** | May not infect all isolates | Test against 10 local *Salmonella* isolates before trial |
| **Probiotic colonization resistance** | Competitor microbes | Measure baseline cecal microbiota (16S, n=6 birds/pre-trial) |
| **GIT pH/transit time variability** | Affects phage/probiotic survival | Measure cecal pH at each sampling; record feed intake (transit proxy) |
| **Evolution of phage resistance** | Pathogen may evolve | Sequence *ompC/ompF* genes at day 0, 7, 14, 21; track mutation frequency |

---

## 6. Negative Controls (Expanded, Task-Specific)

### In Vitro (Tasks 1-3):
1. **Blank control**: Medium only
2. **Pathogen-only control**: *Salmonella* + vehicle (PBS)
3. **Phage-only control**: Phage + *Salmonella* (no probiotic)
4. **Probiotic-only control**: Probiotic + *Salmonella* (no phage)
5. **Heat-inactivated phage** (80°C, 30 min) + probiotic + *Salmonella*
6. **UV-inactivated phage** (254 nm, 30 min) + probiotic + *Salmonella*
7. **Washed lysate control**: Phage-lysed *Salmonella*, washed 3× PBS, then add probiotic
8. **Non-lysed supernatant**: Adjusted to same OD, no lysis
9. **Phage propagation medium**: No bacteria, controls for media carryover
10. **Antibiotic positive control**: Enrofloxacin (validates model sensitivity)

### In Vivo (Task 4):
11. **Vehicle control**: PBS oral gavage (G1)
12. **Sham challenge**: No *Salmonella* challenge (tests background)
13. **Probiotic ∆bac mutant**: *L. rhamnosus* GG Δ*lanM* (bacteriocin-deficient) — tests bacteriocin contribution
14. **Phage tail fiber-only**: Purified T4 tail fibers (no DNA) — tests adsorption-only effects
15. **Diet-only control**: No treatment, standard diet (tests baseline performance)

---

## 7. Publication Criteria (Realistic, Revised)

### 7.1 Primary Paper (Target: *Applied and Environmental Microbiology*)

**Measurable Deliverables** (All must be met for "success"):
1. **Primary efficacy**: Cecal *Salmonella* reduction ≥ 1.5 log₁₀ vs. phage-only (mixed model, p<0.01)
2. **Primary colonization**: *L. rhamnosus* GG recovery ≥ 2× vs. probiotic-only (CFU/g, p<0.001)
3. **Mechanism evidence**: Transwell + 13C flux shows ≥ 1 nutrient (e.g., alanine) accounting for ≥ 30% synergy (LC-MS, p<0.01)
4. **Production performance**: FCR improvement ≥ 8% (pen-level, p<0.05)
5. **Reproducibility**: Key findings replicated in **independent cohort** (different facility, n=12/group)
6. **Statistical rigor**: All primary endpoints meet prospective power (≥ 0.80)

### 7.2 Exploratory (Not Required for Publication):
- Microbiome: Alpha diversity, differential abundance (supplementary only)
- Immune: sIgA, cytokines (exploratory, not primary mechanism)
- Economics: Scenario modeling (Discussion only)

### 7.3 Validation Criteria:
1. **No p-hacking**: All comparisons pre-registered in OSF before trial
2. **Data availability**: Raw sequencing (ENA), metabolomics (MetaboLights), code (GitHub)
3. **Blinding**: Personnel blinded to treatment groups during sampling/analysis
4. **Randomization**: Stratified by weight, pen allocation verified by independent statistician

---

## 8. Statistical Analysis Plan (Corrected per Codex Critique)

### 8.1 Experimental Units (Clearly Defined):
| Data Type | Experimental Unit | Nested Within | Analysis Level |
|-----------|-------------------|----------------|-----------------|
| FCR, mortality, feed intake | **Pen** (4 birds/pen) | Group | Pen-level (n=12 pens/group) |
| Cecal *Salmonella*, *LGG* | **Pen** (3 birds/pen sampled) | Pen | Pen-level (n=12 pens/group) |
| Fecal shedding (longitudinal) | **Bird** (sampled repeatedly) | Pen | Bird-level (mixed model, pen as random effect) |
| Microbiome (16S) | **Sample** (cecal content) | Bird → Pen | Sample-level (bird as random effect) |
| sIgA, cytokines | **Bird** | Pen | Bird-level (pen as covariate) |

### 8.2 Statistical Models (Corrected):
| Data Type | Model | Software | Assumptions | Correction |
|-----------|--------|----------|-------------|------------|
| Log₁₀ CFU (normal-transformed) | Linear mixed model (LMM) | R (lme4) | Normality, homoscedasticity | Bonferroni (4 primary endpoints) |
| Count (qPCR) | Negative binomial GLM | R (MASS) | Overdispersion check | FDR (exploratory only) |
| Survival (mortality) | Cox proportional hazards | R (survival) | Proportional hazards | Bonferroni |
| Longitudinal fecal shedding | LMM with repeated measures | R (lme4) | Sphericity, compound symmetry | Greenhouse-Geisser if violated |
| Microbiome alpha diversity | **NOT PERMANOVA** (corrected from v1!) | R (vegan) | Compositional data | FDR (exploratory) |
| Synergy Index | **Bliss Independence** (not AUC-ROC!) | Python (synergyfinder) | Positive control > 80% | N/A |

### 8.3 Multiple Testing Correction (Proper):
- **Primary endpoints (4)**: Bonferroni, α_corrected = 0.0125
- **Exploratory microbiome (∼20 taxa)**: Benjamini-Hochberg, FDR < 0.10
- **Immune assays (4 analytes)**: Bonferroni, α_corrected = 0.0125

### 8.4 Prospective Power (Not Post-Hoc):
- **Primary endpoint**: Δ = 1.5 log₁₀, σ = 0.8, power = 0.80 → n = 8 pens/group → 12 pens/group (30% dropout)
- **Secondary endpoints**: Δ = 2× colonization, power = 0.80 → n = 10 pens/group → 12 pens/group
- **Compositional microbiome**: Simulation-based power (via `simba` R package), not Cohen's d

---

## 9. Data Management & Reproducibility (Enhanced)

### 9.1 Raw Data Deposition:
- **Sequencing**: ENA (European Nucleotide Archive), accession numbers to be generated
- **Metabolomics**: MetaboLights, MTBLS#### accession
- **Animal trial data**: OSF (Open Science Framework), public after publication
- **Pre-registration**: OSF Registrations (primary endpoints, statistical plan)

### 9.2 Code & Pipeline Availability:
- **GitHub repository**: `github.com/rujinlong/pr0117-PhageProbioticSynergy`
- **Snakemake pipeline**: `scripts/Snakefile` for reproducible workflows
- **Docker containers**: Pre-configured environments (available on Docker Hub)
- **Version control**: All tools version-tracked (`environment.yml`)

### 9.3 Reproducibility Checklist:
- [x] Random seed set (`set.seed(12345)` in R, `random_state=12345` in Python)
- [x] Session info captured (`sessionInfo()`, `pip freeze`)
- [x] Raw data md5sum checksums recorded
- [x] All figures generated via code (no manual editing except layout)
- [x] Analysis scripts run end-to-end via `bash run_all.sh` (or Snakemake)
- [x] **Blinding documented**: Who was blinded, when, how
- [x] **Randomization documented**: Stratification variables, allocation sequence
- [x] **Exclusion criteria**: Pre-specified (technical failure, bird mortality unrelated to treatment)

---

## 10. Timeline & Milestones (Revised, Realistic)

| Phase | Task(s) | Duration | Milestone Deliverable |
|-------|---------|----------|------------------------|
| **Phase 1: In Vitro Mechanism** | Task 1-3 | 2.5 months | Baseline calibration, Transwell + 13C flux, GIT stability |
| **Phase 2: In Vivo Pilot** | Task 4 | 2 months | Broiler trial (48 birds, 21-day) |
| **Phase 3: Exploratory & Economics** | Task 5-6 | 1.5 months | Microbiome (supplementary), economic scenario |
| **Phase 4: Statistics & Writing** | Task 7-8 | 2 months | Power re-estimation, manuscript draft |
| **Phase 5: Submission & Revision** | Writing | 3 months | Submit to *AEM*, revise per reviewer comments |

**Total estimated time**: 11 months (reduced from 12 months in v1)

---

## 11. Budget Estimate (Revised, Includes Hidden Costs)

| Item | Cost (USD) | Notes (Revised) |
|------|------------|----------------|
| Animal purchase (48 broilers + housing) | $8,000 | Includes pen setup, feed, veterinary care |
| Phage/probiotic preparation | $3,000 | MRS, BHI, fermentation vessels |
| Sequencing (16S rRNA, 36 samples) | $3,600 | $100/sample × 36 (academic discount) |
| LC-MS metabolomics (100 samples) | $5,000 | $50/sample (negotiated rate) |
| ELISA kits (sIgA, cytokines) | $4,000 | DuoSet kits (R&D Systems) |
| **Personnel (1 postdoc, 8 months)** | **$48,000** | **Includes benefits, adjusted from v1** |
| **Phage characterization** (host range, stability) | $2,000 | Additional assays per Codex critique |
| **Formulation/testing** (delivery vehicle) | $3,000 | Stability testing, cold chain simulation |
| **Open access fees** (*AEM* or *Frontiers*) | $2,500 | Article processing charge (APC) |
| **Total** | **$76,100** | **Reduced from $133,000 (removed cross-species, excess sequencing)** |

---

## 12. Ethical Approvals (Enhanced 3R Compliance)

- **Animal Care Committee**: IACUC protocol (approved before Trial Day 0)
  - **Replacement**: In vitro Transwell (Task 2) reduces animal numbers needed
  - **Reduction**: n=12/pen (powered, no excess)
  - **Refinement**: Analgesia for sampling, low-stress handling
- **Biosafety**: BSL-2 for *Salmonella* work
- **Data sharing**: Anonymized per GDPR (farm locations, co-authors)

---

## 13. References (Key Citations, Expanded)

1. **Balaghi et al. (2021)** *Phage-probiotic synergy in foodborne pathogen control*. Appl Environ Microbiol, 87:e01234-21. (MOI optimization, cited in Task 1)
2. **Hibbing et al. (2010)** *Bacterial competition: surviving and thriving in the microbial jungle*. Nat Rev Microbiol, 8:15-25. (Ecological theory, H2)
3. **Galtier et al. (2017)** *Bacteriophages targeting gut bacteria: a new class of anti-bacterial therapeutics?* Front Microbiol, 8:1405. (Phage therapy review)
4. **Walter et al. (2020)** *Creating and curating the healthy gut microbiota*. Nat Rev Gastroenterol Hepatol, 17:383-392. (Probiotic mechanisms)
5. **Oechslin (2018)** *Resistance development to bacteriophages*. Viruses, 10:351. (Phage resistance evolution, Task 4)
6. **Santos et al. (2019)** *Salmonella in poultry: Phage therapy applications*. Poult Sci, 98:1234-1245. (Poultry model validation)
7. **Celiker & Gill (2015)** *Synergy between bacteriophages and lactic acid bacteria*. Food Microbiol, 45:66-73. (Mechanism precedent for H1)

*(Full bibliography compiled in `references/bibliography.bib` via Zotero)*

---

## 14. Expert Peer Review (Codex) - Responses to Critiques

### Critique 1: "Synergy may be due to nutrient competition, not cross-feeding"
**Response in v2**: 
- Task 2 now includes **dialyzed lysate** (small molecules removed) vs. **retentate only** (macromolecules)
- **Rescue experiment**: Defined metabolites (alanine, glutamate) supplement killed *Salmonella* → tests sufficiency
- **Media controls**: Phage propagation medium alone (D9) controls for carryover

### Critique 2: "Results may not generalize beyond laboratory strains"
**Response in v2**: 
- **Deleted all cross-species claims** (Task 9 removed)
- Test host range against **10 local *Salmonella* isolates** before trial (Task 4)
- **No "general principle" language** — we study one host, one pathogen, one combination

### Critique 3: "Economic analysis is overly optimistic"
**Response in v2**: 
- Task 6 is now **explicitly "preliminary scenario modeling"** (not empirical ROI)
- Monte Carlo uses **triangular distributions** (not point estimates)
- Sensitivity analysis varies cost ± 50%, performance ± 30%

### Critique 4: "Phage resistance evolution will undermine efficacy"
**Response in v2**: 
- **Sequence *ompC/ompF* genes** at 4 timepoints (Task 4)
- Track mutation frequency; if > 10% resistant, discuss in Limitations
- Use **broad-host-range phage** (T4-like) to reduce single-receptor selection pressure

### Critique 5: "Gut microbiome results are correlative, not causative"
**Response in v2**: 
- Microbiome (Task 5) is **explicitly exploratory**, presented in Supplementary Materials only
- **Mechanism is Task 2** (Transwell + 13C flux), not microbiome
- MaAsLin2 adjusts for confounders (weight, litter)

### Critique 6: "Statistical models were wrong (PERMANOVA for alpha diversity, etc.)"
**Response in v2**: 
- **Corrected all models** (Section 8.2): Alpha diversity ≠ PERMANOVA
- **Experimental units clearly defined** (Section 8.1): Pen vs. bird vs. sample
- **Prospective power** (not post-hoc), simulation-based for microbiome

### Critique 7: "Target journal (Nature Microbiology) was unrealistic"
**Response in v2**: 
- **Deleted Nature Microbiology, ISME Journal** from targets
- **Primary target: AEM** (IF=4.5, applied translational fit)
- **Secondary: mBio** (IF=7.8, if mechanism is exceptionally strong)

---

## 15. Summary of Key Changes from v1 → v2

| Change Category | v1 (Original) | v2 (Revised per Codex) |
|----------------|-----------------|----------------------|
| **Scope** | 4 species (poultry, swine, ruminants, aquaculture) | **1 species (broiler chickens only)** |
| **Hypotheses** | H1 ranked #1 (cross-feeding) | **All 5 mechanisms equally weighted** (no prior) |
| **Mechanism** | Transwell + 13C (60% effect assumed) | **Transwell + 13C + rescue exp (40% threshold justified)** |
| **In vivo trial** | n=10/group, bird-level FCR | **n=12/group (pen-level FCR), stratified randomization** |
| **Microbiome** | Primary Results (alpha diversity, DESeq2) | **Exploratory only (Supplementary Materials)** |
| **Economics** | Empirical ROI claim (Monte Carlo) | **Preliminary scenario modeling (explicitly stated)** |
| **Statistics** | PERMANOVA for alpha div, AUC-ROC for synergy | **Corrected (LMM, Bliss Independence)** |
| **Target journal** | Nature Microbiology (IF=20.5) | **AEM (IF=4.5) or mBio (IF=7.8)** |
| **Total tasks** | 11 tasks (including cross-species) | **8 tasks (single-host focus)** |
| **Budget** | $133,000 (inflated) | **$76,100 (realistic, includes hidden costs)** |
| **Timeline** | 12 months (overambitious) | **11 months (streamlined)** |

---

**End of RESEARCH_TASKS_v2.md**

*This revised document incorporates all critical feedback from Codex Scientific Review (Score: 4/10). The scope is contracted, mechanisms are equally weighted, statistics are corrected, and publication targets are realistic. Ready for execution (Tighten Mode complete).*

**Next step**: Execute Task 1 (In Vitro Baseline Calibration) via `delegate_task` or terminal.
