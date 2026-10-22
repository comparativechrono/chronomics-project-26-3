#!/usr/bin/env python3
"""GTEx v8 eQTL effect of rs41310749 (chr3_38651526_G_A_b38) on SCN5A and SCN10A in each tissue (dyneqtl),
and the significant single-tissue eQTLs. Writes results/gtex_eqtl_rs41310749.tsv."""
import urllib.request, json, time, csv, os, sys
OUTDIR=sys.argv[1] if len(sys.argv)>1 else 'data/examples/scn5a'
os.makedirs(os.path.join(OUTDIR,'gtex'),exist_ok=True)
def get(url):
    try: return json.load(urllib.request.urlopen(url, timeout=120))
    except Exception as e: print(' err',str(e)[:100]); return {}
API='https://gtexportal.org/api/v2/'
VAR='chr3_38651526_G_A_b38'
GENES={'SCN5A':'ENSG00000183873.15','SCN10A':'ENSG00000185313.6'}
tissues=[t['tissueSiteDetailId'] for t in get(API+'dataset/tissueSiteDetail?datasetId=gtex_v8&itemsPerPage=250').get('data',[]) if t.get('hasEGenes')]
rows=[]
for sym,gid in GENES.items():
    for t in tissues:
        r=get(API+f'association/dyneqtl?gencodeId={gid}&variantId={VAR}&tissueSiteDetailId={t}&datasetId=gtex_v8')
        if 'nes' in r:
            rows.append([sym,t,r.get('homoRefCount'),r.get('hetCount'),r.get('homoAltCount'),round(r['nes'],4),('%.3g'%r['pValue'])])
        time.sleep(0.1)
rows.sort(key=lambda x:(x[0],float(x[6])))
with open(os.path.join(OUTDIR,'gtex','GTEx_v8_SCN5A_rs41310749.tsv'),'w',newline='') as fh:
    w=csv.writer(fh,delimiter='\t',lineterminator='\n')
    w.writerow(['gene','tissue','n_GG','n_GA','n_AA','NES_altA','p_value']); w.writerows(rows)
# significant single-tissue eqtls
sig=get(API+'association/singleTissueEqtl?variantId='+VAR+'&datasetId=gtex_v8').get('data',[])
print('Significant GTEx single-tissue eQTLs for rs41310749 (derived A):')
for r in sig: print(f'  {r["tissueSiteDetailId"]:30} {r["geneSymbol"]:7} NES={r["nes"]:+.3f} p={r["pValue"]:.2g}')
print('\nHeart + top SCN5A tissues (dyneqtl; NES is for the ALT/derived A allele):')
import pandas as pd
df=pd.DataFrame(rows,columns=['gene','tissue','n_GG','n_GA','n_AA','NES_altA','p_value'])
show=df[df.tissue.str.contains('Heart')|df.tissue.isin(['Whole_Blood','Cells_Cultured_fibroblasts'])]
print(show.to_string(index=False))
print('\nSCN5A: tissues with p<0.05:', (pd.to_numeric(df[df.gene=="SCN5A"].p_value)<0.05).sum(),'/',len(df[df.gene=="SCN5A"]))
print('direction in those:', df[(df.gene=="SCN5A")&(pd.to_numeric(df.p_value)<0.05)].NES_altA.apply(lambda x:'down' if x<0 else 'up').value_counts().to_dict())
