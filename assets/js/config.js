/* =====================================================================
   Settings for the SCN5A promoter-haplotype project workbench
   (built from the Bioinformatics workbench of the Chronomic Medicine Group).
   Edit and re-upload this file; nothing else needs to change.
   Never put an API key in this file: anyone could copy it from a public site.
   ===================================================================== */
window.MG_CONFIG = {
  courseTitle: 'One promoter, many genomes',
  courseSubtitle: 'The SCN5A haplotype project · Chronomic Medicine Group · 2026',

  /* The prefix of what the page keeps in the browser (files, notebooks, settings). It is unique to this
     project so that it does not share saved work with the Bioinformatics workbench or the other student
     projects, although all are on comparativechrono.github.io. */
  storePrefix: 'chrono26c',
  hostname: 'workbench',

  /* Python in the browser (Pyodide). */
  pyodideBase: 'https://cdn.jsdelivr.net/pyodide/v0.29.5/full/',
  pythonPreload: ['numpy', 'pandas', 'matplotlib'],

  /* The cards of the Databases tab (their ids in assets/js/apis.js). This project uses Ensembl (gene, sequence,
     VEP, region, comparative genomics), NCBI, UCSC, UniProt (the Nav1.5 protein) and Europe PMC. */
  databases: ['ensembl', 'ncbi', 'ucsc', 'uniprot', 'alphafold', 'interpro', 'blast', 'europepmc'],

  /* R in the browser (webR). */
  webrBase: 'https://webr.r-wasm.org/v0.6.0/',
  rRepos: ['https://repo.r-wasm.org', 'https://bioc-release.r-universe.dev', 'https://cran.r-universe.dev'],
  rLocalRepo: 'assets/vendor/r-packages',

  /* The WebAssembly bioinformatics programs of the terminal. */
  biowasmBase: 'assets/vendor/biowasm',
  /* The programs that run in a worker of their own: in this project only PLINK 2. */
  threadsBase: 'assets/vendor/genomics-wasm/',

  /* AI assistant. Each user enters their own API key; it is kept only in the browser tab. */
  liveProvider: 'gemini',
  geminiModel: 'gemini-3.8-flash',
  geminiFallbackModels: ['gemini-3.7-flash', 'gemini-3.6-flash', 'gemini-3.5-flash', 'gemini-3.5-flash-lite', 'gemini-3.1-flash-lite'],
  aiWaitSeconds: 60,
  anthropicModel: 'claude-sonnet-5-5',
  agentCommandSeconds: 150,

  storageWarnMB: 1500
};
