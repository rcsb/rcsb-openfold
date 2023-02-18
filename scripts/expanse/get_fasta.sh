if [ -z "$3" ]
then
  echo "Usage $0 <pdb> <stoichiometry> <outdir>"
  exit 1
fi

pdb=$1
sto=$2
outdir=$3

curl "https://www.rcsb.org/fasta/entry/$pdb/download" > $outdir/$pdb.fasta


# TODO finish. problem ith quoting and fasta formatting and sto
seq=$(curl 'https://data.rcsb.org/graphql' \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -H 'Origin: https://data.rcsb.org' \
  --data-raw '{"query":"{\n  entry(entry_id: \"$pdb\"){\n    polymer_entities {\n      entity_poly {\n        pdbx_seq_one_letter_code_can\n      }\n    }\n  }\n}","variables":null}' \
  --compressed)