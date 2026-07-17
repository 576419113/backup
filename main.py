#!/usr/bin/env python3
import yaml
import os
data={}
if(not os.path.exists("backup")):
    os.makedirs("backup")
with open('config.yaml', 'r', encoding='utf-8') as file:
    data = yaml.load(file, Loader=yaml.FullLoader)
for key,value in data["backup"].items():
    if(not os.path.exists(f"backup/{key}")):
        path_temp=key
        if "\\" in key:
            path_temp=path_temp.replace("\\", "")
        os.makedirs(f"backup/{path_temp}")
    else:
        os.system(f"rm -rf backup/{key}")
    if(type(value) == list):
        for one in value:
            os.system(f"cp -rpau {one} backup/{key}")
    else:
        os.system(f"cp -rpau {value} backup/{key}")
