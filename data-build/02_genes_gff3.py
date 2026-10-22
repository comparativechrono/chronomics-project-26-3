#!/usr/bin/env python3
"""reference/genes_GRCh38.gff3 and reference/SCN5A_exons.bed: the protein-coding genes of chr3:37.9-39.4 Mb
(GRCh38) with the exons and CDS of their MANE Select transcript, from the Ensembl REST API (GFF3, in 100-kb
pieces). Run:  python3 02_genes_gff3.py OUTDIR"""
import os, sys, time, urllib.request
OUT = os.path.join(sys.argv[1] if len(sys.argv) > 1 else "data/examples/scn5a", "reference"); os.makedirs(OUT, exist_ok=True)
URL = 'https://rest.ensembl.org/overlap/region/human/3:{a}-{b}?feature=gene;feature=transcript;feature=exon;feature=cds;content-type=text/x-gff3'
def get(url):
    for i in range(5):
        try:
            with urllib.request.urlopen(url, timeout=120) as r: return r.read().decode()
        except Exception as e:
            print('  retry', i, e, file=sys.stderr); time.sleep(2 + 3 * i)
    raise SystemExit('could not fetch ' + url)
rows, seen = [], set()
for a in range(37_900_000, 39_400_000, 100_000):
    for line in get(URL.format(a=a, b=a + 99_999)).splitlines():
        if not line or line.startswith('#'): continue
        f = line.split('\t'); key = (f[2], f[3], f[4], f[8])
        if key not in seen: seen.add(key); rows.append(f)
    time.sleep(0.3)
def attr(f, k):
    for kv in f[8].split(';'):
        if kv.startswith(k + '='): return kv[len(k) + 1:]
    return ''
genes = {attr(f, 'ID'): f for f in rows if f[2] == 'gene' and attr(f, 'biotype') == 'protein_coding'}
mane = {attr(f, 'ID'): f for f in rows if attr(f, 'Parent') in genes and 'MANE_Select' in attr(f, 'tag')}
parts = [f for f in rows if f[2] in ('exon', 'CDS') and attr(f, 'Parent') in mane]
out = []
for gid, g in sorted(genes.items(), key=lambda x: int(x[1][3])):
    out.append(g)
    for tid, t in mane.items():
        if attr(t, 'Parent') == gid:
            out.append(t)
            out += sorted((p for p in parts if attr(p, 'Parent') == tid), key=lambda p: (int(p[3]), p[2] != 'exon'))
with open(os.path.join(OUT, 'genes_GRCh38.gff3'), 'w') as fh:
    fh.write('##gff-version 3\n##sequence-region chr3 1 39400000\n')
    fh.write('# Protein-coding genes of GRCh38 chr3:37,900,000-39,400,000 with their MANE Select transcript (Ensembl REST, %s)\n' % time.strftime('%B %Y'))
    for f in out: fh.write('\t'.join(['chr3'] + f[1:]) + '\n')
scn5a = [t for t in mane.values() if attr(genes[attr(t, 'Parent')], 'Name') == 'SCN5A'][0]
exons = sorted((p for p in parts if p[2] == 'exon' and attr(p, 'Parent') == attr(scn5a, 'ID')), key=lambda p: int(p[3]))
with open(os.path.join(OUT, 'SCN5A_exons.bed'), 'w') as fh:
    # SCN5A is on the - strand; number exons from the gene's 5' end (highest coordinate = exon 1)
    for i, e in enumerate(reversed(exons), 1):
        fh.write(f'chr3\t{int(e[3]) - 1}\t{e[4]}\tSCN5A_exon{i}\t0\t{e[6]}\n')
print(len(genes), 'genes,', len(mane), 'MANE Select transcripts,', len(exons), 'SCN5A exons')
