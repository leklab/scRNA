#!/bin/bash
#SBATCH --partition=general
#SBATCH --job-name=fastqc
#SBATCH --nodes=1
#SBATCH --mem=16000
#SBATCH --cpus=4
#SBATCH --time=24:00:00
#SBATCH --mail-type=ALL

module load FastQC
mkdir fastqc_out

fastqs=/home/ec753/project/scRNAseq/HCA/ischaemic_sensitivity/fastqs/*.fastq.gz
for f in $fastqs
do
  echo $f
  fastqc $f --outdir=fastqc_out
done

echo done
