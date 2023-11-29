#!/usr/bin/env bash
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=BUSCO
#SBATCH --mail-user=carla.andrade@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/candrade/assembly_annotation_course/evaluation/output_BUSCO_%j.o
#SBATCH --error=/data/users/candrade/assembly_annotation_course/evaluation/error_BUSCO_%j.e
#SBATCH --partition=pall

#Variables for directory pathways
FLYE_DIR=/data/users/candrade/assembly_annotation_course/assembly/flye
CANU_DIR=/data/users/candrade/assembly_annotation_course/assembly/canu
TRIN_DIR=/data/users/candrade/assembly_annotation_course/assembly/Trinity
FLYE_POLISH_DIR=/data/users/candrade/assembly_annotation_course/polish_assembly/flye
CANU_POLISH_DIR=/data/users/candrade/assembly_annotation_course/polish_assembly/canu
OUTPUT_DIR=/data/users/candrade/assembly_annotation_course/evaluation/busco
MAIN_DIR=/data/users/candrade/assembly_annotation_course

# Module to run BUSCO assessment
module add UHTS/Analysis/busco/4.1.4;

cd $OUTPUT_DIR

#Make a copy of the augustus config directory to have written permission
cp -r /software/SequenceAnalysis/GenePrediction/augustus/3.3.3.1/config augustus_config
export AUGUSTUS_CONFIG_PATH=./augustus_config

# Run BUSCO for flye, canu and trinity assembly (not polish_assemblyed)
#busco -i ${FLYE_DIR}/assembly.fasta -o flye_unpolished --lineage brassicales_odb10 -m genome --cpu 16 -f
#cp flye_unpolished/short_summary* summaries/
#busco -i ${CANU_DIR}/pacbio_canu_assembly.contigs.fasta   -o canu_unpolished --lineage brassicales_odb10 -m genome --cpu 16 -f
#cp canu_unpolished/short_summary* summaries/
#busco -i ${TRIN_DIR}/Trinity.fasta -o trinity_RNAseq --lineage brassicales_odb10 -m transcriptome --cpu 16
#cp trinity_RNAseq/short_summary* summaries/

# Run BUSCO for flye and canu (polish_assemblyed)
#busco -i ${FLYE_polish_assembly_DIR}/flye_polished.fasta -o flye_polished --lineage brassicales_odb10 -m genome --cpu 16 -f
#cp flye_polished/short_summary* summaries/
#busco -i ${CANU_POLISH_DIR}/canu_polished.fasta -o canu_polished --lineage brassicales_odb10 -m genome --cpu 16 -f
#cp canu_polished/short_summary* summaries/

cd  ${MAIN_DIR}
python3 scripts/generate_plot.py --working_directory ${MAIN_DIR}/evaluation/busco/summaries

# Remove the augustus config
#rm -r ./augustus_config


