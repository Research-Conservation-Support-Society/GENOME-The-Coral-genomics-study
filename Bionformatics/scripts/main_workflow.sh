#!/bin/bash

# ================================
#  SIMPLE GENOME-SKIMMING PIPELINE
#  Author: Asatsa
#  Purpose: Process coral samples
#  Steps: QC → Assembly → Organelle → UCEs → Phylogeny → SNPs → Markers
# ================================

# Set number of threads for all tools
THREADS=16

echo "Starting genome-skimming pipeline..."

# Loop through each sample (fastq files must be named: sample_R1.fastq.gz / sample_R2.fastq.gz)
for R1 in raw_reads/*_R1.fastq.gz; do
    SAMPLE=$(basename $R1 _R1.fastq.gz)
    R2=raw_reads/${SAMPLE}_R2.fastq.gz

    echo "--------------------------------------"
    echo "Processing sample: $SAMPLE"
    echo "--------------------------------------"

    # =============== 1. QC WITH FASTP ======================
    echo "[1/8] Cleaning reads with fastp..."

    fastp \
        -i $R1 -I $R2 \
        -o clean_reads/${SAMPLE}_clean_R1.fastq.gz \
        -O clean_reads/${SAMPLE}_clean_R2.fastq.gz \
        --detect_adapter_for_pe \
        --trim_poly_g \
        --trim_poly_x \
        --cut_front --cut_tail \
        --html logs/${SAMPLE}_fastp.html \
        --thread $THREADS

    CLEAN_R1=clean_reads/${SAMPLE}_clean_R1.fastq.gz
    CLEAN_R2=clean_reads/${SAMPLE}_clean_R2.fastq.gz

    # =============== 2. DE NOVO ASSEMBLY (SPADES) ============
    echo "[2/8] Running SPAdes assembly..."

    spades.py \
        -1 $CLEAN_R1 -2 $CLEAN_R2 \
        -o assemblies/${SAMPLE}/ \
        --careful -t $THREADS

    ASSEMBLY=assemblies/${SAMPLE}/contigs.fasta

    # =============== 3. ORGANELLE ASSEMBLY ===================
    echo "[3/8] Recovering mitochondrial + rDNA with GetOrganelle..."

    get_organelle_from_reads.py \
        -1 $CLEAN_R1 -2 $CLEAN_R2 \
        -o organelle/${SAMPLE} \
        -t $THREADS \
        -F embplant_mt

    # =============== 4. UCE + EXON EXTRACTION =================
    echo "[4/8] Extracting UCE loci using PHYLUCE..."

    phyluce_probe_run_multiple_lastzs_sqlite \
        --db uce.db \
        --output uce/${SAMPLE}_match/ \
        --probes anthozoa_UCE_probes.fasta \
        --scaffold $ASSEMBLY

    phyluce_probe_slice_sequence_from_genomes \
        --lastz uce/${SAMPLE}_match/ \
        --output uce/${SAMPLE}_extracted/

    # =============== 5. ALIGN UCE LOCI =======================
    echo "[5/8] Aligning UCE loci (MAFFT via PHYLUCE)..."

    phyluce_align_seqcap_align \
        --input uce/${SAMPLE}_extracted/ \
        --output alignments/${SAMPLE}_aligned/ \
        --aligner mafft \
        --taxa 50 \
        --trim

done

# =============== 6. PHYLOGENETIC TREE ========================
echo "[6/8] Building phylogenetic trees (IQ-TREE)..."

iqtree2 -s supermatrix.fasta -p partitions.txt -B 1000 -T $THREADS

# =============== 7. SNP CALLING (BWA + BCFTools + GATK) ======
echo "[7/8] Mapping reads and calling SNPs..."

# You must create reference.fasta beforehand
bwa index reference.fasta

for R1 in clean_reads/*_clean_R1.fastq.gz; do
    SAMPLE=$(basename $R1 _clean_R1.fastq.gz)
    R2=clean_reads/${SAMPLE}_clean_R2.fastq.gz

    bwa mem reference.fasta $R1 $R2 \
        | samtools sort -o snps/${SAMPLE}.bam

    samtools index snps/${SAMPLE}.bam
done

# Call SNPs (simple bcftools pipeline)
bcftools mpileup -Ou -f reference.fasta snps/*.bam \
    | bcftools call -mv -Oz -o snps/all_samples.vcf.gz

# =============== 8. DIAGNOSTIC MARKER DISCOVERY =============
echo "[8/8] Finding fixed SNPs for species-specific markers..."

python scripts/find_fixed_snps.py snps/all_samples.vcf.gz > markers/candidate_snps.txt

python scripts/extract_windows.py assemblies/ markers/candidate_snps.txt \
    > markers/candidate_regions.fasta

echo "Pipeline completed successfully!"
