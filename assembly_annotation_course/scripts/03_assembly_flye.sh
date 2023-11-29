#!/usr/bin/env bash

#SBATCH --time=1-10:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --partition=pall
#SBATCH --job-name=fly_assembly
#SBATCH --mail-user=carla.andrade@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/candrade/assembly_annotation_course/output_flye_%j.o
#SBATCH --error=/data/users/candrade/assembly_annotation_course/error_flye_%j.e

module load UHTS/Assembler/flye/2.8.3

ASSEMBLY_DIR=/data/users/candrade/assembly_annotation_course/assembly/flye
INPUT_DIR=/data/users/candrade/assembly_annotation_course/participant_4

flye --pacbio-raw  ${INPUT_DIR}/pacbio/ERR3415821.fastq.gz ${INPUT_DIR}/pacbio/ERR3415822.fastq.gz -t 16 -g 127m --out-dir ${ASSEMBLY_DIR}