#!/bin/bash
#SBATCH --partition=general
#SBATCH --job-name=scRNA_pipe
#SBATCH --nodes=1
#SBATCH --mem=64000
#SBATCH --cpus=4
#SBATCH --time=24:00:00
#SBATCH --mail-type=ALL

sample_id="scTEST"
star_index="/gpfs/ycga/project/ysm/lek/shared/tools/gtex_pipeline/required_files/STAR_genome_GRCh38_noALT_noHLA_noDecoy_ERCC_v26_oh100/"
fastq1="/home/ec753/project/scRNAseq/HCA/ischaemic_sensitivity/fastqs/HCATisStabAug177078016_S1_L001_R1_001.fastq.gz"
fastq2="/home/ec753/project/scRNAseq/HCA/ischaemic_sensitivity/fastqs/HCATisStabAug177078016_S1_L001_R2_001.fastq.gz"

#Read Quality assessment
#fastqc
module load FastQC
mkdir fastqc
fastqc $fastq1_file --outdir=fastqc/
fastqc $fastq2_file --outdir=fastqc/

#trim reads
#cutadept
module load cutadapt
#check if this is needed (maybe the adapters are already cut off)

#mapping: STAR
mkdir star_out
cd star_out
STAR --runMode alignReads \
     --runThreadN 16 \
     --genomeDir ${star_index} \
     --twopassMode Basic \
     --outFilterMultimapNmax 20 \
     --alignSJoverhangMin 8 \
     --alignSJDBoverhangMin 1 \
     --outFilterMismatchNmax 999 \
     --outFilterMismatchNoverLmax 0.1 \
     --alignIntronMin 20 \
     --alignIntronMax 1000000 \
     --alignMatesGapMax 1000000 \
     --outFilterType BySJout \
     --outFilterScoreMinOverLread 0.33 \
     --outFilterMatchNminOverLread 0.33 \
     --limitSjdbInsertNsj 1200000 \
     --readFilesIn ${fastq1} ${fastq2} \
     --readFilesCommand zcat \
     --outFileNamePrefix ${sample_id}. \
     --outSAMstrandField intronMotif \
     --outFilterIntronMotifs None \
     --alignSoftClipAtReferenceEnds Yes \
     --quantMode TranscriptomeSAM GeneCounts \
     --outSAMtype BAM Unsorted SortedByCoordinate \
     --outSAMunmapped Within \
     --genomeLoad NoSharedMemory \
     --chimSegmentMin 15 \
     --chimJunctionOverhangMin 15 \
     --chimOutType WithinBAM SoftClip \
     --chimMainSegmentMultNmax 1 \
     --outSAMattributes NH HI AS nM NM ch \
     --outSAMattrRGline ID:rg1 SM:sm1
cd ..

#Run RNA-seQC (jar in shared folder)

java -jar /gpfs/ycga/project/ysm/lek/shared/tools/jars/RNA-SeQC_v1.1.8.jar \
-o rna_seqc_out \
-r /gpfs/ycga/project/ysm/lek/shared/resources/hg38/Homo_sapiens_assembly38.fasta \
-s rnaseqc_sample_file.tsv \
-t /gpfs/ycga/project/ysm/lek/shared/resources/GRCh38/annotation/gencode.v7.annotation_goodContig.gtf

#transcript quantification
#salmon

#divide transcripts into intronic, exonic, intergenic



#filter only high quality exonic reads

#normalize transcript counts (DESeq)

#remove latent variable variation (scLVM)

#create gene expression matrix



