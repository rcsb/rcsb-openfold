#!/bin/sh

dataRoot=/data/openfold
inDir=/home/jose/input_sequences
outDir=/home/jose/output_models
paramsDir=~/git/openfold/openfold/resources/openfold_params/

echo "Start: $(date)"

# Note '--gpus all' is required so that docker uses the nvidia container toolkit that makes cuda available to docker
docker run \
--gpus all \
-v $dataRoot:$dataRoot \
-v $inDir:$inDir \
-v $outDir:$outDir \
-v $paramsDir:/params \
-ti openfold \
python3 /opt/openfold/run_pretrained_openfold.py \
    $inDir \
    $dataRoot/pdb_mmcif/mmcif_files/ \
    --use_precomputed_alignments $outDir/alignments/ \
    --output_dir $outDir \
    --model_device "cuda:0" \
    --config_preset "model_1_ptm" \
    --save_outputs \
    --openfold_checkpoint_path /params/finetuning_ptm_2.pt \
    --cif_output

echo "Done:  $(date)"