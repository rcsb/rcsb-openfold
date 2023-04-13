#!/bin/bash

DATA_ROOT=/expanse/lustre/projects/sds194/jmduarte
OF_PARAMS=$DATA_ROOT/openfold_params
TEMPLATES_DIR=$DATA_ROOT/pdb_mmcif/mmcif_files
OF_SIF_FILE=$DATA_ROOT/singularity/openfold.sif

inDir=/home/amazamontesinos/input_sequences
outDir=/home/amazamontesinos/output_models

echo "Start: $(date)"
# Note '--nv' is required so that singularity can use nvidia/cuda
singularity exec --nv \
--bind $TEMPLATES_DIR:/templates \
--bind $indDir:$inDir \
--bind $outDir:$outDir \
--bind $OF_PARAMS:/params \
$OF_SIF_FILE \
python3 /opt/openfold/run_pretrained_openfold.py \
    $inDir \
    /templates \
    --use_precomputed_alignments $outDir \
    --output_dir $outDir \
    --model_device "cuda:0" \
    --config_preset "model_1_ptm" \
    --save_outputs \
    --openfold_checkpoint_path /params/finetuning_ptm_2.pt \
    --cif_output

echo "Done:  $(date)"
