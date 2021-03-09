#!C:\Anaconda3\python.exe

import numpy as np
import pandas as pd
import os

col_widths = [5, 5, 5, 5, 5, 5, 5]
col_names = ['col1', 'col2', 'col3', 'col4', 'col5', 'col6', 'col7']

fwf = pd.read_fwf("03_read_fwf.txt", widths=col_widths, names=col_names)
print(fwf)

