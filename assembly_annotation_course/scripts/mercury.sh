#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=48G
#SBATCH --cpus-per-task=12
#SBATCH --job-name=eval_merqury
#SBATCH --mail-user=carla.andrade@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/candrade/assembly_annotation_course/output_eval_merqury_%j.o
#SBATCH --error=/data/users/candrade/assembly_annotation_course/error_eval_merqury_%j.e
#SBATCH --partition=pall

# set path
genome=/data/users/candrade/assembly_annotation_course/evaluation/merqury/illumina
illumina=/data/users/candrade/assembly_annotation_course/participant_4/Illumina
PROJDIR=/data/users/candrade/assembly_annotation_course/
OUTPUT_DIR=/data/users/candrade/assembly_annotation_course/evaluation/merqury
POLISHED_DIR=/data/users/candrade/assembly_annotation_course/polish_assembly
# load module
module load UHTS/Assembler/canu/2.1.1


# build kmer dbs with meryl
meryl k=19 count ${illumina}/*.fastq.gz output "$OUTPUT_DIR"/kmer_dbs.meryl

meryl k=19 count ${illumina}/*1.fastq.gz outputC/read_1.meryl
meryl k=19 count ${illumina}/*2.fastq.gz output $SCRATCH/read_2.meryl
meryl union-sum output ${OUTPUT_DIR}/genome.meryl $SCRATCH/read*.meryl

MERYL_DIR=${OUTPUT_DIR}/genome.meryl


# # canu polished
mkdir ${PROJDIR}/evaluation/merqury/flye
cd ${PROJDIR}/evaluation/merqury/flye

apptainer exec \
--bind ${PROJDIR} \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
merqury.sh "${MERYL_DIR}" ${POLISHED_DIR}/flye/flye_polished.fasta flye_polished



# # canu polished
mkdir -p ${PROJDIR}/evaluation/merqury/canu
cd ${PROJDIR}/evaluation/merqury/canu

apptainer exec \
--bind ${PROJDIR} \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
merqury.sh ${MERYL_DIR} ${POLISHED_DIR}/canu/canu_polished.fasta canu_polished
