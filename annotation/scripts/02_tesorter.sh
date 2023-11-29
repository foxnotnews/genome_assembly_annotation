#!/usr/bin/env bash

#SBATCH --time=3:00:00
#SBATCH --mem=10G
#SBATCH --job-name=telsorter
#SBATCH --mail-user=carla.andrade@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/candrade/annotation/output_telsorter_%j.o
#SBATCH --error=/data/users/candrade/annotation/error_telsorter_%j.e
#SBATCH --partition=pall

Type=$1
mkdir $type
COURSEDIR=/data/courses/assembly-annotation-course
WORKDIR=/data/users/candrade/annotation/telsorter
INPUT=/data/users/candrade/annotation/EDTA/flye_polished.fasta.mod.EDTA.TElib.fa
module load UHTS/Analysis/SeqKit/0.13.2;

mkdir -p $WORKDIR/${Type}
cd $WORKDIR/${Type}
cat ${INPUT} | seqkit grep -r -p ^*${Type}* > output_${Type}.fasta



singularity exec \
--bind $WORKDIR \
--bind $COURSEDIR
$COURSEDIR/containers2/TEsorter_1.3.0.sif  \
TEsorter \
 output_${Type}.fasta -db rexdb-plant



#WORKDIR=/data/users/candrade/annotation/telsorter/
#DATABASE=/data/courses/assembly-annotation-course/CDS_annotation/Brassicaceae_repbase_all_march2019.fasta
#cd $WORKDIR/${Type}
#cat ${DATABASE} | seqkit grep -r -p ^*${Type}* > output_${Type}_Brassicaceae.fasta
#
#
#
#singularity exec \
#--bind $WORKDIR \
#--bind $COURSEDIR
#$COURSEDIR/containers2/TEsorter_1.3.0.sif  \
#TEsorter \
# output_${Type}_Brassicaceae.fasta -db rexdb-plant
