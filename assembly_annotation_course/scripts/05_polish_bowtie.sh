#!/usr/bin/env bash
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=4
#SBATCH --mail-user=carla.andrade@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/candrade/assembly_annotation_course/output_canu_polish_%j.o
#SBATCH --error=/data/users/candrade/assembly_annotation_course/error_canu_polish_%j.e


# canu: pacbio_canu_assembly.contigs.fasta    flye:  assembly.fasta  
FILE_NAME=$1
#canu OR flye
OUTNAME=$2
#module bowtie
module add UHTS/Aligner/bowtie2/2.3.4.1;
INPUT=/data/users/candrade/assembly_annotation_course/assembly/${OUTNAME}/${FILE_NAME}

#canu OR flye
OUTPUT_DIR=/data/users/candrade/assembly_annotation_course/polish_assembly/${OUTNAME}
REFERENCE=/data/users/candrade/assembly_annotation_course/participant_4/Illumina

bowtie2-build ${INPUT} ${OUTPUT_DIR}/assembly_${OUTNAME}

bowtie2 --sensitive-local --threads 4 -x ${OUTPUT_DIR}/assembly_${OUTNAME} -1 ${REFERENCE}/ERR3624578_1.fastq.gz -2 ${REFERENCE}/ERR3624578_2.fastq.gz -S ${OUTPUT_DIR}/assembly_${OUTNAME}.sam
module add UHTS/Analysis/samtools/1.10
samtools view --threads 4  -bo ${OUTPUT_DIR}/assembly_${OUTNAME}.bam ${OUTPUT_DIR}/assembly_${OUTNAME}.sam   


