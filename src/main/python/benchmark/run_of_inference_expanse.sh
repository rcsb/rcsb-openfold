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
# this is for the job to be able to use the Lustre filesystem (see https://www.sdsc.edu/support/user_guides/expanse.html)
#SBATCH --constraint=lustre

module load singularitypro/3.9

echo "Start: $(date)"
$(pwd)/run_of_singularity.sh
echo "Done:  $(date)"
