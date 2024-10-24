#!/bin/bash

DATA_ROOT=/global/cfs/cdirs/m4468/jose/data
OF_PARAMS=$DATA_ROOT/openfold_params
TEMPLATES_DIR=$DATA_ROOT/pdb_mmcif/mmcif_files

seqsDirSing=/input/sequences
seqsDirHost=${DATA_ROOT}${seqsDirSing}
alnDirSing=/input/alignments
alnDirHost=${DATA_ROOT}$alnDirSing
outDirSing=/output_models
outDirHost=${DATA_ROOT}${outDirSing}
cutlassHost=$HOME/git/cutlass
cutlassSing=/git/cutlass


echo "Start: $(date)"

# The CUTLASS_PATH env variable is for option --use_deepspeed_evoformer_attention to work

# Note '--gpu' is required so that podman can use nvidia/cuda
podman-hpc run --gpu \
--volume $TEMPLATES_DIR:/templates \
--volume $seqsDirHost:$seqsDirSing \
--volume $outDirHost:$outDirSing \
--volume $alnDirHost:$alnDirSing \
--volume $OF_PARAMS:/params \
--volume $cutlassHost:$cutlassSing \
-e CUTLASS_PATH=$cutlassSing \
--rm jmduarte:openfold \
python3 /opt/openfold/run_pretrained_openfold.py \
    $seqsDirSing \
    /templates \
    --use_precomputed_alignments $alnDirSing \
    --output_dir $outDirSing \
    --model_device "cuda:0" \
    --config_preset "model_1_ptm" \
    --save_outputs \
    --openfold_checkpoint_path /params/finetuning_ptm_2.pt \
    --cif_output \
    --use_deepspeed_evoformer_attention

echo "Done:  $(date)"
