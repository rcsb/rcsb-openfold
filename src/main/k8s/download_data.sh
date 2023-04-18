#!/bin/bash

# must match the mount point in of_job.yaml and populate_vol_job.yaml
vol=/ofvol

pdb_id=1ueb_A

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
cat > $inputalns_dir/${pdb_id}.fasta <<EOF
>1ueb |Chains A, B|elongation factor P|Thermus thermophilus (274)
MISVTDLRPGTKVKMDGGLWECVEYQHQKLGRGGAKVVAKFKNLETGATVERTFNSGEKLEDIYVETRELQYLYPEGEEMVFMDLETYEQFAVPRSRVVGAEFFKEGMTALGDMYEGQPIKVTPPTVVELKVVDTPPGVRGDTVSGGSKPATLETGAVVQVPLFVEPGEVIKVDTRTGEYVGRA
>1ueb |Chains A, B|elongation factor P|Thermus thermophilus (274)
MISVTDLRPGTKVKMDGGLWECVEYQHQKLGRGGAKVVAKFKNLETGATVERTFNSGEKLEDIYVETRELQYLYPEGEEMVFMDLETYEQFAVPRSRVVGAEFFKEGMTALGDMYEGQPIKVTPPTVVELKVVDTPPGVRGDTVSGGSKPATLETGAVVQVPLFVEPGEVIKVDTRTGEYVGRA
EOF
