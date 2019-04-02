#!/bin/bash
#SBATCH --partition=general
#SBATCH --job-name=rna_seqc
#SBATCH --nodes=1
#SBATCH --mem=64000
#SBATCH --cpus=4
#SBATCH --time=24:00:00
#SBATCH --mail-type=ALL

java -jar /gpfs/ycga/project/ysm/lek/shared/tools/jars/RNA-SeQC_v1.1.8.jar \
-o rna_seqc_out \
-r /gpfs/ycga/project/ysm/lek/shared/resources/hg38/Homo_sapiens_assembly38.fasta \
-s rnaseqc_sample_file.tsv \
-t /gpfs/ycga/project/ysm/lek/shared/resources/GRCh38/annotation/gencode.v7.annotation_goodContig.gtf

