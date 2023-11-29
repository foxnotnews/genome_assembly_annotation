#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=format
#SBATCH --mail-user=carla.andrade@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/candrade/annotation/format_%j.o
#SBATCH --error=/data/users/candrade/annotation/format_%j.e

# generate bed and fa file
module load UHTS/Analysis/SeqKit/0.13.2
# got all contig names
fastafile=/data/users/candrade/assembly_annotation_course/annotation/flye_polished1.fasta
cd /data/users/candrade/assembly_annotation_course/annotation
seqkit seq --quiet --name $fastafile > contig_names.txt

# 1. compute the length of each contig and save in a list
awk -F "\t" -v contig_file="/data/users/candrade/assembly_annotation_course/annotation/contig_names.txt" '
    BEGIN {
        # Read contig names from the file into an array
        while (getline < contig_file > 0) {
            contigs[$1] = 1
        }
        close(contig_file)
    }
    $3 == "contig" && $1 in contigs {
        # Print contig name and length
        print $1, $5 - $4 + 1
    }
' ${accession_maker_noseq}

# sort and got the 10 longest contig name
contig_length=/data/users/candrade/assembly_annotation_course/annotation/logs/find_10_contig_11938638.o

sort -k2,2nr $contig_length | head -n 10 | awk '{print $1}' > /data/users/candrade/assembly_annotation_course/annotation/result/accession/top_10_ids.txt

# 2. Create a bed file with the position of every gene found in these contigs
ids=/data/users/candrade/assembly_annotation_course/annotation/result/accession/top_10_ids.txt

awk '$3=="mRNA"' ${accession_maker_noseq}|cut -f 1,4,5,9|sed 's/ID=//'|sed 's/;.\+//'|grep -w -f ${ids} > ${accession_bed_output}

# 3.1 Create a list with the IDs of these genes
cd /data/users/candrade/assembly_annotation_course/annotation/result/accession
awk '{print $4}' Cvi0.bed > Cvi0_gene_ids.txt

# 3.2 Fetch their protein sequences from the MAKER output
cd /data/users/candrade/assembly_annotation_course/annotation/result
# processing the raw fasta file to make it only containing the necessary info
awk 'BEGIN{
	RS=">"
	FS=" "
}{ 
	sequence=">" $1
	for (i=6; i<=NF; i++){ 
		sequence=sequence " " $i
	} 
	print sequence
}' ${accession_maker_protein} > accession/temp.fa

cd /data/users/candrade/assembly_annotation_course/annotation/result/accession
# sort id
sort -k 1,1 temp.fa > temp_sorted.fa 
sort Cvi0_gene_ids.txt > Cvi0_gene_ids_sorted.txt
# get all the gene - protein sequence
grep -F -w -f <(sed 's/^/>/' Cvi0_gene_ids_sorted.txt) temp_sorted.fa > joined.fa

awk '{ 
	for (i=1; i<= NF; i++) {
		print $i
	}
}' joined.fa > Cvi0_accession.fa

# finished for Cvi0 