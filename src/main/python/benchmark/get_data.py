from write_csv import *
from queries import *
from direxists import *
from write_fasta import *


max_seq = 800

    
if __name__ == "__main__":


    for sym in [(2,'"C2"'),(3,'"C3"'),(4,'"C4"'),(5,'"C5"'),(6,'"C6"'),(4,'"D2"'),(6,'"D3"')]:
        print(sym[1])
        data = get_data_for_polymers(get_searchapi_data(search_query % sym))
                                     
        for poly in data:

          if len(poly['entity_poly']['pdbx_seq_one_letter_code_can']) < max_seq:
                name = poly['rcsb_id'][:-1].lower()+poly['rcsb_polymer_entity_container_identifiers']['auth_asym_ids'][0]

                if folder_exists(name):
                    write_fasta([poly['rcsb_id'][:-2].lower(),poly['rcsb_id'][-1],
                                 poly['rcsb_polymer_entity_container_identifiers']['auth_asym_ids'][0],poly['entity_poly']['pdbx_seq_one_letter_code_can']])

    

