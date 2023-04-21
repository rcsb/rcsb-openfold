#!/bin/bash

# must match the mount point in of_job.yaml and populate_vol_job.yaml
vol=/ofvol

pdb_id=1ueb_A
seq=MISVTDLRPGTKVKMDGGLWECVEYQHQKLGRGGAKVVAKFKNLETGATVERTFNSGEKLEDIYVETRELQYLYPEGEEMVFMDLETYEQFAVPRSRVVGAEFFKEGMTALGDMYEGQPIKVTPPTVVELKVVDTPPGVRGDTVSGGSKPATLETGAVVQVPLFVEPGEVIKVDTRTGEYVGRA

input_dir=$vol/input
inputseqs_dir=$vol/input/sequences
inputalns_dir=$vol/input/alignments
templ_dir=$vol/templates
params_dir=$vol/params
out_dir=$vol/output_models

mkdir $input_dir $inputseqs_dir $inputalns_dir $templ_dir $params_dir $out_dir

# weights
aws s3 cp --no-sign-request --region us-east-1 s3://openfold/openfold_params/ "$params_dir" --recursive

# alignments
aws s3 cp --no-sign-request --region us-east-1 s3://openfold/pdb/$pdb_id/a3m "${inputalns_dir}/$pdb_id" --recursive
aws s3 cp --no-sign-request --region us-east-1 s3://openfold/pdb/$pdb_id/hhr "${inputalns_dir}/$pdb_id" --recursive

# inputs
echo "Writing input sequence to $inputseqs_dir"
cat > $inputseqs_dir/${pdb_id}.fasta <<EOF
>$pdb_id
$seq
>$pdb_id
$seq
EOF

# templates
# these correspond to the all 100% hhnlits hits of 1ueb
ids="6rk3 6s8z 6rji 3tre 3a5z 5j3b 3oyy 6enj 6j7m 1yby"
for id in $ids
do
  echo "Downloading $id cif file"
  curl "https://files.rcsb.org/download/$id.cif" > $templ_dir/$id.cif
done
