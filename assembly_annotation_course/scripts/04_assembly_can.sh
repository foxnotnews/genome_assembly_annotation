#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=4G
#SBATCH --cpus-per-task=1
#SBATCH --mail-user=carla.andrade@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/candrade/assembly_annotation_course/output_canu_%j.o
#SBATCH --error=/data/users/candrade/assembly_annotation_course/error_canu_%j.e

module load UHTS/Assembler/canu/2.1.1

ASSEMBLY_DIR=/data/users/candrade/assembly_annotation_course/assembly/canu
INPUT_DIR=/data/users/candrade/assembly_annotation_course/participant_4

canu -d ${ASSEMBLY_DIR} -p pacbio_canu_assembly gridOptions="--mail-user carla.andrade@students.unibe.ch" \
    genomeSize=126m maxMemory=64 maxThreads=16  -pacbio ${INPUT_DIR}/pacbio/*.fastq.gz  \
    gridEngineResourceOption="--cpus-per-task=THREADS --mem-per-cpu=MEMORY --time=2-00:00:00"