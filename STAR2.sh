#!/bin/bash
#SBATCH --partition=general
#SBATCH --job-name=sc_star
#SBATCH --nodes=1
#SBATCH --mem=64000
#SBATCH --cpus=16
#SBATCH --time=32:00:00
#SBATCH --mail-type=ALL

module load STAR

mkdir star_out
cd star_out

sample_id="scTEST"
star_index="/gpfs/ycga/project/ysm/lek/shared/tools/gtex_pipeline/required_files/STAR_genome_GRCh38_noALT_noHLA_noDecoy_ERCC_v26_oh100/"

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
  mkdir $sample_id
  cd $sample_id
  
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
done < "$star_input"

echo done
