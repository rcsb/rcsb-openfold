#!/bin/bash

DATA_ROOT=/expanse/lustre/projects/sds194/jmduarte
OF_PARAMS=$DATA_ROOT/openfold_params
TEMPLATES_DIR=$DATA_ROOT/pdb_mmcif/mmcif_files
OF_SIF_FILE=$DATA_ROOT/singularity/openfold.sif

seqsDirSing=/input/sequences
seqsDirHost=${DATA_ROOT}${seqsDirSing}
alnDirSing=/input/alignments
alnDirHost=${DATA_ROOT}$alnDirSing
outDirSing=/output_models
outDirHost=${DATA_ROOT}${outDirSing}


echo "Start: $(date)"

# Note '--nv' is required so that singularity can use nvidia/cuda
singularity exec --nv \
--bind $TEMPLATES_DIR:/templates \
--bind $seqsDirHost:$seqsDirSing \
--bind $outDirHost:$outDirSing \
--bind $alnDirHost:$alnDirSing \
--bind $OF_PARAMS:/params \
$OF_SIF_FILE \
python3 /opt/openfold/run_pretrained_openfold.py \
    $seqsDirSing \
    /templates \
    --use_precomputed_alignments $alnDirSing \
    --output_dir $outDirSing \
    --model_device "cuda:0" \
    --config_preset "model_1_ptm" \
    --save_outputs \
    --openfold_checkpoint_path /params/finetuning_ptm_2.pt \
    --cif_output

echo "Done:  $(date)"