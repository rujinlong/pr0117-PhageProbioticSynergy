---
params:
  name: 01-public-data-mining
title: Public Data Mining for Phage-Probiotic Synergy
---

# Public Data Mining for Phage-Probiotic Synergy

## Setup

\`\`\`{r setup} \#\| label: setup here::i_am(paste0(params\$name,
“.qmd”), uuid = “a1b2c3d4-e5f6-7890-abcd-ef1234567890”)

# qproj setup

qproj::proj_create_dir_target(params$`name)
path_target <- qproj::path_target(params`$name) path_source \<-
qproj::path_source(params\$name)

# Create subdirectories

dir.create(file.path(path_target, “raw”), showWarnings = FALSE)
dir.create(file.path(path_target, “processed”), showWarnings = FALSE)
dir.create(file.path(path_target, “datasets”), showWarnings = FALSE)


    ## Load Packages

    ```{r packages}
    #| label: packages
    library(tidyverse)
    library(here)
    library(qproj)
    # For data retrieval
    library(rentrez)      # NCBI/PubMed/SRA
    library(biomaRt)      # Biomart annotations
    library(ape)           # Phylogenetics

## 1. Data Sources Overview

This module focuses on mining publicly available datasets relevant to
phage-probiotic synergy in animal health:

### 1.1 Target Animals

- **Poultry** (chicken, duck) - 家禽
- **Aquaculture species** (fish, shrimp) - 水产
- **Livestock** (pig, cattle) - 牲畜

### 1.2 Target Pathogens

- *Clostridium perfringens* (坏死性肠炎)
- *Salmonella enterica* (沙门氏菌)
- *Escherichia coli* (致病性大肠杆菌)
- *Vibrio* spp. (水产病原体)

### 1.3 Target Probiotics

- *Lactobacillus* spp.
- *Bifidobacterium* spp.
- *Bacillus* spp.
- *Enterococcus* spp.

### 1.4 Target Phages

- Lytic phages specific to above pathogens
- Broad host range phages
- Phage cocktails in commercial use

## 2. Public Dataset Search Strategy

### 2.1 SRA (Sequence Read Archive) Search

Search for metagenomic and metatranscriptomic datasets from animal gut
samples.

\`\`\`{r sra-search} \#\| label: sra-search \#\| eval: false

# Search SRA for poultry gut metagenomes

sra_query \<- ‘((chicken OR poultry OR broiler) AND (gut OR intestine)
AND (metagenom\* OR virome))’

# Using rentrez to search SRA via Entrez

# Note: This is a template - actual execution requires NCBI API key

if (FALSE) { \# Set to TRUE when ready to run sra_search \<-
rentrez::entrez_search( db = “sra”, term = sra_query, retmax = 100 )

\# Save search results write_csv( as.data.frame(sra_search\$ids),
file.path(path_target, “raw”, “sra_poultry_gut_ids.csv”) ) }


    ### 2.2 PubMed Literature Search

    Search for recent publications on phage-probiotic combinations.

    ```{r pubmed-search}
    #| label: pubmed-search
    #| eval: false

    # Search PubMed
    pubmed_query <- '("bacteriophage" OR "phage") AND ("probiotic*") AND ("animal" OR "poultry" OR "aquaculture") AND ("synergy" OR "combination")'

    if (FALSE) {
      pubmed_search <- rentrez::entrez_search(
        db = "pubmed",
        term = pubmed_query,
        retmax = 200,
        datetype = "pdat",
        mindate = "2020/01/01",
        maxdate = "2026/12/31"
      )
      
      # Fetch details
      pubmed_summary <- rentrez::entrez_fetch(
        db = "pubmed",
        id = pubmed_search$ids,
        rettype = "xml"
      )
      
      # Save
      writeLines(
        pubmed_summary,
        file.path(path_target, "raw", "pubmed_phage_probiotic_synergy.xml")
      )
    }

### 2.3 NCBI BioProject Search

Search for relevant BioProjects.

\`\`\`{r bioproject-search} \#\| label: bioproject-search \#\| eval:
false

# Template for BioProject search

bioproject_query \<- ‘((phage OR bacteriophage) AND (probiotic OR
microbiota) AND (animal OR gut))’

# Save search strategy

write_lines( c( “BioProject Search Strategy”,
“=========================”, ““, paste(”Query:“,
bioproject_query),”Date:“, Sys.Date(),”“,”Next steps:“,”1. Use NCBI
website or entrez to search BioProject”, “2. Filter by:”, ” - Animal gut
metagenomes”, ” - Phage/probiotic studies”, ” - Available sequencing
data”, ““,”Output: List of BioProject IDs with metadata” ),
file.path(path_target, “bioproject_search_plan.txt”) )


    ## 3. Known Datasets Inventory

    Based on the Notion Research Master Plan and preliminary research:

    ### 3.1 Existing Group Resources
    - Published study: phage/virome in chicken intestines (FCR + natural products)
    - Ongoing phage isolation projects (targeting specific pathogens)
    - Fecal Virome Transplantation (FVT) project in ducks
    - ViroProfiler pipeline
    - TPD (Therapeutic Phage Discovery) pipeline
    - ArchaealDefenseAtlas

    ### 3.2 Public Datasets to Mine

 Dataset Type | Source | Target | Status |
-------------|--------|--------|--------|
 Poultry gut metagenomes | SRA | Chicken gut microbiome | To search |
 Duck gut virome | SRA/BioProject | Duck FVT reference | To search |
 Aquaculture microbiome | SRA/ENA | Fish/shrimp gut | To search |
 Phage-host databases | phagesDB, MVP | Phage collections | To integrate |
 Probiotic genomes | NCBI RefSeq | Lactobacillus, Bifidobacterium | To download |

    ## 4. Data Download Plan

    ### 4.1 SRA Data Download (Template)

    ```{r sra-download-plan}
    #| label: sra-download-plan

    # Template for SRA download using sratoolkit
    sra_download_script <- c(
      "#!/bin/bash",
      "# SRA download script",
      "# Generated by 01-public-data-mining.qmd",
      "",
      "# Set target directory",
      paste0("TARGET_DIR=", path_target, "/raw/sra_fastq"),
      "mkdir -p $TARGET_DIR",
      "",
      "# Example: Download specific runs",
      "# prefetch SRRXXXXXXX -O $TARGET_DIR",
      "# fasterq-dump $TARGET_DIR/SRRXXXXXXX -O $TARGET_DIR/fastq",
      "",
      "# Batch download from list",
      "# cat sra_run_list.txt | while read run; do",
      "#   prefetch $run -O $TARGET_DIR",
      "#   fasterq-dump $TARGET_DIR/$run -O $TARGET_DIR/fastq",
      "# done"
    )

    write_lines(
      sra_download_script,
      file.path(path_target, "scripts", "download_sra.sh")
    )

    # Make executable
    if (file.exists(file.path(path_target, "scripts", "download_sra.sh"))) {
      Sys.chmod(file.path(path_target, "scripts", "download_sra.sh"), "755")
    }

### 4.2 Phage Genome Download

\`\`\`{r phage-genome-download} \#\| label: phage-genome-download \#\|
eval: false

# Template: Download phage genomes from NCBI RefSeq

# Target: Lytic phages against C. perfringens, Salmonella, E. coli

phage_download_plan \<- data.frame( target_pathogen = c(“Clostridium
perfringens”, “Salmonella enterica”, “Escherichia coli”, “Vibrio
cholerae”), search_terms = c(“Clostridium perfringens phage”,
“Salmonella phage”, “Escherichia coli phage”, “Vibrio phage”),
ncbi_query = c( “txid1520\[Organism:exp\] AND phage\[All Fields\]”,
“txid28901\[Organism:exp\] AND phage\[All Fields\]”,
“txid562\[Organism:exp\] AND phage\[All Fields\]”,
“txid666\[Organism:exp\] AND phage\[All Fields\]” ), stringsAsFactors =
FALSE )

write_csv( phage_download_plan, file.path(path_target, “processed”,
“phage_download_plan.csv”) )


    ## 5. Initial Database Construction

    ### 5.1 Database Schema Design

    Build an SQLite database to store all mined data.

    ```{r db-schema}
    #| label: db-schema
    #| eval: false

    library(DBI)
    library(RSQLite)

    # Create SQLite database
    db_path <- file.path(path_target, "datasets", "phage_probiotic_synergy.db")
    con <- dbConnect(SQLite(), db_path)

    # Table: pathogens
    dbExecute(con, "
      CREATE TABLE IF NOT EXISTS pathogens (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        species TEXT,
        common_name TEXT,
        taxon_id INTEGER,
        target_animal TEXT,
        disease TEXT,
        created_date TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ")

    # Table: probiotics
    dbExecute(con, "
      CREATE TABLE IF NOT EXISTS probiotics (
        id INTEGER PRIMARY KEY,
        genus TEXT NOT NULL,
        species TEXT,
        strain TEXT,
        commercial_product TEXT,
        target_animal TEXT,
        created_date TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ")

    # Table: phages
    dbExecute(con, "
      CREATE TABLE IF NOT EXISTS phages (
        id INTEGER PRIMARY KEY,
        name TEXT,
        accession TEXT UNIQUE,
        target_pathogen_id INTEGER,
        host_range TEXT,
        lifestyle TEXT CHECK(lifestyle IN ('lytic', 'temperate', 'unknown')),
        isolation_source TEXT,
        created_date TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (target_pathogen_id) REFERENCES pathogens(id)
      )
    ")

    # Table: datasets
    dbExecute(con, "
      CREATE TABLE IF NOT EXISTS datasets (
        id INTEGER PRIMARY KEY,
        source TEXT NOT NULL,
        accession TEXT,
        data_type TEXT,
        animal_host TEXT,
        publication_doi TEXT,
        download_date TEXT,
        local_path TEXT,
        created_date TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ")

    dbDisconnect(con)

    message("Database schema created at: ", db_path)

### 5.2 Populate Initial Data

\`\`\`{r populate-initial} \#\| label: populate-initial \#\| eval: false

con \<- dbConnect(SQLite(), file.path(path_target, “datasets”,
“phage_probiotic_synergy.db”))

# Insert target pathogens

pathogens_initial \<- data.frame( name = c(“Clostridium perfringens”,
“Salmonella enterica”, “Escherichia coli”, “Vibrio cholerae”, “Vibrio
parahaemolyticus”), species = c(“perfringens”, “enterica”, “coli”,
“cholerae”, “parahaemolyticus”), common_name = c(“C. perfringens”,
“Salmonella”, “E. coli”, “V. cholerae”, “V. parahaemolyticus”), taxon_id
= c(1520, 28901, 562, 666, 2213), target_animal = c(“poultry,duck”,
“poultry,livestock”, “multi”, “aquaculture”, “aquaculture”), disease =
c(“necrotic enteritis”, “salmonellosis”, “colibacillosis”, “cholera”,
“gastroenteritis”) )

dbWriteTable(con, “pathogens”, pathogens_initial, append = TRUE)

# Insert target probiotics

probiotics_initial \<- data.frame( genus = c(“Lactobacillus”,
“Lactobacillus”, “Bifidobacterium”, “Bacillus”, “Enterococcus”), species
= c(“acidophilus”, “plantarum”, “animalis”, “subtilis”, “faecium”),
strain = c(“NCFM”, “299v”, “BB-12”, “CU1”, “EF202”), commercial_product
= c(“Danisco”, “ProViva”, “Chr. Hansen”, “Custom”, “Custom”),
target_animal = c(“poultry,livestock”, “poultry,livestock,aquaculture”,
“livestock”, “aquaculture,poultry”, “poultry”) )

dbWriteTable(con, “probiotics”, probiotics_initial, append = TRUE)

dbDisconnect(con)

message(“Initial data populated”)


    ## 6. Research NotebookLM Integration

    ### 6.1 NotebookLM Research Status

    This project uses NotebookLM notebook `phage-synergy` (ID: 14cd71dc-531c-4412-bf2b-8bc32d42a3f4) as a second brain.

    **Current Research Task**: Deep web search for "phage probiotic synergy animal health metagenomics"
    - Task ID: c8641f35-cf27-40ef-9872-70e616926231
    - Status: In progress (~5 min for deep mode)

    ### 6.2 Import Research Results

    Once research completes, import discovered sources:

    ```bash
    nlm research import phage-synergy c8641f35-cf27-40ef-9872-70e616926231

### 6.3 Google Drive PDF Integration

Search Google Drive for relevant PDFs and import to NotebookLM:

``` bash
# Search Drive for relevant papers
python3 ~/.hermes/skills/productivity/google-workspace/scripts/google_api.py \
  drive search "phage probiotic" --max 20

# Import PDFs to NotebookLM (using file ID from Drive search)
nlm source add phage-synergy --drive <FILE_ID> --type pdf
```

## 7. Session Info

`{r session-info} #| label: session-info sessionInfo()`

## 8. Next Steps

1.  **Complete NotebookLM research** import (check status with
    `nlm research status phage-synergy`)
2.  **Run SRA searches** (enable evaluation in Section 2.1 when API key
    ready)
3.  **Download phage genomes** from RefSeq (Section 4.2)
4.  **Populate database** with mined datasets (Section 5.2)
5.  **Proceed to Module 02** (`02-phage-host-prediction.qmd`)

------------------------------------------------------------------------

*Generated by qproj workflow for pr0117-PhageProbioticSynergy*
