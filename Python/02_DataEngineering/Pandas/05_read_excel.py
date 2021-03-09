#!C:\Anaconda3\python.exe

import numpy as np
import pandas as pd
import os

# io 
# sheet_name
# header 
# skiprows    from start  
# skipfooter  from end

fund = pd.read_excel(io="./05_read_excel.xlsx", sheet_name='FundData2')
#fund = pd.read_excel(io="./05_read_excel.xlsx", sheet_name=1, header=None)
print(fund)
print("==============")
 
fund2 = pd.read_excel(io="./05_read_excel.xlsx", sheet_name='FundData2', skiprows=3)
print(fund2)

fund3 = pd.read_excel(io="./05_read_excel.xlsx", sheet_name='FundData2', skipfooter=3)
print(fund3)

print("========== FundData2 ===========")
print(pd.read_excel('05_read_excel.xlsx', 'FundData2'))
print("========== 1 ===========")
print(pd.read_excel('05_read_excel.xlsx', 0))

dataFrame = pd.read_excel('05_read_excel.xlsx')
data = dataFrame.iloc[[1,2]].values
print(data)


# write excel 
frame = pd.DataFrame(np.random.random((4,4)), index=['exp1','exp2','exp3','exp4'], columns=['jan2015','Fab2015','Mar2015','Apr2005'])
print(frame)
frame.to_excel("05_read_excel2.xlsx")
os.remove("05_read_excel2.xlsx")
