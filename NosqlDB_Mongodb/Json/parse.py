#!C:\Python38\Python
#coding=utf-8

import json 

# dump, load for json file 

with open("./family.json",'r') as load_f:
    load_dict = json.load(load_f)
    print(load_dict)

load_dict['relation'] = [8200,{1:[['Python',81],['shirt',300]]}]
print(load_dict)

with open("./newfamily.json", 'w') as dump_f:
	json.dump(load_dict, dump_f)

# dumps, loads for string 

