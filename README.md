# One promoter, many genomes – the SCN5A haplotype project

**A guided undergraduate research project of the Chronomic Medicine Group, in a workbench that runs in the
browser.** The student takes two long-studied variants in the promoter of the cardiac sodium-channel gene
*SCN5A* (rs41310749 and rs41310239), and works out what larger haplotype they belong to: she reads them in the
462 long-read haplotypes of the Human Pangenome Reference Consortium, extends the haplotype to a ~50 kb block
across the 2,504 genomes of the 1000 Genomes Project, scores the transcription-factor motifs the variants change
(including the clock's E-boxes), traces them through archaic humans and other primates, and tests the block in a
Brugada-syndrome GWAS and in gene-expression data. It needs no programming experience: the guide teaches the Linux
terminal, `samtools`/`bcftools`, `PLINK 2`, R and `kalign` as the project needs them.

The site is built from the [Bioinformatics workbench](https://github.com/comparativechrono/bioinformatics-workbench)
of the same group: the same notebooks (R and Python), terminal, Files tab, genome browser (igv.js), Databases tab,
3D viewer, IDEs and AI assistant – with the programs and tabs the project does not need left out, and a guide in
the left pane in place of the workbench's help (the help is still there, behind **Help**).

---

## Contents

1. [The project in brief](#the-project-in-brief)
2. [The guide](#the-guide)
3. [Put it online](#put-it-online)
4. [Before the student starts](#before-the-student-starts)
5. [Editing the guide](#editing-the-guide)
6. [The data](#the-data)
7. [How it was tested](#how-it-was-tested)
8. [What is different from the Bioinformatics workbench](#what-is-different-from-the-bioinformatics-workbench)
9. [Files](#files)
10. [Credits and licences](#credits-and-licences)

---

## The project in brief

**Question.** Two SNPs in the *SCN5A* promoter, rs41310749 and rs41310239, were reported by Park et al. (2012) to
travel together and to modify arrhythmia severity, and our group has studied them for a link to the circadian
control of the heart. But the *larger haplotype* they are part of – how far it reaches, what regulatory elements
and motifs it contains, how it varies between populations, where it came from, and what it does – has never been
described. Long-read pangenomes and biobanks can now answer this.

**Plan.** Eleven stages, about one a week over a year. Stages 1–7 are the core; 8, 9 and 10 each add a separate
line of evidence; each stage ends with "going further" ideas, so the student can make the project her own.

| Stage | Title | The student learns |
| --- | --- | --- |
| 0 | Start here; the science; the data; reading; glossary | the clock, the heart, *SCN5A* and the two variants; how to keep a logbook |
| 1 | The locus and the genome | the terminal; FASTA, `.fai`, GFF3, BED; strand and coordinates; `samtools faidx`; the genome browser; a REST API |
| 2 | The promoter and its motifs | cutting out sequence; GC content and CpG; regular expressions; finding E-boxes with `grep` |
| 3 | From a pangenome to haplotypes | what a pangenome is; VCF, genotypes and phasing; `bcftools annotate`/`norm`; multiallelic records |
| 4 | The two-SNP haplotype | the first R notebook; data frames and matrices; allele frequencies; a cross-tabulation |
| 5 | Linkage disequilibrium and the block | r² and D′; the unrelated panel; correlating every variant with a haplotype; defining the ~50 kb block |
| 6 | The block across populations | haplotype frequencies in five groups; the African exception; why LD is population-specific |
| 7 | What is in the block? | VEP consequences and regulation; enhancers; the *SCN5A*–*SCN10A* neighbourhood |
| 8 | Do the variants change a motif? | PWMs from JASPAR; log-odds scoring; reference vs alternate; the clock-motif loss and RXR gain |
| 9 | Evolution | ancestral alleles; `kalign`; Neanderthals and Denisovans; conservation of the sites and the E-boxes |
| 10 | The haplotype in the biobank | GWAS summary statistics; a Brugada association; GTEx eQTLs; assembling a mechanism and its limits |
| 11 | Write it up | figures, methods with versions, results with uncertainty, discussion; a reproducible `run_all` |

As far as we know the analysis is new: the extent and population structure of this haplotype in a long-read
pangenome, the motifs its variants change, its absence from archaic humans, and its behaviour in a Brugada GWAS and
in expression data. **A supervisor's answer key is not in this repository** (it is public, and the student would
find it): the results that the guide's *Check* boxes give are there to confirm each step, and the interpretation is
left to the student. The supervisor's full worked analysis lives in the private-to-the-group companion repository
[`SCN5A-analysis`](https://github.com/comparativechrono/SCN5A-analysis).

## The guide

The left pane has a row of tabs: **Start**, the stages **1–11**, and **Help** (the manual of the tools). Each
stage page has: what the student will learn; the science where needed; numbered steps with grey code boxes
(**Run in the terminal** or **Add to notebook**); green **Check** boxes with the numbers she should get; *Your
turn* tasks with hidden hints; *Think* questions; a logbook box; *going further*; and a checklist, whose ticks are
kept in the browser and fill in the stage's tab. Each stage with R has its own notebook
(`~/notebooks/stageNN-….ipynb`, made by a button), and the student keeps a logbook, `~/project/logbook.md`.

Early stages give the code and explain it line by line; later ones ask her to write more of it herself. Her results
go into `~/project/results` and `~/project/figures`, and stage 11 turns the work into scripts that rebuild
everything.

## Put it online

1. In this repository on GitHub: *Settings → Pages → Build and deployment*: Source **Deploy from a branch**,
   branch **main**, folder **/ (root)**. Save.
2. After a minute the site is at **https://comparativechrono.github.io/chronomics-project-26-3/**. The first time
   a browser opens it, the page loads once more by itself: it installs a small service worker (`isolation-sw.js`)
   that lets PLINK 2 use threads.

The repository must be public for GitHub Pages on a free plan. To try it on your own computer: `python3 serve.py
8000`, then open `http://localhost:8000` (opening `index.html` as a file does not work).

## Before the student starts

- **Computer.** A laptop or desktop with a current Chrome, Edge, Firefox or Safari; 8 GB of memory is comfortable.
- **Network.** Besides this site, the browser must reach `webr.r-wasm.org`, `repo.r-wasm.org` and
  `cran.r-universe.dev` (R and its packages), `cdn.jsdelivr.net` (only if she opens a Python notebook), and the
  services the guide uses: `rest.ensembl.org`, `www.ebi.ac.uk`, `eutils.ncbi.nlm.nih.gov`, `api.genome.ucsc.edu`
  and `gtexportal.org`.
- **Her files live in her browser** – not on a server: the same computer and browser each time, and **My files →
  Download all my files** once a week (the guide says so). The site keeps its files apart from the other projects
  (`storePrefix: 'chrono26c'` in `assets/js/config.js`).
- **The AI assistant** (optional) needs a key of her own (Google Gemini has a free tier); the guide tells her to
  check what it says and to declare its use. Decide whether you want her to use it.
- **Public data only.** All the data are public; the human data are reference panels and summary numbers, not
  patients. The guide tells her never to put personal or patient data into the workbench or an AI tool.

## Editing the guide

The page is built from `build/`. After any change there, run:

```bash
python3 build/make_page.py        # writes index.html; warns about links to pages that do not exist
```

- **Guide pages**: `build/help/00-home.html` (Start), `00a-science.html`, `00b-data.html`, `00c-reading.html`,
  `00d-glossary.html` and the stages `00s01-locus.html` … `00s11-writeup.html`. The first line of each holds its
  id, title, group (`The project`), `stage: N`, and `tab: yes` for the page that a stage's tab opens. Checklists
  are `<ul class="checklist"><li data-check="unique-id">…</li></ul>`; the box classes are styled in
  `assets/css/guide.css`, and the tabs, checklists and stage-notebook buttons are run by `assets/js/guide.js`.
- **Tool help**: the other pages of `build/help/` (the workbench's, trimmed to this project).
- **Starter notebooks**: `python3 build/make_starters.py` writes `data/starter/*.ipynb`.
- **Settings**: `assets/js/config.js` (title, the cards of the Databases tab, R and AI settings).
- **The genome browser's default genome** is set in `assets/js/igv-panel.js` (the `examples` genome).
- **Programs**: after a change in `assets/vendor/`, run `python3 build/vendor_sums.py`.

## The data

`data/examples/scn5a/` (about 18 MB) holds everything the project needs, described in
[data/examples/scn5a/README.md](data/examples/scn5a/README.md) and in the guide (*The project data*): GRCh38 around
*SCN5A* with its genes and dbSNP; the HPRC release 2 pangenome (231 people) around the promoter and across the
locus; the 1000 Genomes high-coverage phased panel (3,202 people); the Brugada-syndrome GWAS of Barc et al. 2022 at
this locus; a GTEx eQTL table; the JASPAR transcription-factor matrices; the *SCN5A* promoter in ten primates; and
the Neanderthal/Denisovan alleles at the two sites. How each file was made is in [data-build/](data-build/).

## How it was tested

The analysis behind the guide was done first, independently, in Python and R (the companion repository
`SCN5A-analysis`). Every code box of the guide was then run in order with native `samtools`, `bcftools`, R and
`kalign` and gave the numbers of the *Check* boxes:

- the two variants' reference bases and the promoter's three canonical E-boxes (stages 1–2);
- the two-SNP haplotype in the HPRC pangenome (462 haplotypes; frequency 0.087, 40 carry both; stages 3–4);
- the LD block in the 1000 Genomes Europeans (r²=1.0 between the variants; ~20 variants at r²≥0.8 spanning
  chr3:38,631,501–38,682,101; stage 5) and the population frequencies (EUR 16.8%, SAS 18.9%, AMR 13.3%, EAS 6.8%,
  AFR 1.5%; stage 6);
- the enhancer overlap of rs41310749 (stage 7);
- the JASPAR motif scores (BMAL1 0.63→0.17 and RXR gain at rs41310749; stage 8);
- the ancestral alleles and primate/E-box conservation from the `kalign` alignment, and the archaic genotypes
  (stage 9);
- the Brugada association (rs41310749 P=1.1×10⁻¹⁰, OR≈1.33) and the *SCN5A* eQTL (derived allele lowers expression;
  stage 10).

The browser's `kalign` is an older build than the native one used here, so the primate alignment of the repetitive
patch around rs41310239 may differ slightly; the *Check* boxes describe the qualitative result. The AI assistant
was not tested with a real key: try it with a real key on your students' network before relying on it.

## What is different from the Bioinformatics workbench

- **Left out**: the Galaxy and Networks tabs (so no Cytoscape), and the programs for read QC, mapping, RNA-seq,
  single-cell, somatic and metagenomic analyses, peak calling, gene finding and HMMER; the example data that went
  with them; most Databases cards.
- **Kept**: samtools, bcftools, bgzip/tabix, seqtk, bedtools, gffread, jq, kalign, MUSCLE, FastTree, PLINK 2,
  minimap2, LASTZ, the GNU tools, Python and R; the genome browser, 3D viewer, IDEs and AI assistant.
- **Added**: the guide (stage tabs, checklists, stage notebooks, logbook), the project's data and its `data-build/`,
  the genome browser's default genome (the *SCN5A* slice of GRCh38, with the variants and the block), and *SCN5A*
  defaults in the Databases tab.

## Files

```
index.html             the page (built by build/make_page.py)
isolation-sw.js        the service worker that makes the page cross-origin isolated (keep it next to index.html)
assets/js/             the workbench; guide.js (the guide), project-tools.js (the programs of this project), config.js
assets/css/            styles; guide.css
assets/vendor/         bundled programs and libraries, with their licences (see THIRD_PARTY.md)
data/examples/scn5a/   the project's data, and its README.md
data/examples/         small example files kept from the workbench
data/starter/          the starter notebooks
data-build/            how the project's data were made
build/                 make_page.py, help/ (the guide and help pages), template.html, make_starters.py, vendor_sums.py
serve.py               a small local web server (optional)
THIRD_PARTY.md         the third-party software and data, their licences and sources
```

## Credits and licences

Built from the Bioinformatics workbench of the Chronomic Medicine Group. The bundled programs and libraries keep
their own licences – see [THIRD_PARTY.md](THIRD_PARTY.md), and keep `assets/vendor/licenses/` with the site. The
data are public (sources and terms in THIRD_PARTY.md and the data README); the studies and resources to cite are
listed in the guide (*The project data*). The key reference for the two variants is Park JK et al., *Heart Rhythm*
2012;9(7):1090–1096. The guide and the site's own code and text are by the Chronomic Medicine Group.
