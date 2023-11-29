#!/usr/bin/env bash

#SBATCH --time=1:00:00
#SBATCH --mem=10G
#SBATCH --job-name=telsorter
#SBATCH --mail-user=carla.andrade@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/candrade/annotation/output_te_%j.o
#SBATCH --error=/data/users/candrade/annotation/error_te_%j.e
#SBATCH --partition=pall

input=/data/users/candrade/annotation/EDTA/polished_flye.fasta.mod.EDTA.anno
conda activate annotation
perl parseRM.pl -i ${input}/*.mod.out -l 50,1 -v
sed -i '1d;3d' ${input}/*.mod.out.landscape.Div.Rname.tab


#cd /data/courses/assembly-annotationcourse/CDS_annotation/scripts
