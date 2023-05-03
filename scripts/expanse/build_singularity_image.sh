#!/bin/sh

# 1st step: in openfold git clone, build docker locally:
docker build -t openfold .

# 2nd step: from local docker image build singularity image:
# set cache and temp dirs to a place with plenty of space (> 40GB)
# note default cache dir is ~/.singularity
export SINGULARITY_CACHEDIR=/data/openfold/singularity
export SINGULARITY_TMPDIR=/data/openfold/singularity
singularity build /data/openfold/openfold.sif docker-daemon://openfold:latest