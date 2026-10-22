#!/bin/bash
# reference/dbsnp157_scn5a_2Mb.vcf.gz (+ .tbi): the variants of dbSNP build 157 between chr3:37,650,000 and
# 39,650,000 (GRCh38) - positions, rsIDs and alleles, without INFO; chromosome renamed NC_000003.12 -> chr3.
# Needs: bcftools, bgzip, tabix (htslib with network access).   Run:  bash 03_dbsnp.sh OUTDIR
set -euo pipefail
OUT=${1:-data/examples/scn5a}/reference; mkdir -p "$OUT"
URL=https://ftp.ncbi.nih.gov/snp/archive/b157/VCF/GCF_000001405.40.gz
{
  printf '##fileformat=VCFv4.2\n##FILTER=<ID=PASS,Description="All filters passed">\n'
  printf '##source=dbSNP build 157 (NCBI), GRCh38; positions chr3:37,650,000-39,650,000; INFO removed\n'
  printf '##contig=<ID=chr3,length=198295559,assembly=GRCh38>\n'
  printf '#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\n'
  bcftools query -r NC_000003.12:37650000-39650000 -f 'chr3\t%POS\t%ID\t%REF\t%ALT\t.\t.\t.\n' "$URL"
} | bgzip > "$OUT/dbsnp157_scn5a_2Mb.vcf.gz"
tabix -f -p vcf "$OUT/dbsnp157_scn5a_2Mb.vcf.gz"
bcftools view -H "$OUT/dbsnp157_scn5a_2Mb.vcf.gz" | wc -l
