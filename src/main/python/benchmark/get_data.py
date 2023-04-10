from write_csv import *
from queries import *



max_seq = 200

    
if __name__ == "__main__":
    
    create_csv_file("ids.csv")
    id_list = []
    for sym in [(2,'"C2"'),(3,'"C3"'),(4,'"C4"'),(5,'"C5"'),(6,'"C6"'),(4,'"D2"'),(6,'"D3"')]:
        data = get_data_for_polymers(get_searchapi_data(search_query % sym))
                                     
        for poly in data:
          if len(poly['entity_poly']['pdbx_seq_one_letter_code_can']) < max_seq:
              write_csv_file("ids.csv",[poly['rcsb_id'],poly['entity_poly']['pdbx_seq_one_letter_code_can']])

