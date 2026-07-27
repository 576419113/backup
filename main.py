#!/usr/bin/env python3
import yaml
import os
data={}
if(not os.path.exists("backup")):
    os.makedirs("backup")
with open('config.yaml', 'r', encoding='utf-8') as file:
    data = yaml.load(file, Loader=yaml.FullLoader)
for key,value in data["backup"].items():
    if key[0] == "-":
        continue
    temp_key=key
    if "\\" in key:
        key=key.replace("\\", "")
    print(key)
    if(os.path.exists(f"backup/{key}")):
        os.system(f"rm -rf backup/{temp_key}")
    os.makedirs(f"backup/{key}")
    if(type(value) == list):
        for one in value:
            os.system(f"cp -rpau {one} backup/{temp_key}")
    else:
        os.system(f"cp -rpau {value} backup/{temp_key}")
