#!/bin/bash
#SBATCH --partition=general
#SBATCH --job-name=cellranger
#SBATCH --nodes=1
#SBATCH --mem=64000
#SBATCH --cpus=16
#SBATCH --time=32:00:00
#SBATCH --mail-type=ALL

module load cellranger

mkdir cellranger_out
cd cellranger_out

sample_id=test

path_to_fastqs=/home/ec753/project/scRNAseq/HCA/ischaemic_sensitivity/fastqs_unzip/
fastq1="${path_to_fastqs}HCATisStabAug177078016_S3_L001_R1_001.fastq"
fastq2="${path_to_fastqs}HCATisStabAug177078016_S3_L001_R2_001.fastq"
  
cellranger count --id=${sample_id} \
	--transcriptome=/gpfs/ycga/project/ysm/lek/shared/resources/GRCh38/cellranger/GRCh38 \
	--fastqs=${path_to_fastqs}

echo done

