#!/usr/bin/env bash

#SBATCH --time=02:00:00
#SBATCH --mem=10G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=BUSCO
#SBATCH --mail-user=carla.andrade@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/candrade/annotation/blast_%j.o
#SBATCH --error=/data/users/candrade/annotation/blast_%j.e
#SBATCH --partition=pall

module load Blast/ncbi-blast/2.10.1+
MAKERDIR=/data/users/candrade/annotation/run_mpi.maker.output
WORKDIR=/data/users/candrade/annotation/Busco
COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation/uniprot-plant_reviewed.fasta

cd /data/users/candrade/annotation/blast
makeblastdb -in ${COURSEDIR} -dbtype prot -out uniprot
blastp -query ${MAKERDIR}/flye_polished.all.maker.proteins.fasta.renamed.fasta  -db uniprot  -num_threads 10 -outfmt 6 -evalue 1e-10 -out blast_flye_polished

module load SequenceAnalysis/GenePrediction/maker/2.31.9;

# Map protein putative functions to MAKER produced GFF3 and FASTA files

cp ${MAKERDIR}/flye_polished.all.maker.proteins.fasta.renamed.fasta flye_polished.all.maker.proteins.fasta.renamed.fasta.Uniprot
cp ${MAKERDIR}/flye_polished-all.maker.noseq.gff.renamed.gff flye_polished.all.maker.noseq.gff.renamed.gff.Uniprot

maker_functional_fasta $COURSEFILE blast_flye_polished flye_polished.all.maker.proteins.fasta.renamed.fasta.Uniprot
maker_functional_gff $COURSEFILE blast_flye_polished flye_polished.all.maker.noseq.gff.renamed.gff.Uniprot