#!/bin/bash
# gwas/brugada_Barc2022_SCN5A_SCN10A.tsv: the SCN5A-SCN10A locus (chr3:38,540,000-38,720,000, GRCh38) of the
# Brugada syndrome GWAS of Barc et al. 2022 (Nat Genet; GWAS Catalog GCST90086158), from the GRCh38-harmonised
# summary statistics. The full file is ~270 MB; this keeps the ~470 variants of the locus.
# Needs: curl, gzip, awk.   Run:  bash 07_brugada_gwas.sh OUTDIR
set -euo pipefail
OUT=${1:-data/examples/scn5a}/gwas; mkdir -p "$OUT"
U="https://ftp.ebi.ac.uk/pub/databases/gwas/summary_statistics/GCST90086001-GCST90087000/GCST90086158/harmonised/35210625-GCST90086158-Orphanet_130.h.tsv.gz"
curl -sS --retry 3 -m 600 "$U" | zcat | awk -F'\t' 'NR==1{print;next} $3==3 && $4>=38540000 && $4<=38720000' > "$OUT/brugada_Barc2022_SCN5A_SCN10A.tsv"
echo "$(wc -l < "$OUT/brugada_Barc2022_SCN5A_SCN10A.tsv") lines"
