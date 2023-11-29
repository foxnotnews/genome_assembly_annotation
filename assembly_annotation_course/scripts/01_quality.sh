#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=01:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=carla.andrade@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/candrade/assembly_annotation_course/output_fastqc_%j.o
#SBATCH --error=/data/users/candrade/assembly_annotation_course/error_fastqc_%j.e
#SBATCH --partition=pall

#laod module for quality control fastQC and MutliQC
module load UHTS/Quality_control/fastqc/0.11.9;
module load UHTS/Analysis/MultiQC/1.8;

#variables
QUALITY_CONTROL_DIR=/data/users/candrade/assembly_annotation_course/Quality_control
INPUT_DIR=/data/users/candrade/assembly_annotation_course/participant_4

fastqc  ${INPUT_DIR}/Illumina/*.fastq.gz  ${INPUT_DIR}/pacbio/*.fastq.gz  ${INPUT_DIR}/RNAseq/*.fastq.gz \
 --t 4 \
 --outdir $QUALITY_CONTROL_DIR

cd $QUALITY_CONTROL_DIR

 multiqc .