#!/bin/bash
#SBATCH --partition=general
#SBATCH --job-name=salmon
#SBATCH --nodes=1
#SBATCH --mem=64000
#SBATCH --cpus=4
#SBATCH --time=24:00:00
#SBATCH --mail-type=ALL

#uses Salmon for transcript quantification
#alignment-based mode

module load Salmon/0.8.2

#this transcript file does not work!!!!!!!!!!!!
transcript_file=/gpfs/ycga/project/ysm/lek/shared/resources/GRCh38/transcripts/gencode.v29.transcripts.fa
alignment_file=/home/ec753/project/scRNAseq/star_out/scTEST.Aligned.out.bam

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

salmon quant -t $transcript_file -l $libtype -a $alignment_file -o salmon_alignment_out

