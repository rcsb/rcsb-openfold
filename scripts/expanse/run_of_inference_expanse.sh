#!/bin/bash
# parameters taken from AlphaFold example expanse script
# note the project "SDS154" I took from my initial email
#SBATCH --job-name openfold
#SBATCH --output="openfold.%j.%N.log"
#SBATCH --error="openfold.%j.%N.log"
#SBATCH --account=SDS154
#SBATCH --time=08:00:00
#SBATCH --gpus=1
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --partition=gpu-shared
#SBATCH --mem=40G

echo "Start: $(date)"
$(pwd)/run_of_inference.sh "$1"
echo "Done:  $(date)"
