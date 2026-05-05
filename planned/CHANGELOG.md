# CHANGELOG.md: Version History & Review Responses

**Project**: pr0117-PhageProbioticSynergy  
**Document Type**: Version tracking, external review responses, scope changes, pending decisions

---

## Version History

### v3 (2026-05-05) — Document Architecture Restructuring
**Type**: Major refactoring (per Codex Audit Report)

**Changes**:
- ✅ **README.md** completely rewritten:
  - Now serves only as repository entry point (navigation only)
  - Removed all research plan content (stages, tasks, expected outcomes)
  - Added clear scope statement (single host, single pathogen, single combination)
  - Added document hierarchy declaration (PROJECT_PLAN = sole authority)
  - Removed outdated "Current status" and cross-species narratives
  - Fixed typo: "已有权具" → "已有工具" removed (content deleted)

- ✅ **planned/PROJECT_PLAN.md** created (upgraded from RESEARCH_TASKS.md):
  - Removed all meta-information (Model, Agent, Skill, Review Score)
  - Removed Section 14: Expert Peer Review (Codex) - Responses to Critiques
  - Removed Section 15: Summary of Key Changes from v1 → v2
  - Corrected internal numerical conflicts (bird/pen/group/power):
    - Line 219: "48 broilers, 4 groups, n=12 birds/group" → clarified as "48 broilers, 12 pens total (4 pens/group × 3 replicates, 4 birds/pen)"
    - Line 248: "12 pens/group" → corrected to "12 pens total (4 pens/group)"
    - Line 485: Statistical table updated to "n=12 pens total, 4 pens/group"
  - Corrected statistical terminology:
    - Line 345: "Post-hoc power analysis" → "Prospective power analysis" (consistent with title)
    - Line 497: Removed "sphericity / Greenhouse-Geisser" (not applicable to LMM)
  - Cleaned references to non-existent files:
    - Removed `scripts/Snakefile`, `environment.yml`, `run_all.sh` references
    - Changed to "Scripts to be created in `scripts/` directory (planned)"
  - Standardized document title: "PROJECT_PLAN.md" (removed "v2" from heading)

- ✅ **planned/RESEARCH_AUDIT_REPORT.md** created:
  - Full Codex audit report (score: 5.5/10)
  - Contains detailed critique, integration suggestions, prioritized improvement checklist
  - Serves as reference for document architecture decisions

- ✅ **planned/CHANGELOG.md** created (this file):
  - Stores all version history
  - Stores external review responses
  - Stores scope changes and pending decisions

**Files Modified**:
- `README.md` (complete rewrite)
- `planned/RESEARCH_TASKS.md` → `planned/PROJECT_PLAN.md` (renamed + cleaned)

**Files Created**:
- `planned/PROJECT_PLAN.md`
- `planned/RESEARCH_AUDIT_REPORT.md`
- `planned/CHANGELOG.md`

**Files Not Modified** (per user instruction):
- `analyses/*.qmd` (all analysis files untouched)
- `analyses/*.md` (all analysis files untouched)

**New Document Architecture** ("One Main + Two Supporting"):
```
README.md                → Repository entry point (navigation only)
planned/PROJECT_PLAN.md → ★ Sole authoritative research plan
planned/CHANGELOG.md   → Version history & review responses
planned/RESEARCH_AUDIT_REPORT.md → Audit reference (archive)
analyses/*.qmd          → Analysis modules (untouched)
```

---

### v2 (2026-05-05) — Scientific Scope Contraction (per Codex Review)
**Type**: Major scientific revision

**Changes** (from original RESEARCH_TASKS.md to v2):
- ✅ **Scope contraction**: 4 species → 1 species (broiler chickens only)
- ✅ **Hypotheses**: H1 ranked #1 → All 5 mechanisms equally weighted (no prior)
- ✅ **Mechanism**: Transwell + 13C (60% effect assumed) → Transwell + 13C + rescue exp (40% threshold justified)
- ✅ **In vivo trial**: n=10/group, bird-level FCR → n=12 pens total (pen-level FCR), stratified randomization
- ✅ **Microbiome**: Primary Results → Exploratory only (Supplementary Materials)
- ✅ **Economics**: Empirical ROI claim → Preliminary scenario modeling (explicitly stated)
- ✅ **Statistics**: PERMANOVA for alpha div, AUC-ROC for synergy → Corrected (LMM, Bliss Independence)
- ✅ **Target journal**: Nature Microbiology (IF=20.5) → AEM (IF=4.5) or mBio (IF=7.8)
- ✅ **Total tasks**: 11 tasks (including cross-species) → 8 tasks (single-host focus)
- ✅ **Budget**: $133,000 (inflated) → $76,100 (realistic, includes hidden costs)
- ✅ **Timeline**: 12 months (overambitious) → 11 months (streamlined)

**Codex Review Score**: 4/10 (original) → improvements incorporated in v2

---

### v1 (2026-05-04) — Original Research Tasks Document
**Type**: Initial creation

**Content**: Original RESEARCH_TASKS.md with:
- 11 tasks (including cross-species analysis)
- Ranked hypotheses (H1: cross-feeding as #1)
- Target: *Nature Microbiology* (unrealistic)
- Empirical ROI claims (overoptimistic)
- Statistical errors (PERMANOVA for alpha diversity, etc.)
- Budget: $133,000 (inflated)
- Timeline: 12 months (overambitious)

**Status**: Superseded by v2 (2026-05-05)

---

## Review Responses (Codex Scientific Review)

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

## Scope Changes (Explicit)

| Change Category | v1 (Original) | v2/v3 (Revised) |
|----------------|-----------------|----------------------|
| **Species scope** | 4 species (poultry, swine, ruminants, aquaculture) | **1 species (broiler chickens only)** |
| **Pathogen scope** | Multiple strains | **Single strain (S. Typhimurium ATCC 14028)** |
| **Combination scope** | Multiple phages + probiotics | **Single pair (T4-like + LGG)** |
| **Hypothesis ranking** | H1 ranked #1 (cross-feeding) | **All 5 mechanisms equally weighted** |
| **Mechanism evidence** | Transwell + 13C (60% assumed) | **Transwell + 13C + rescue (40% justified)** |
| **In vivo design** | n=10/group, bird-level | **12 pens total, pen-level FCR** |
| **Microbiome role** | Primary Results | **Exploratory only (Supplementary)** |
| **Economics** | Empirical ROI claim | **Preliminary scenario modeling** |
| **Statistics** | PERMANOVA, AUC-ROC | **LMM, Bliss Independence** |
| **Target journal** | Nature Microbiology (IF=20.5) | **AEM (IF=4.5) or mBio (IF=7.8)** |
| **Document structure** | README + RESEARCH_TASKS.md (dual truth) | **README (nav) + PROJECT_PLAN (sole authority)** |

---

## Pending Decisions

1. **[ ] Delete `planned/RESEARCH_TASKS.md`?**
   - Current status: Still exists (copied to PROJECT_PLAN.md)
   - Options: Delete (recommended) or keep as `RESEARCH_TASKS_v2_archive.md`
   - User preference: TBD

2. **[ ] Create `planned/STUDY_PROTOCOL.md`?**
   - Codex suggestion: Separate experimental protocol from project plan
   - Content: Experimental design, sampling, statistics, ethics, pre-registration
   - Priority: Low (can be created when preparing IACUC submission)

3. **[ ] Create `scripts/` directory?**
   - Referenced in PROJECT_PLAN.md as "to be created"
   - Tasks 1-6 reference script files (e.g., `task1_baseline_calibration.R`)
   - Action needed: Create directory + add placeholder scripts when starting Task 1

4. **[ ] Create `references/bibliography.bib`?**
   - Referenced in PROJECT_PLAN.md Section 13
   - Current status: Does not exist (see memory: symlink from `/Users/cmbjx/storage/references.bib`)
   - Action: Create symlink (per user memory: `ln -s /Users/cmbjx/storage/references.bib references/bibliography.bib`)

5. **[ ] Update `planned/` directory?**
   - Current status: Contains `11-synergy-network-modeling.qmd` through `17-cost-benefit-analysis.qmd`
   - These are from v1 (cross-species era)
   - Options: Delete (recommended) or move to `planned/archive/`

---

## Lessons Learned

1. **Dual truth is dangerous**: Having two documents (README + RESEARCH_TASKS.md) with conflicting scopes caused confusion. Solution: Single authoritative source (PROJECT_PLAN.md).

2. **Version drift is real**: README described "cross-species platform" while RESEARCH_TASKS.md had already contracted to "single host". Solution: Regular sync or single-source publishing.

3. **Document overload hurts**: Putting study plan + review responses + version changes + budget + ethics in one document made it unwieldy. Solution: "One Main + Two Supporting" architecture.

4. **Numerical contradictions undermine credibility**: Bird/pen/group conflicts in the same document damage scientific rigor. Solution: Independent review + audit before finalizing.

5. **Don't reference non-existent files**: Claiming `scripts/Snakefile` exists when it doesn't reduces trust. Solution: Mark planned files explicitly as "to be created".

---

**End of CHANGELOG.md**

*This file tracks all major changes to project documentation. For the current authoritative research plan, see `planned/PROJECT_PLAN.md`. For the audit report that motivated this restructuring, see `planned/RESEARCH_AUDIT_REPORT.md`.*
