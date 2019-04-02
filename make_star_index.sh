#!/bin/bash
#SBATCH --partition=general
#SBATCH --job-name=make_star_index
#SBATCH --nodes=1
#SBATCH --mem=32000
#SBATCH --cpus=4
#SBATCH --time=24:00:00
#SBATCH --mail-type=ALL

module load STAR

mkdir star_indices_overhang100

STAR --runThreadN 4 --runMode genomeGenerate \
--genomeDir /gpfs/ycga/project/ysm/lek/shared/resources/GRCh38/star_indices_overhang100/ \
--genomeFastaFiles /gpfs/ycga/project/ysm/lek/shared/resources/GRCh38/sequence/GRCh38_r77.all.fa \
--sjdbGTFfile /gpfs/ycga/project/ysm/lek/shared/resources/GRCh38/annotation/Homo_sapiens.GRCh38.77.gtf --sjdbOverhang 100
