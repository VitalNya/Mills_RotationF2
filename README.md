# Long-read Detection and Filtering of Nuclear Mitochondrial Insertions (NUMTs)

## Overview
This project implements a long-read–based workflow for detecting, classifying, and validating nuclear mitochondrial DNA insertions (NUMTs) using PALMER output. The pipeline integrates reference and germline NUMT catalogs, applies Wei et al.–style de-redundancy adapted for long-read data, and performs IGV-based validation to identify high-confidence somatic NUMT candidates.

The primary goals of this project are:
- To distinguish **reference**, **germline**, and **somatic** NUMTs
- To reduce call-level redundancy while preserving biological resolution
- To benchmark long-read NUMT detection using HapMap mixing data
- To visually validate NUMT breakpoints using IGV

---

## Data Sources

### Reference NUMTs
- Reference NUMTs were obtained from the Mills Lab `dinumt` repository:

- Wei et al. (2022) Supplementary Table 1 (non-reference germline NUMTs):
- Converted from Excel to BED format

### NUMT Calls
- NUMT calls were generated using **PALMER** from long-read sequencing data.

---

## Pipeline Overview

### 1. Input Preparation
- Convert PALMER output files to BED-like format
- Standardize coordinate columns for downstream intersection

### 2. Genomic Expansion
- Expand breakpoints by ±25 bp using `bedtools slop` to account for minor breakpoint uncertainty

### 3. Classification by Overlap
NUMT calls are classified based on overlap with known catalogs:
- **Reference NUMTs**: overlap hg38 reference NUMTs
- **Germline NUMTs**: overlap known germline NUMT sets
- **Somatic candidates**: do not overlap reference or germline NUMTs

### 4. De-redundancy (Wei-style, adapted)
To prevent overcounting, call-level redundancy is reduced using a Wei et al.–inspired approach:
- Calls are grouped if they overlap within:
- ±20–25 bp in nuclear coordinates
- ±200 bp in mitochondrial coordinates
- From each group, the call with the highest supporting read count is retained

> Note: Smaller windows were used compared to Wei et al. (2022) due to increased breakpoint precision in long-read data.

### 5. Visualization and Validation
- Distributions of supporting reads are plotted before and after deduplication
- Candidate NUMTs are manually inspected in IGV for:
- Soft-clipped reads at nuclear–mtDNA junctions
- Consistent breakpoint clustering
- Clipped sequences may be BLATed against the mitochondrial genome to confirm origin

---

## Example Output Files

| File | Description |
|-----|------------|
| `*_overlapping_reference_full.txt` | PALMER calls overlapping reference NUMTs |
| `*_overlapping_germline_full.txt` | PALMER calls overlapping germline NUMTs |
| `*_somatic_candidates_full.txt` | Candidate somatic NUMT calls |
| `*_dedup.txt` | De-redundant event-level NUMT calls |

---

## IGV Interpretation Guide

Expected IGV signals for NUMTs:
- Soft clipping at **one end** of reads (nuclear–mtDNA junction)
- Multiple reads clipped at the same coordinate
- Clean alignment on the opposite read end

Reference NUMTs typically show continuous coverage without soft clipping.

---

## Software Requirements

- Python ≥ 3.8
- pandas
- matplotlib
- bedtools
- bcftools
- IGV (for visualization)

---

## References

Citations:
- Wei, W., Schon, K.R., Elgar, G. et al. Nuclear-embedded mitochondrial DNA sequences in 66,083 human genomes. Nature 611, 105–114 (2022). https://doi.org/10.1038/s41586-022-05288-7
- Zhou W, Karan KR, Gu W, Klein H-U, Sturm G, De Jager PL, et al. (2024) Somatic nuclear mitochondrial DNA insertions are prevalent in the human brain and accumulate over time in fibroblasts. PLoS Biol 22(8): e3002723. https://doi.org/10.1371/journal.pbio.3002723
- Wang, Seunghyun et al. “Multi-platform framework for mapping somatic retrotransposition in human tissues.” bioRxiv : the preprint server for biology 2025.10.07.680917. 7 Oct. 2025, doi:10.1101/2025.10.07.680917. Preprint.
- Dayama, Gargi & Emery, Sarah & Kidd, Jeffrey & Mills, Ryan. (2014). The genomic landscape of polymorphic human nuclear mitochondrial insertions. Nucleic acids research. 42. 10.1093/nar/gku1038. 

SMaHT Data  (Tissue and HapMap):
- https://data.smaht.org/

Germline Bed Files:
- Zhou W et al., 2024
- Wei et al., 2022

Reference Bed File:
- UCSC Genome Browser

---

## Acknowledgements
This project was conducted in collaboration with the Mills Lab and developed as part of a research rotation focusing on structural variation and mitochondrial genomics.

---

## Contact
For questions, contact:
**Vital Nyabashi** @ vitalnya@umich.edu
