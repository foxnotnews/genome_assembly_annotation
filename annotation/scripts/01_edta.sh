#!/usr/bin/env bash

#SBATCH --time=3:00:00
#SBATCH --mem=10G
#SBATCH --job-name=eval_edta
#SBATCH --mail-user=carla.andrade@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/candrade/annotation/output_edta_%j.o
#SBATCH --error=/data/users/candrade/annotation/error_edta_%j.e
#SBATCH --partition=pall

COURSEDIR=/data/courses/assembly-annotation-course
WORKDIR=/data/users/candrade/annotation/edta 
GENOME=/data/users/candrade/annotation/flye/pilon_flye.fasta
cd $WORKDIR

singularity exec \
--bind $COURSEDIR \
--bind $WORKDIR \
$COURSEDIR/containers2/EDTA_v1.9.6.sif \
EDTA.pl \
--genome  ${GENOME} \ #The genome FASTA 
--species others \
--step all \
--cds ${COURSEDIR}/CDS_annotation/TAIR10_cds_20110103_representative_gene_model_updated  \  #The coding sequences FASTA \
--anno 1 \  #perform whole-genome TE annotation after TE library construction \
--threads 50  \ 
--force 1

