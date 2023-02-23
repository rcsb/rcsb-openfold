#!/bin/bash

# With no arguments it will assume we are in precomputed alignments mode
# With argument --with-aln it will compute alignments

ofDir=/home/jose/git/openfold
dataRoot=/data/openfold
inDir=/home/jose/input_sequences
outDir=/home/jose/output_models

# without this it crashes (in expanse login node)
#export OMP_NUM_THREADS=1

# note the checkpoint params are downloaded with download_openfold_params.sh (which requires awscli, installable with conda)

cd $ofDir
# activate the conda environment so that all tools are available
source scripts/activate_conda_env.sh

if [ "$1" = "--with-aln" ]
then
  python3 run_pretrained_openfold.py \
      $inDir \
      $dataRoot/pdb_mmcif/mmcif_files/ \
      --uniref90_database_path $dataRoot/uniref90/uniref90.fasta \
      --mgnify_database_path $dataRoot/mgnify/mgy_clusters_2018_12.fa \
      --pdb70_database_path $dataRoot/pdb70/pdb70 \
      --uniclust30_database_path $dataRoot/uniclust30/uniclust30_2018_08/uniclust30_2018_08 \
      --output_dir $outDir \
      --bfd_database_path $dataRoot/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt \
      --model_device "cuda:0" \
      --jackhmmer_binary_path lib/conda/envs/openfold_venv/bin/jackhmmer \
      --hhblits_binary_path lib/conda/envs/openfold_venv/bin/hhblits \
      --hhsearch_binary_path lib/conda/envs/openfold_venv/bin/hhsearch \
      --kalign_binary_path lib/conda/envs/openfold_venv/bin/kalign \
      --config_preset "model_1_ptm" \
      --openfold_checkpoint_path $dataRoot/openfold_params/finetuning_ptm_2.pt
else
  # NOTE that use_precomputed_alignments should point to a dir with:
  # - 3 a3m files: uniref90, mgnfy, bfd
  # - 1 hhr file (pdb70_hits.hhr) (note that this is not well documented, also note that in OpenProteinSet the hhr files is in a separate dir)
  # NOTE that the dir name should match the FASTA header (everything before 1st space)
  # All this is not well documented...
  python3 run_pretrained_openfold.py \
      $inDir \
      $dataRoot/pdb_mmcif/mmcif_files/ \
      --use_precomputed_alignments $outDir/alignments/ \
      --output_dir $outDir \
      --model_device "cpu" \
      --config_preset "model_1_ptm" \
      --save_outputs \
      --cif_output \
      --openfold_checkpoint_path ~/git/openfold/openfold/resources/openfold_params/finetuning_ptm_2.pt
fi
