#!C:\Anaconda3\python.exe

import numpy as np
import pandas as pd
import os


cp = pd.read_clipboard(sep='\t')
print(cp)

cp.to_json('df.json', orient='records', lines=True)
os.remove("./df.json")

# Data
textMatrix = [("Earth", "Sphere", "Geoid"), ("Matter", "Particle", "Wave"), ("Magnet", "Flex", "Electricity")];

# Create a DataFrame
df = pd.DataFrame(data=textMatrix);

# Copy DataFrame contents to clipboard
df.to_clipboard(sep="\t");
