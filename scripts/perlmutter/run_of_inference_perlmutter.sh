#!/bin/bash
#
#SBATCH --job-name openfold
#SBATCH --output="openfold.%j.%N.log"
#SBATCH --error="openfold.%j.%N.log"
#SBATCH --account=m4468
#SBATCH --time=00:30:00
#SBATCH --gpus=1
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --partition=gpu-shared
# ----- #SBATCH --mem=40G
#SBATCH --mail-user=jose.duarte@rcsb.org
#SBATCH --constraint=gpu

nvidia-smi

echo "Start: $(date)"
./run_of_podman.sh
echo "Done:  $(date)"
