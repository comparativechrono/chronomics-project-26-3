#!/bin/bash
# motifs/JASPAR2024_CORE_vertebrates_nr_pfms.txt: the JASPAR 2024 CORE vertebrate non-redundant binding matrices.
# Needs: curl.   Run:  bash 10_motifs.sh OUTDIR
set -euo pipefail
OUT=${1:-data/examples/scn5a}/motifs; mkdir -p "$OUT"
curl -sS --retry 3 -o "$OUT/JASPAR2024_CORE_vertebrates_nr_pfms.txt" \
  "https://jaspar.elixir.no/download/data/2024/CORE/JASPAR2024_CORE_vertebrates_non-redundant_pfms_jaspar.txt"
grep -c '^>' "$OUT/JASPAR2024_CORE_vertebrates_nr_pfms.txt"
