#!/bin/bash
#SBATCH --partition=general
#SBATCH --job-name=rseqc
#SBATCH --nodes=1
#SBATCH --mem=64000
#SBATCH --cpus=4
#SBATCH --time=24:00:00
#SBATCH --mail-type=ALL

module load RSeQC

input_bam_files=/home/ec753/project/scRNAseq/RSeQC_input_bam_files.txt
genome_bed_file=/gpfs/ycga/project/ysm/lek/shared/resources/GRCh38/hg38_RefSeq.bed

mkdir rseqc_out
cd rseqc_out

while IFS= read -r line
do
  sample='\t' read -r -a array <<< "$line"
  sample_id="${array[0]}"
  bam_file="${array[1]}"
  echo $sample_id
  echo $bam_file

  split_bam.py -i $bam_file -r $genome_bed_file -o "${sample_id}_split_bam.txt"
  geneBody_coverage.py -i $bam_file -r $genome_bed_file -o "${sample_id}_geneBody_coverage.txt"  
  bam_stat.py -i $bam_file > "${sample_id}_bam_stat.txt"
done < "$input_bam_files"

echo done
