#!/bin/sh

dataRoot=/data/openfold
inDir=/home/jose/input_sequences
outDir=/home/jose/output_models
paramsDir=~/git/openfold/openfold/resources/openfold_params/


echo "Start: $(date)"

# Note '--nv' is required so that singularity can use nvidia/cuda
singularity exec --nv /home/jmduarte/openfold.sif \
--bind $dataRoot:$dataRoot \
--bind $inDir:$inDir \
--bind $outDir:$outDir \
--bind $paramsDir:/params \
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