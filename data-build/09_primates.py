import urllib.request, json, time, sys
def epo(a,b):
    url=f'https://rest.ensembl.org/alignment/region/homo_sapiens/3:{a}-{b}?method=EPO&species_set_group=primates&content-type=application/json'
    for i in range(6):
        try: return json.load(urllib.request.urlopen(url,timeout=180))
        except Exception as e: print('retry',i,str(e)[:70],file=sys.stderr); time.sleep(4+2*i)
    raise SystemExit('fail')
# proximal promoter incl. both variants and the E-boxes (TSS ~38,649,687 .. -2.2kb)
LO,HI=38649600,38651950
block=epo(LO,HI)[0]
# collect each real species' aligned seq; degap to native sequence
names={'homo_sapiens':'human','pan_troglodytes':'chimpanzee','pan_paniscus':'bonobo','gorilla_gorilla':'gorilla',
 'pongo_abelii':'orangutan','nomascus_leucogenys':'gibbon','macaca_mulatta':'rhesus_macaque',
 'macaca_fascicularis':'crab-eating_macaque','chlorocebus_sabaeus':'vervet','microcebus_murinus':'mouse_lemur'}
seqs={}
for a in block['alignments']:
    sp=a['species']
    if sp in names:
        seqs[names[sp]]=a['seq'].replace('-','').upper()
order=['human','chimpanzee','bonobo','gorilla','orangutan','gibbon','rhesus_macaque','crab-eating_macaque','vervet','mouse_lemur']
with open('scn5a_promoter_primates.fa','w') as fh:
    for n in order:
        if n in seqs:
            fh.write(f'>{n}\n')
            s=seqs[n]
            for i in range(0,len(s),70): fh.write(s[i:i+70]+'\n')
print('species:',len(seqs),'| human len',len(seqs['human']))
for n in order:
    if n in seqs: print(' ',n,len(seqs[n]))
