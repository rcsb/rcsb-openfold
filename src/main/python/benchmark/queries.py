import urllib.request
import urllib.parse
import json
from graphqlclient import GraphQLClient


data_api_prefix = "https://data.rcsb.org/graphql"
search_api_prefix = "https://search.rcsb.org/rcsbsearch/v2/query?json="


search_query = """

{
  "query": {
    "type": "group",
    "logical_operator": "and",
    "nodes": [
      {
        "type": "terminal",
        "service": "text",
        "parameters": {
          "attribute": "rcsb_assembly_info.polymer_entity_count",
          "operator": "equals",
          "value": 1
        }
      },
      {
        "type": "terminal",
        "service": "text",
        "parameters": {
          "attribute": "rcsb_assembly_info.polymer_entity_instance_count",
          "operator": "equals",
          "value": %s
        }
      },
      {
        "type": "terminal",
        "service": "text",
        "parameters": {
          "attribute": "rcsb_struct_symmetry.symbol",
          "operator": "exact_match",
          "value": %s
        }
      },
      {
        "type": "terminal",
        "label": "text",
        "service": "text",
        "parameters": {
            "attribute": "exptl.method",
            "operator": "exact_match",
            "negation": true,
            "value": "SOLUTION NMR"
        }
      },
      {
        "type": "terminal",
        "label": "text",
        "service": "text",
        "parameters": {
            "attribute": "rcsb_entry_info.resolution_combined",
            "operator": "less",
            "negation": false,
            "value": 4
        }
      },
      {
        "type": "terminal",
        "service": "text",
        "parameters": {
          "attribute": "rcsb_struct_symmetry.kind",
          "operator": "exact_match",
          "value": "Global Symmetry"
        }
      }
    ]
  },
  "request_options": {
    "group_by_return_type": "representatives",
    "group_by": {
      "aggregation_method": "sequence_identity",
      "ranking_criteria_type": {
        "sort_by": "rcsb_entry_info.resolution_combined",
        "direction": "asc"
      },
      "similarity_cutoff": 50
    },
    "return_all_hits": true,
    "results_verbosity": "compact"
  },
  "return_type": "polymer_entity"
}
"""
ids_query = """
{
  polymer_entities(entity_ids: %s) {
    rcsb_id
    entity_poly{
      pdbx_seq_one_letter_code_can
    }

  }
}
"""



def build_search_api_query(json_query):
    return search_api_prefix + urllib.parse.quote_plus(json_query)


def get_searchapi_data(json_query):
    with urllib.request.urlopen(build_search_api_query(json_query)) as url:
        if url.getcode() == 200:
            data = json.loads(url.read())
        else:
            raise ValueError("Error in Search API query: %d" % url.getcode())
        return data['result_set']
    

def __get_data_for_polymers_single_request(assembly_ids):
    """
    Get an array with assembly info data (one array member per requested assembly_id)
    :param assembly_ids:
    :return:
    """
    client = GraphQLClient(data_api_prefix)
    ids_str = "[%s]" % ','.join('"' + item + '"' for item in assembly_ids)
    # print("Will query %s" % ids_str)
    query = ids_query % ids_str
    json_output = client.execute(query)
    return json.loads(json_output)["data"]["polymer_entities"]


def get_data_for_polymers(assembly_ids, bunch_size=100):
    data = []
    for i in range(0, len(assembly_ids), bunch_size):
        bunch_data = __get_data_for_polymers_single_request(assembly_ids[i:i+bunch_size])
        for member in bunch_data:
            data.append(member)
    return data

    