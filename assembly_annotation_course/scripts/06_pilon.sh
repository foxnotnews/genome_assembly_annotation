#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=48G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=polish
#SBATCH --mail-user=carla.andrade@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/candrade/assembly_annotation_course/polish_assembly/output_polish_%j.o
#SBATCH --error=/data/users/candrade/assembly_annotation_course/polish_assembly/error_polish_%j.e
#SBATCH --partition=pall

# Get the module for java and samtools for sorting and indexing (try one of the two)
module add Development/java/17.0.6;
module add Development/java/1.8.0_242;
module add UHTS/Analysis/samtools/1.10;


#canu or flye
INPUT_TYPE=$1
# canu: pacbio_canu_assembly.contigs.fasta    flye:  assembly.fasta
FILE_NAME=$2
#Variables for directory pathways
INPUT_DIR=/data/users/candrade/assembly_annotation_course/assembly/${INPUT_TYPE}
OUTPUT_DIR=/data/users/candrade/assembly_annotation_course/polish_assembly/${INPUT_TYPE}

#index and sort
samtools sort --threads 4 ${OUTPUT_DIR}/assembly_${INPUT_TYPE}.bam -o ${OUTPUT_DIR}/assembly_${INPUT_TYPE}.sorted.bam 
samtools index  ${OUTPUT_DIR}/assembly_${INPUT_TYPE}.sorted.bam 

java -Xmx45g -jar /mnt/software/UHTS/Analysis/pilon/1.22/bin/pilon-1.22.jar \
 --genome ${INPUT_DIR}/${FILE_NAME} --bam ${OUTPUT_DIR}/assembly_${INPUT_TYPE}.sorted.bam  --output /${OUTPUT_DIR}/${INPUT_TYPE}_polished --threads 4

