#!/bin/bash
# results/archaic_alleles.tsv: the genotype of the Altai and Vindija Neanderthals and the Denisovan at the two
# variant positions (GRCh37: rs41310749 3:38,693,017; rs41310239 3:38,692,028), from the MPI EVA VCFs (hg19).
# Needs: tabix (htslib with network access).   Run:  bash 08_archaic.sh OUTDIR
set -u
OUT=${1:-data/examples/scn5a}; mkdir -p "$OUT/primates"
declare -A U=(
 [Altai]="http://cdna.eva.mpg.de/neandertal/altai/AltaiNeandertal/VCF/AltaiNea.hg19_1000g.3.mod.vcf.gz"
 [Vindija]="http://cdna.eva.mpg.de/neandertal/Vindija/VCF/Vindija33.19/chr3_mq25_mapab100.vcf.gz"
 [Denisova]="http://cdna.eva.mpg.de/neandertal/altai/Denisovan/DenisovaPinky.hg19_1000g.3.mod.vcf.gz" )
{ echo -e "archaic\tvariant\tpos_GRCh37\tREF\tALT\tgenotype"
for name in Altai Vindija Denisova; do
  for v in "rs41310749 38693017" "rs41310239 38692028"; do
    set -- $v; rs=$1; pos=$2
    line=$(tabix "${U[$name]}" 3:$pos-$pos 2>/dev/null | head -1)
    if [ -n "$line" ]; then gt=$(echo "$line" | awk '{split($10,a,":"); print a[1]}'); ref=$(echo "$line"|awk '{print $4}'); alt=$(echo "$line"|awk '{print $5}')
      echo -e "$name\t$rs\t$pos\t$ref\t$alt\t$gt"
    else echo -e "$name\t$rs\t$pos\tNA\tNA\tno_call"; fi
  done
done ; } > "$OUT/primates/archaic_alleles.tsv"
cat "$OUT/primates/archaic_alleles.tsv"
