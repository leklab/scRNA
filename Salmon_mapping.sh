#!/bin/bash
#SBATCH --partition=general
#SBATCH --job-name=salmon_mapping
#SBATCH --nodes=1
#SBATCH --mem=64000
#SBATCH --cpus=8
#SBATCH --time=24:00:00
#SBATCH --mail-type=ALL

#uses Salmon for transcript quantification
#mapping-based mode (skips STAR)

module load Salmon

transcript_index=/gpfs/ycga/project/ysm/lek/shared/resources/GRCh38/transcripts/salmon_index
star_input=/home/ec753/project/scRNAseq/star_input_files.csv
  #format: sample_id \t path/to/fastq1 \t path/to/fastq2

while IFS= read -r line
do
  sample='\t' read -r -a array <<< "$line"
  sample_id="${array[0]}"
  fastq1="/home/ec753/project/scRNAseq/HCA/ischaemic_sensitivity/fastqs/${array[1]}"
  fastq2="/home/ec753/project/scRNAseq/HCA/ischaemic_sensitivity/fastqs/${array[2]}"
  echo $sample_id
  echo $fastq1
  echo $fastq2

  #libtypes, append chars for multiple types
   #A: auto-infer
   #reletive orientation (paired-end)
     #I: inward
     #O: outward
     #M: matching
   #strandedness
     #U: unstranded
     #S: stranded
       #F: read 1 comes from forward strand
       #R: read 1 comes from reverse strand 		
  libtype='A'

salmon quant -i $transcript_index -1 $fastq1 -2 $fastq2 -p 8 -l A \
	-o salmon_mapping_out/$sample_id
  echo
done < "$star_input"

echo done
