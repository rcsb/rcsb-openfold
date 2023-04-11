import os
import shutil

folder = 'C:/Users/alvar/Desktop/PDB/benchmark/get_ids/fasta_files'

if os.path.exists(folder) and os.path.isdir(folder):
    shutil.rmtree(folder)
os.mkdir(folder) 
def write_fasta(input):
    file = open(os.path.join(folder,input[0]+".fasta"), "w")
    file.write(">" + input[0] + " | " + "Assembly ID: "+ input[1] +  " | " + "Author ID: "+ input[2] +  "\n" +input[3] + "\n")
    file.close()