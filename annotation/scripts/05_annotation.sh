#!/usr/bin/env bash

#SBATCH --time=2-00:00:00
#SBATCH --mem-per-cpu=12G
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --job-name=MAKER
#SBATCH --mail-user=carla.andrade@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/candrade/annotation/MAKER_%j.o
#SBATCH --error=/data/users/candrade/annotation/MAKER_%j.e
#SBATCH --partition=pall

COURSEDIR=/data/courses/assembly-annotation-course
PROJDIR=/data/users/candrade/annotation
WORKDIR=/data/users/candrade/annotation/control_annotation
cd $WORKDIR

export SLURM_EXPORT_ENV=ALL

module load SequenceAnalysis/GenePrediction/maker/2.31.9

mpiexec -n 16 \
singularity exec --bind $SCRATCH --bind $COURSEDIR --bind $PROJDIR \
    $COURSEDIR/containers2/MAKER_3.01.03.sif \
    maker -mpi -base run_mpi maker_opts.ctl maker_bopts.ctl maker_exe.ctl

