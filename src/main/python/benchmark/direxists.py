import os

ops = "D:/data/openfold/openproteinset/pdb/%s"

def folder_exists(name,path = ops):
    path = path % name
    return os.path.isdir(path)


