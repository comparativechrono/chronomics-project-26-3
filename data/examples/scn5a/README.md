# The project data — SCN5A promoter haplotype

Small slices of large public datasets, around the cardiac sodium-channel gene *SCN5A* on chromosome 3 (GRCh38).
Every file is rebuilt from its source by a script in [`../../../data-build/`](../../../data-build/). The guide
(left pane, *The project data*) describes each file for the student; this README is the technical summary.

The two variants: **rs41310749** (chr3:38,651,526 G>A) and **rs41310239** (chr3:38,650,537 A>G). *SCN5A* is on
the minus strand, so both lie upstream of the gene, in its promoter.

| Folder / file | What it is | Source |
|---|---|---|
| `reference/GRCh38_chr3_SCN5A.fa.gz` | GRCh38 chr3, 1–39.4 Mb (only 37.9–39.4 Mb real sequence, the rest N) | NCBI RefSeq NC_000003.12 |
| `reference/genes_GRCh38.gff3` | protein-coding genes of the locus + MANE exons | Ensembl REST |
| `reference/SCN5A_exons.bed` | *SCN5A* MANE exons, numbered from the gene start | Ensembl |
| `reference/SCN5A_promoter_variants.bed`, `SCN5A_haplotype_block.bed` | the two variants; the ~50 kb block (for the genome browser) | this project |
| `reference/dbsnp157_scn5a_2Mb.vcf.gz` | rsIDs for the 2-Mb locus | NCBI dbSNP build 157 |
| `hprc/hprc_scn5a_promoter.vcf.gz`, `hprc_scn5a_2Mb.vcf.gz` | HPRC release 2 pangenome (Minigraph–Cactus v2.1), 231 people / 462 haplotypes | human-pangenomics (AWS) |
| `hprc/hprc_samples.tsv` | who the HPRC people are | HPRC release 2 metadata |
| `1000g/1kgp_scn5a_2Mb.vcf.gz` | 1000 Genomes high-coverage phased panel (3,202 people) | 1000 Genomes / NYGC 2022 |
| `1000g/1kgp_samples.tsv` | who they are (incl. the 2,504 unrelated) | 1000 Genomes |
| `gwas/brugada_Barc2022_SCN5A_SCN10A.tsv` | Brugada GWAS, *SCN5A*–*SCN10A* locus (GRCh38-harmonised) | Barc et al. 2022, GWAS Catalog GCST90086158 |
| `gtex/GTEx_v8_SCN5A_rs41310749.tsv` | GTEx v8 eQTL of rs41310749 on *SCN5A* in each tissue | GTEx Portal |
| `motifs/JASPAR2024_CORE_vertebrates_nr_pfms.txt` | transcription-factor binding matrices | JASPAR 2024 CORE vertebrates |
| `primates/scn5a_promoter_primates.fa` | the *SCN5A* promoter in ten primates | Ensembl EPO alignment |
| `primates/archaic_alleles.tsv` | Neanderthal/Denisovan alleles at the two sites | MPI EVA (Altai, Vindija, Denisova) |

All data are public and anonymous. The human genotype data are population reference panels and summary numbers,
not patients. Cite the original studies when you use the results (the guide's *The project data* page lists them).
