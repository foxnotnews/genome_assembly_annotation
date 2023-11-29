#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=joint
#SBATCH --mail-user=carla.andrade@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/candrade/annotation/joint_%j.o
#SBATCH --error=/data/users/candrade/annotation/joint_%j.e

WORKDIR=/data/users/candrade/assembly_annotation_course/annotation/result
accession_maker_noseq=${WORKDIR}/maker_others/run_mpi_master.maker.noseq.gff.renamed.gff
accession_maker_protein=${WORKDIR}/maker_others/run_mpi_master.all.maker.proteins.fasta.renamed.fasta
accession_bed_output=${WORKDIR}/accession/Cvi0.bed


# get contig names
contig_names=/data/users/candrade/assembly_annotation_course/annotation/contig_names.txt
contig_length=/data/users/candrade/assembly_annotation_course/annotation/logs/find_10_contig_11938638.o
ids=/data/users/candrade/assembly_annotation_course/annotation/result/accession/top_10_ids.txt
beds=/data/users/candrade/assembly_annotation_course/annotation/result/accession/Cvi0.bed
temp=/data/users/candrade/assembly_annotation_course/annotation/result/accession/temp.fa

cd /data/users/candrade/assembly_annotation_course/annotation/shared
sed -i 's/run_mpi_master/Cvi_0/g' Cvi_0.bed
sed -i 's/run_mpi_master/Cvi_0/g' Cvi_0.fa


awk '{ 
	for (i=1; i<= NF; i++) {
		print $i
	}
}' joined.fa > Cvi0_accession.fa
