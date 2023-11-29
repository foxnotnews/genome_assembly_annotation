#!/usr/bin/env bash

#SBATCH --time=02:00:00
#SBATCH --mem=10G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=BUSCO
#SBATCH --mail-user=carla.andrade@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/candrade/annotation/Busco/BUSCO_%j.o
#SBATCH --error=/data/users/candrade/annotation/Busco/BUSCO_%j.e
#SBATCH --partition=pall

MAKERDIR=/data/users/candrade/annotation/run_mpi.maker.output
WORKDIR=/data/users/candrade/annotation/Busco
cd $WORKDIR

# Module to run BUSCO assessment
module add UHTS/Analysis/busco/4.1.4;

# Run BUSCO for annotation results
busco -i ${MAKERDIR}/flye_polished.all.maker.proteins.fasta.renamed.fasta -o flye_polished_annotation -l brassicales_odb10 -m proteins -c 4