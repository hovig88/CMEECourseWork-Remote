#!/bin/bash
#PBS -l walltime=00:00:10
#PBS -l select=1:ncpus=1:mem=1gb
module load anaconda3/personal
echo "R is about to run"
cp $HOME/HPC/jrosinde_HPC_2019_main.R $TMPDIR
R --vanilla < $HOME/HPC/jrosinde_HPC_2019_cluster.R
mv results* $HOME/HPC/results/
echo "R has finished running"
# this is a comment at the end of the file

