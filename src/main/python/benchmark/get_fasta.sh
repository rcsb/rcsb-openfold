if [ -z "$2" ]
then
  echo "Usage $0 <pdb> <outdir> [<stoichiometry>]"
  echo "If <stoichiometry> is omitted, then stoichiometries 1 to 6 are written out to files"
  exit 1
fi

# note this will take the first entity of the entry
MAX_STO=6

pdb=$1
outdir=$2
sto=""

if [ -z "$3" ]
then
  echo "No stoichiometry provided. Will write out stoichiometries 1 to 6"
else
  sto=$3
fi

resp=$(curl 'https://data.rcsb.org/graphql' --data-raw '{"query":"{\n  entry(entry_id: \"'"$pdb"'\"){\n    polymer_entities {\n      entity_poly {\n        pdbx_seq_one_letter_code_can\n      }\n    }\n  }\n}","variables":null}' --compressed)
seq=$(echo "$resp" |  jq -r .data.entry.polymer_entities[0].entity_poly.pdbx_seq_one_letter_code_can)

write_fasta () {
  fasta_file="$outdir/${pdb}_$1.fasta"
  rm -f "$fasta_file"
  for i in $(seq 1 "$1")
  do
    echo ">$pdb" >> "$fasta_file"
    echo "$seq" >> "$fasta_file"
  done
}


if [ -z "$sto" ]
then
  for i in $(seq 1 $MAX_STO)
  do
    write_fasta $i
  done
else
  write_fasta $sto
fi



