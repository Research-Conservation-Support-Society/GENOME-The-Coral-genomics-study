**Genome-Skimming Pipeline for Coral Taxonomy & Marker Discovery**

****A complete workflow for species delimitation, phylogenomics, and diagnostic SNP identification in corals****

**Overview**

This repository contains the complete analysis pipeline.
The workflow uses genome skimming to extract:
- whole mitochondrial genomes
- nuclear ribosomal operons
- ultra-conserved elements (UCEs)
- single-copy exons
- SNP datasets
- species-diagnostic markers for PCR assay development

This pipeline will be optimized for:
- Low-input DNA
- Poorly preserved samples
- Multiple coral genera
- Conservation-driven taxonomy and marker development

<div align="center">
<!-- <!-- Save as genomeskim_workflow.svg or paste directly into README.md -->
<svg xmlns="http://www.w3.org/2000/svg" width="1200" height="720" viewBox="0 0 1200 720" role="img" aria-label="Genome skimming workflow">
  <style>
    .bg { fill: #ffffff; }
    .box { fill: #FFFFFF; stroke: #2b2b2b; stroke-width: 1.2; rx: 8; ry: 8; }
    .box-title { font: 600 14px/1 "Helvetica Neue", Arial, sans-serif; fill: #111111; }
    .box-sub { font: 400 12px/1 "Helvetica Neue", Arial, sans-serif; fill: #333333; }
    .arrow { stroke: #888888; stroke-width: 1.6; fill: none; marker-end: url(#arrowhead); }
    .small { font: 400 11px/1 "Helvetica Neue", Arial, sans-serif; fill: #555555; }
  </style>

  <defs>
    <marker id="arrowhead" markerWidth="10" markerHeight="8" refX="9" refY="4" orient="auto">
      <path d="M0,0 L10,4 L0,8 z" fill="#888888" />
    </marker>
  </defs>

  <rect class="bg" x="0" y="0" width="1200" height="720" />

  <!-- Column 1 -->
  <g transform="translate(60,40)">
    <rect class="box" x="0" y="0" width="220" height="70"></rect>
    <text class="box-title" x="16" y="25">Raw Illumina Reads</text>
    <text class="box-sub" x="16" y="46">Paired-end FASTQ (PE150)</text>
  </g>

  <g transform="translate(60,140)">
    <rect class="box" x="0" y="0" width="220" height="70"></rect>
    <text class="box-title" x="16" y="25">Quality Control</text>
    <text class="box-sub" x="16" y="46">fastp — adapters, poly-G/A, trim, QC</text>
  </g>

  <!-- Column 2 -->
  <g transform="translate(320,90)">
    <rect class="box" x="0" y="0" width="240" height="70"></rect>
    <text class="box-title" x="16" y="25">De-novo Assembly</text>
    <text class="box-sub" x="16" y="46">SPAdes — contigs (low-coverage)</text>
  </g>

  <g transform="translate(320,190)">
    <rect class="box" x="0" y="0" width="240" height="70"></rect>
    <text class="box-title" x="16" y="25">Organelle Recovery</text>
    <text class="box-sub" x="16" y="46">GetOrganelle — mitogenome & rDNA</text>
  </g>

  <!-- Column 3 -->
  <g transform="translate(660,45)">
    <rect class="box" x="0" y="0" width="260" height="70"></rect>
    <text class="box-title" x="16" y="25">Nuclear Marker Recovery (opt.)</text>
    <text class="box-sub" x="16" y="46">PHYLUCE — UCEs & exons (probe match)</text>
  </g>

  <g transform="translate(660,145)">
    <rect class="box" x="0" y="0" width="260" height="70"></rect>
    <text class="box-title" x="16" y="25">Alignment & Trimming</text>
    <text class="box-sub" x="16" y="46">MAFFT + Gblocks / trim</text>
  </g>

  <!-- Column 4 -->
  <g transform="translate(1000,95)">
    <rect class="box" x="0" y="0" width="200" height="70"></rect>
    <text class="box-title" x="16" y="25">Phylogenetics</text>
    <text class="box-sub" x="16" y="46">IQ-TREE (ML) & ASTRAL (species tree)</text>
  </g>

  <!-- Mapping & SNPs (lower row) -->
  <g transform="translate(320,330)">
    <rect class="box" x="0" y="0" width="240" height="70"></rect>
    <text class="box-title" x="16" y="25">Read Mapping</text>
    <text class="box-sub" x="16" y="46">BWA / Bowtie2 → BAMs</text>
  </g>

  <g transform="translate(660,330)">
    <rect class="box" x="0" y="0" width="260" height="70"></rect>
    <text class="box-title" x="16" y="25">Variant Calling</text>
    <text class="box-sub" x="16" y="46">bcftools / GATK → VCF</text>
  </g>

  <g transform="translate(1000,330)">
    <rect class="box" x="0" y="0" width="200" height="70"></rect>
    <text class="box-title" x="16" y="25">Population Analyses</text>
    <text class="box-sub" x="16" y="46">PCA, DAPC, ADMIXTURE, MSC</text>
  </g>

  <!-- Marker & PCR -->
  <g transform="translate(660,470)">
    <rect class="box" x="0" y="0" width="260" height="70"></rect>
    <text class="box-title" x="16" y="25">Marker Discovery</text>
    <text class="box-sub" x="16" y="46">Fixed SNPs, Fst, resilience candidates</text>
  </g>

  <g transform="translate(1000,470)">
    <rect class="box" x="0" y="0" width="200" height="70"></rect>
    <text class="box-title" x="16" y="25">PCR Assay Design</text>
    <text class="box-sub" x="16" y="46">Primer3 → multiplex PCR / qPCR</text>
  </g>

  <g transform="translate(660,590)">
    <rect class="box" x="0" y="0" width="540" height="70"></rect>
    <text class="box-title" x="16" y="25">Field Validation & Application</text>
    <text class="box-sub" x="16" y="46">Nursery & wild tests → WIO barcode DB → restoration tools</text>
  </g>

  <!-- arrows (top flow) -->
  <path class="arrow" d="M 280 75 L 320 105" />
  <path class="arrow" d="M 560 105 L 660 105" />
  <path class="arrow" d="M 600 215 L 660 215" />
  <path class="arrow" d="M 920 130 L 1000 130" />

  <!-- arrows to mapping & SNPs -->
  <path class="arrow" d="M 200 175 L 320 215" />
  <path class="arrow" d="M 560 375 L 660 365" />
  <path class="arrow" d="M 580 160 L 660 365" />

  <!-- downward arrows top -> lower -->
  <path class="arrow" d="M 460 160 L 460 330" />
  <path class="arrow" d="M 820 215 L 820 330" />

  <!-- arrows lower chain -->
  <path class="arrow" d="M 560 365 L 640 365" />
  <path class="arrow" d="M 920 365 L 1000 365" />
  <path class="arrow" d="M 920 400 L 920 470" />
  <path class="arrow" d="M 820 400 L 900 470" />

  <!-- arrow from PCR to field -->
  <path class="arrow" d="M 1100 510 L 1100 560" />

  <!-- small legend -->
  <g transform="translate(36,620)">
    <text class="small">Notes: Target ~8–12M PE150 reads/sample; genome-skimming yields mitogenomes + rDNA quickly; PHYLUCE/UCEs .</text>
  </g>
</svg>
 -->
</div>





The analysis will be done in an isolated conda envrionment. To create a copy of the environment use the [environment.yaml](https://coralgenomics.recourse.co.ke/) file.

Run the following
```
conda env create -f environment.yml
```

To activate the environment run the
```
conda activate coral-genomics

```

The main script is [main_workflow.sh](https://coralgenomics.recourse.co.ke/)

**Tools Used**
All tools run inside a Conda environment:
- fastp — Clean raw reads (remove adapters, poly-G/A tails, low-quality bases)
- SPAdes — de novo assemblyper sample (SPAdes) to get contigs.
- GetOrganelle — Recover organellar sequences (mitogenome) and full ribosomal operons (GetOrganelle) — primary barcode outputs.
- PHYLUCE — probe-matching to recover nuclear UCE/exon loci
- IQ-TREE2 — phylogenetic inference Build alignments of organelles and nuclear loci for phylogenetic species delimitation (IQ-TREE + ASTRAL using nuclear loci)
- ASTRAL — species tree
- bwa, samtools, bcftools — Map reads back to assembled contigs/reference to call SNP
- bowtie2, gatk — second SNP calling method (ANGSD or genotype likelihood approaches if coverage is variable — they handle uncertainty better than hard-called genotypes)
+ Population structure / species delimitation analyses (PCA, DAPC, ADMIXTURE, MSC) to delimit species and identify candidate resilience-associated SNPs from phenotype-matched samples.
- primer3 — primer design
- Select diagnostic SNPs / variable regions, design primers, test in lab (Sanger/qPCR/LAMP)



**Summary of What the Pipeline Produces**
1. Genome assemblies
2. De novo assemblies with SPAdes
3. Complete mitogenomes
4. Complete rDNA arrays
5. Nuclear markers
6. Hundreds–thousands of UCE loci
7. Single-copy exon data
8. Phylogenomic datasets
9. Locus alignments
10. Supermatrix and partitions
11. Maximum likelihood trees
12. Species tree (coalescent-based)
13. SNP datasets
14. VCF files
15. PCA-ready matrices
16. Species delimitation clusters
17. Performance-ready conservation tools
18. Lists of species-specific SNPs
