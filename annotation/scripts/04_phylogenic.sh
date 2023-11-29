#!/usr/bin/env bash

#SBATCH --time=1:00:00
#SBATCH --mem=10G
#SBATCH --job-name=telsorter
#SBATCH --mail-user=carla.andrade@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/candrade/annotation/output_te_%j.o
#SBATCH --error=/data/users/candrade/annotation/error_te_%j.e
#SBATCH --partition=pall

TYPE=$1
cd /data/users/candrade/annotation/telsorter/${TYPE}
input=/data/users/candrade/annotation/telsorter/${TYPE}/output_${TYPE}.fasta.rexdb-plant.dom.faa

module load UHTS/Analysis/SeqKit/0.13.2;
module load SequenceAnalysis/MultipleSequenceAlignment/clustal-omega/1.2.4;
module load Phylogeny/FastTree/2.1.10;


grep Ty1-RT $input > list_${TYPE}
grep Ty3-RT $input >> list_${TYPE}

sed -i 's/>//' list_${TYPE}
sed -i 's/ .\+//' list_${TYPE}
seqkit grep -f list_${TYPE} $input -o ${TYPE}_RT.fasta

sed -i 's/|.\+//'  ${TYPE}_RT.fasta #remove all characters following "|"
clustalo -i ${TYPE}_RT.fasta -o ${TYPE}_protein_alignment.fasta
FastTree -out ${TYPE}_protein_alignment.tree ${TYPE}_protein_alignment.fasta