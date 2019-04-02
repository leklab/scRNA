#!/bin/bash
#SBATCH --partition=general
#SBATCH --job-name=salmon_index
#SBATCH --nodes=1
#SBATCH --mem=64000
#SBATCH --cpus=4
#SBATCH --time=24:00:00
#SBATCH --mail-type=ALL

module load Salmon

salmon index -t gencode.v29.pc_transcripts.fa -i pc_transcripts_index -k 31
