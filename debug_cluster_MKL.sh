#!/bin/bash

#SBATCH --qos=priority
#SBATCH --constraint=haswell
#SBATCH --account=icone
#SBATCH --error=%x-%j-%N.err
#SBATCH --output=%x-%j-%N.out
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --job-name=debug_cluster_MKL
#SBATCH --time=15:00

echo "------------------------------------------------------------"
echo "SLURM JOB ID: $SLURM_JOBID"
echo "$SLURM_NTASKS tasks"
echo "$SLURM_CPUS_PER_TASK cpus per task"
echo "------------------------------------------------------------"

export PATH=$PATH:/p/system/packages/perf-tools/bin

module load julia/1.8.2
perf record julia --threads=$SLURM_CPUS_PER_TASK /home/borneman/Masterarbeit/debug_pik_cluster/debug_cluster.jl MKL