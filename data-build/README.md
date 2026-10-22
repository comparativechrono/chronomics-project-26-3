# How the project data were made

The files in `data/examples/scn5a/` are small slices of large public datasets. These scripts made them from the
sources named at the top of each. Students do not need them; they are here so the data can be checked and remade.

Needs a Linux/macOS machine with `bcftools`, `samtools`, `tabix`/`bgzip`, `seqtk`, `curl`, Python 3 and (for the
primates) network access to Ensembl. From the repository root:

```bash
bash    data-build/01_reference.sh                                   # reference/ FASTA slice
python3 data-build/02_genes_gff3.py                                  # reference/ genes + SCN5A exons
bash    data-build/03_dbsnp.sh                                       # reference/ dbSNP rsIDs
bash    data-build/04_hprc.sh                                        # hprc/ pangenome VCFs
python3 data-build/05_samples.py data/examples/scn5a/hprc/hprc_scn5a_2Mb.vcf.gz data/examples/scn5a   # sample tables
bash    data-build/06_1000g.sh                                       # 1000g/ phased panel
bash    data-build/07_brugada_gwas.sh                                # gwas/ Brugada locus (~270 MB download)
bash    data-build/08_archaic.sh data/examples/scn5a                 # primates/archaic_alleles.tsv
python3 data-build/09_primates.py                                    # primates/ promoter FASTA (writes ./scn5a_promoter_primates.fa; move into primates/)
bash    data-build/10_motifs.sh                                      # motifs/ JASPAR matrices
python3 data-build/11_gtex.py data/examples/scn5a                    # gtex/ eQTL table
```

The two variants and the extended haplotype block were defined in the companion analysis repository
(`SCN5A-analysis`); the BED files `SCN5A_promoter_variants.bed` and `SCN5A_haplotype_block.bed` are written by hand
from those results.
