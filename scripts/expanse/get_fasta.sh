if [ -z "$3" ]
then
  echo "Usage $0 <pdb> <stoichiometry> <outdir>"
  exit 1
fi

# note this will take the first entity of the entry

pdb=$1
sto=$2
outdir=$3

resp=$(curl 'https://data.rcsb.org/graphql' --data-raw '{"query":"{\n  entry(entry_id: \"'"$pdb"'\"){\n    polymer_entities {\n      entity_poly {\n        pdbx_seq_one_letter_code_can\n      }\n    }\n  }\n}","variables":null}' --compressed)
seq=$(echo "$resp" |  jq -r .data.entry.polymer_entities[0].entity_poly.pdbx_seq_one_letter_code_can)

echo "" > $outdir/$pdb.fasta
for i in $(seq 1 "$sto")
do
  echo ">$pdb" >> $outdir/$pdb.fasta
  echo "$seq" >> $outdir/$pdb.fasta
done



