#!/bin/bash
# hprc/hprc_scn5a_promoter.vcf.gz and hprc/hprc_scn5a_2Mb.vcf.gz (+ .tbi): the HPRC release 2 pangenome
# (Minigraph-Cactus v2.1, GRCh38-based VCFs) around SCN5A, without the reference haplotype CHM13 and without the
# graph's INFO fields.
#   - hprc_scn5a_promoter.vcf.gz   the graph's bubbles, whole alleles, chr3:38,648,000-38,653,000 (promoter + exon 1)
#   - hprc_scn5a_2Mb.vcf.gz        decomposed into SNVs/indels/SVs, chr3:37,650,000-39,650,000
# Needs: bcftools and tabix with network access.   Run:  bash 04_hprc.sh OUTDIR
set -euo pipefail
OUT=${1:-data/examples/scn5a}/hprc; mkdir -p "$OUT"
B=https://human-pangenomics.s3.amazonaws.com/pangenomes/freeze/release2/minigraph-cactus/v2.1/hprc-v2.1-mc-grch38
bcftools view -r chr3:38648000-38653000 "$B/hprc-v2.1-mc-grch38.vcf.gz" -Ou \
  | bcftools view -s ^CHM13 -Ou \
  | bcftools annotate -x ID,INFO/AT,INFO/AF,INFO/NS -Oz -o "$OUT/hprc_scn5a_promoter.vcf.gz"
bcftools view -r chr3:37650000-39650000 "$B/hprc-v2.1-mc-grch38.wave.vcf.gz" -Ou \
  | bcftools view -s ^CHM13 -Ou \
  | bcftools annotate -x ID,INFO/AF,INFO/NS -Oz -o "$OUT/hprc_scn5a_2Mb.vcf.gz"
for f in hprc_scn5a_promoter hprc_scn5a_2Mb; do tabix -f -p vcf "$OUT/$f.vcf.gz"; echo "$f: $(bcftools view -H "$OUT/$f.vcf.gz" | wc -l) records, $(bcftools query -l "$OUT/$f.vcf.gz" | wc -l) samples"; done
