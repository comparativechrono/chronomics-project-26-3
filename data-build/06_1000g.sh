#!/bin/bash
# 1000g/1kgp_scn5a_2Mb.vcf.gz (+ .tbi): the phased SNVs, indels and SVs of the 3,202 people of the high-coverage
# 1000 Genomes Project (NYGC phased panel, 2022) across chr3:37,650,000-39,650,000 (GRCh38), without INFO.
# Needs: bcftools and tabix with network access.   Run:  bash 06_1000g.sh OUTDIR
set -euo pipefail
OUT=${1:-data/examples/scn5a}/1000g; mkdir -p "$OUT"
URL=https://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000G_2504_high_coverage/working/20220422_3202_phased_SNV_INDEL_SV/1kGP_high_coverage_Illumina.chr3.filtered.SNV_INDEL_SV_phased_panel.vcf.gz
bcftools view -r chr3:37650000-39650000 "$URL" -Ou | bcftools annotate -x INFO -Oz -o "$OUT/1kgp_scn5a_2Mb.vcf.gz"
tabix -f -p vcf "$OUT/1kgp_scn5a_2Mb.vcf.gz"
echo "$(bcftools view -H "$OUT/1kgp_scn5a_2Mb.vcf.gz" | wc -l) records, $(bcftools query -l "$OUT/1kgp_scn5a_2Mb.vcf.gz" | wc -l) samples"
