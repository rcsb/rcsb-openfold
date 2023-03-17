#!/bin/sh

dataRoot=/data/openfold
inDir=/home/jose/input_sequences
outDir=/home/jose/output_models


python3 docker/run_docker.py \
  --fasta_paths=$inDir \
  --max_template_date=2022-01-01 \
  --data_dir=$dataRoot \
  --output_dir=$outDir \
  --use_precomputed_msas=true
