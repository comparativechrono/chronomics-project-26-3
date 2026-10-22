#!/bin/bash
# data/reference/GRCh38_chr3_SCN5A.fa.gz (+ .fai, .gzi): GRCh38 chromosome 3 (NCBI RefSeq NC_000003.12) from base 1
# to 39,400,000, named chr3, in which only bases 37,900,001-39,400,000 (1.5 Mb around SCN5A) are real sequence:
# bases 1-37,900,000 are written as N, so that positions are those of the whole chromosome while the file stays small.
# Needs: curl, seqtk, bgzip, samtools, python3.   Run:  bash 01_reference.sh OUTDIR
set -euo pipefail
OUT=${1:-data/examples/scn5a}/reference; mkdir -p "$OUT"
START=37900001; END=39400000
curl -sS --retry 3 "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nuccore&id=NC_000003.12&rettype=fasta&seq_start=$START&seq_stop=$END" > "$OUT/chr3_part.fa"
python3 - "$OUT/chr3_part.fa" "$OUT/GRCh38_chr3_SCN5A.fa" "$START" <<'PY'
import sys
src, dst, start = sys.argv[1], sys.argv[2], int(sys.argv[3])
seq = ''.join(l.strip() for l in open(src) if not l.startswith('>')).upper()
full = 'N' * (start - 1) + seq
with open(dst, 'w') as fh:
    fh.write('>chr3 GRCh38 chromosome 3 (NCBI NC_000003.12), bases 1-%d; only bases %d-%d are real sequence, the bases before are N (left out to keep the file small); positions are those of the whole chromosome\n' % (len(full), start, len(full)))
    for i in range(0, len(full), 60):
        fh.write(full[i:i + 60] + '\n')
print(len(seq), 'real bases;', len(full), 'in all')
PY
rm "$OUT/chr3_part.fa"
bgzip -f -@ 2 -i "$OUT/GRCh38_chr3_SCN5A.fa"
samtools faidx "$OUT/GRCh38_chr3_SCN5A.fa.gz"
cut -f 1,2 "$OUT/GRCh38_chr3_SCN5A.fa.gz.fai"
samtools faidx "$OUT/GRCh38_chr3_SCN5A.fa.gz" chr3:38651516-38651536 chr3:38650527-38650547
