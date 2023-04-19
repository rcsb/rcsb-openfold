import csv
import os
import shutil

# Set the paths to the source folder, destination folder, and the CSV file
source_folder = 'D:/data/openfold/openproteinset/pdb/'
dest_folder = '/path/to/destination/folder'
csv_file = 'ids.csv'

# Read the CSV file and get the list of subfolder names to copy
subfolder_names = []
with open(csv_file, 'r') as file:
    reader = csv.reader(file)
    next(reader)
    for row in reader:
        subfolder_names.append(row[0])

# Copy the subfolders to the destination folder
for subfolder_name in subfolder_names:
    source_subfolder = os.path.join(source_folder, subfolder_name)
    dest_subfolder = os.path.join(dest_folder, subfolder_name)
    if os.path.exists(source_subfolder) and os.path.isdir(source_subfolder):
        shutil.copytree(source_subfolder, dest_subfolder)
        print(source_subfolder)