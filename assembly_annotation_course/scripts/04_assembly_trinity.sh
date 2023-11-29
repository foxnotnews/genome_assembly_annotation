#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=48G
#SBATCH --cpus-per-task=12
#SBATCH --mail-user=carla.andrade@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/candrade/assembly_annotation_course/output_trinity_%j.o
#SBATCH --error=/data/users/candrade/assembly_annotation_course/error_trinity_%j.e

module load UHTS/Assembler/trinityrnaseq/2.5.1
ASSEMBLY_DIR=/data/users/candrade/assembly_annotation_course/assembly/trinity
INPUT_DIR=/data/users/candrade/assembly_annotation_course/participant_4/RNAseq


 Trinity --seqType fq --left ${INPUT_DIR}/ERR754075_1.fastq.gz --right ${INPUT_DIR}/ERR754075_1.fastq.gz  \
         --genome_guided_max_intron 10000 \
         --max_memory 40G --CPU 11