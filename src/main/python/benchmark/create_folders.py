import os
import random
import shutil
import math

def group_files(source_dir, dest_dir, num_folders):
    # Get a list of all the files in the source directory
    files = os.listdir(source_dir)
    # Shuffle the list randomly
    random.shuffle(files)
    # Calculate the number of files per folder
    files_per_folder = math.ceil(len(files) / num_folders) 
    # Create the destination folders
    for i in range(num_folders):
        os.makedirs(os.path.join(dest_dir, f"Batch_{i + 1}"))
    # Copy files to the destination folders
    for i, file in enumerate(files):
        folder_index = i // files_per_folder
        folder_name = f"Batch_{folder_index + 1}"
        shutil.copy(os.path.join(source_dir, file), os.path.join(dest_dir, folder_name))

# Example usage
source_dir = "C:/Users/alvar/Desktop/PDB/benchmark/get_ids/fasta_files"
dest_dir = "C:/Users/alvar/Desktop/PDB/benchmark/get_ids/test"
num_folders = 4
group_files(source_dir, dest_dir, num_folders)