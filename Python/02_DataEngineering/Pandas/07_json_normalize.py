#!C:\Anaconda3\python.exe

import os
import json
import numpy as np
import pandas as pd


file = open("07_json_normalize.json", "r")
text = file.read()
text = json.loads(text)

print(pd.DataFrame(text))
print(pd.json_normalize(text, 'books', ['writer', 'nationality']))
