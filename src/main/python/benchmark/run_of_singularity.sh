#!/bin/bash

scripts_dir=$(dirname $0)
source $scripts_dir/paths.sh

# TODO extract constants to paths.sh
inDir=/home/jmduarte/input_sequences
outDir=/home/jmduarte/output_models


echo "Start: $(date)"

# Note '--nv' is required so that singularity can use nvidia/cuda
singularity exec --nv \
--bind $TEMPLATES_DIR:/templates \
--bind $inDir:$inDir \
--bind $outDir:$outDir \
--bind $OF_PARAMS:/params \
$OF_SIF_FILE \
python3 /opt/openfold/run_pretrained_openfold.py \
    $inDir \
    /templates \
    --use_precomputed_alignments $outDir/alignments/ \
    --output_dir $outDir \
    --model_device "cuda:0" \
    --config_preset "model_1_ptm" \
    --save_outputs \
    --openfold_checkpoint_path /params/finetuning_ptm_2.pt \
    --cif_output

echo "Done:  $(date)"