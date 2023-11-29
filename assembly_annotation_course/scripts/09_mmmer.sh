#!/usr/bin/env bash
#SBATCH --time=00:10:00
#SBATCH --mem=4G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=mummerplot
#SBATCH --partition=pall
#SBATCH --mail-user=carla.andrade@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/candrade/assembly_annotation_course/output_mummerplot_%j.o
#SBATCH --error=/data/users/candrade/assembly_annotation_course/error_mummerplot_%j.e



source_dir1=/data/users/candrade/genome_and_transcriptome_assembly_and_annotation/analysis/Comparison/flye/flye.delta
source_dir2=/data/users/candrade/genome_and_transcriptome_assembly_and_annotation/analysis/Comparison/canu/canu.delta
# reference genome
REF_GEN=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
OUTPUT_DIR=/data/users/candrade/genome_and_transcriptome_assembly_and_annotation/analysis/Comparison
mkdir -p ${OUTPUT_DIR}/mummer/flye ${OUTPUT_DIR}/mummer/canu



FLYE_INPUT=${INPUT_DIR}/flye/flye.delta
CANU_INPUT=${INPUT_DIR}/canu/canu.delta

# load the module
module add UHTS/Analysis/mummer/4.0.0beta1


ASSEMBLY=/data/users/candrade/assembly_annotation_course/polish_assembly
# Go to the directory where the results should be stored.
cd ${OUTPUT_DIR}/mummer/flye

#Run nucmer to map the assembled genomes (flye and canu) against the reference genome.
mummerplot -f -l -p flye -R ${REF_GEN} -Q ${ASSEMBLY}/flye/flye_polished.fasta --large -t png ${source_dir1}

# Go to the directory where the results should be stored.
cd ${OUTPUT_DIR}/mummer/canu

mummerplot -f -l -p canu -R ${REF_GEN} -Q ${ASSEMBLY}/canu/canu_polished.fasta --large -t png ${source_dir2}