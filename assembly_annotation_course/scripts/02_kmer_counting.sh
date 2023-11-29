#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8000M
#SBATCH --time=02:00:00
#SBATCH --job-name=kmer
#SBATCH --mail-user=carla.andrade@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/candrade/assembly_annotation_course/output_kmer_jellyfish_%j.o
#SBATCH --error=/data/users/candrade/assembly_annotation_course/error_kmer_jellyfish_%j.e
#SBATCH --partition=pall

#load module
module load UHTS/Analysis/jellyfish/2.3.0 

#variables
KMER_DIR=/data/users/candrade/assembly_annotation_course/kmer
INPUT_DIR=/data/users/candrade/assembly_annotation_course/participant_4

#insert Illumina OR  pacbio OR  RNAseq
type_file=$1

jellyfish count -C -m 19 -s 5G -t 4 -o  ${KMER_DIR}/${type_file}.jf \
<(zcat ${INPUT_DIR}/${type_file}/*.fastq.gz) 



jellyfish histo -t 4 ${KMER_DIR}/${type_file}.jf > ${KMER_DIR}/${type_file}.histo