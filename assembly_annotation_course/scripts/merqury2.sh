#!/usr/bin/env bash

#SBATCH --time=12:00:00
#SBATCH --mem=48G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=merqury
#SBATCH --partition=pall
#SBATCH --mail-user=carla.andrade@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/candrade/assembly_annotation_course/10_mer_kmercount_%j.o
#SBATCH --error=/data/users/candrade/assembly_annotation_course/10_mer_kmercount_%j.e

# meryl is included in canu
module load UHTS/Assembler/canu/2.1.1;

READS_DIR=/data/users/candrade/assembly_annotation_course/participant_4/Illumina
OUTPUT_DIR=/data/users/candrade/assembly_annotation_course/evaluation/merqury2

mkdir -p "$OUTPUT_DIR"

cd ${OUTPUT_DIR}

# When not sure which k-mer size to use, run best_k.sh with genome_size in num. of bases first

# build kmer database from paired-end short reads with Meryl
meryl k=19 count "$READS_DIR"/*.fastq.gz output "$OUTPUT_DIR"/kmer_dbs.meryl

meryl k=19 count "$READS_DIR"/*1.fastq.gz outputC/read_1.meryl
meryl k=19 count "$READS_DIR"/*2.fastq.gz output $SCRATCH/read_2.meryl
meryl union-sum output ${OUTPUT_DIR}/genome.meryl $SCRATCH/read*.meryl



WORK_DIR=/data/users/candrade/assembly_annotation_course
OUTPUT_DIR=${WORK_DIR}/evaluation/merqury2
MERYL_DIR=${OUTPUT_DIR}/genome.meryl

# canu ori
FILE=canu_ori
ASSEMBLY=/data/users/candrade/assembly_annotation_course/polish_assembly/canu/canu_polished.fasta

mkdir -p ${OUTPUT_DIR}/${FILE}
chmod a+rwx ${ASSEMBLY} # => does not seem to make a difference, merqury still does not create the plots
cd ${OUTPUT_DIR}/${FILE}

apptainer exec \
--bind "${WORK_DIR}" \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
merqury.sh "${MERYL_DIR}" "${ASSEMBLY}" "${FILE}"



# Flye ori
FILE=flye_ori
ASSEMBLY=/data/users/candrade/assembly_annotation_course/polish_assembly/flye/flye_polished.fasta


mkdir -p ${OUTPUT_DIR}/${FILE}
chmod a+rwx ${ASSEMBLY} # => does not seem to make a difference, merqury still does not create the plots
cd ${OUTPUT_DIR}/${FILE}

apptainer exec \
--bind "${WORK_DIR}" \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
merqury.sh "${MERYL_DIR}" "${ASSEMBLY}" "${FILE}"



