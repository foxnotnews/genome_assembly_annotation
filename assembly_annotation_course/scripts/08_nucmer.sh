#!/usr/bin/env bash
#SBATCH --time=1:15:00
#SBATCH --mem=6G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=nucmer
#SBATCH --partition=pall
#SBATCH --mail-user=carla.andrade@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/candrade/assembly_annotation_course/12_output_nucmer_%j.o
#SBATCH --error=/data/users/candrade/assembly_annotation_course/12_error_nucmer_%j.e


#create directories
mkdir -p /data/users/candrade/assembly_annotation_course/comparison
OUTPUT_DIR=/data/users/candrade/assembly_annotation_course/comparison
mkdir -p ${OUTPUT_DIR}/flye ${OUTPUT_DIR}/canu
INPUT_FILE=/data/users/candrade/assembly_annotation_course/polish_assembly
# reference genome
REF_GEN=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa

# load the module
module add UHTS/Analysis/mummer/4.0.0beta1
export PATH=/software/bin:$PATH


# Go to the directory where the results should be stored.
#cd ${OUTPUT_DIR}/flye
## Run nucmer to map the assembled genomes (flye and canu) against the reference genome.
#nucmer -b 1000 -c 1000 -p flye  ${REF_GEN} ${INPUT_FILE}/flye/flye_polished.fasta
## Run nucmer to map the assembled genomes (flye and canu) against the reference genome.
#mummerplot -f -l -p flye -R ${REF_GEN} -Q ${INPUT_FILE}/flye/flye_polished.fasta --large -t png flye.delta
#
## Go to the directory where the results should be stored.
#cd ${OUTPUT_DIR}/canu
#nucmer -b 1000 -c 1000 -p canu ${REF_GEN} ${INPUT_FILE}/canu/canu_polished.fasta
#mummerplot -f -l -p canu -R ${REF_GEN} -Q ${INPUT_FILE}/canu/canu_polished.fasta --large -t png canu.delta

# Go to the directory where the results should be stored.
mkdir ${OUTPUT_DIR}/canu_vs_flye
cd ${OUTPUT_DIR}/canu_vs_flye
nucmer -b 1000 -c 1000 -p canu  ${INPUT_FILE}/flye/flye_polished.fasta  ${INPUT_FILE}/canu/canu_polished.fasta
mummerplot -f -l -p canu -R ${INPUT_FILE}/flye/flye_polished.fasta  -Q ${INPUT_FILE}/canu/canu_polished.fasta --large -t png canu.delta