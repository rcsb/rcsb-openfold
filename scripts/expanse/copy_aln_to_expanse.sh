#!/bin/bash

if [ -z "$1" ]
then
  echo "Usage: $0 <PDB id>"
  exit 1
fi

pdb=$1
root_aln_dir=/data/openfold/pdb/
dest_dir=output_models/alignments/$pdb

rsync $root_aln_dir/${pdb}_A/a3m/* jmduarte@login.expanse.sdsc.edu:$dest_dir
rsync $root_aln_dir/${pdb}_A/hhr/* jmduarte@login.expanse.sdsc.edu:$dest_dir