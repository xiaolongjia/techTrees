#!C:\Anaconda3\python.exe
#coding=utf-8

import numpy as np
import pandas as pd



# https://zhuanlan.zhihu.com/p/103167104
# https://github.com/KeithGalli/pandas/blob/master/Pandas%20Data%20Science%20Tutorial.ipynb




poke = pd.read_csv('pdTestData.csv')
#print(poke.head(10))
#print(poke.tail(10))
#exit()

# create series 
arr1 = np.array([1,3,2,5,6,10,7])
s1 = pd.Series(arr1)
print(s1)

dict1 = {'math':89, 'english': 92, 'music':90}
s2 = pd.Series(dict1)
print(s2)
print("========================================\n")

# create data frame 
g7Dict1 = {'area': {'Canada': 9984670, 'France': 643801, 'German': 357386, 'Ita': 309338, 'Jap': 337962, 'England': 243610, 'US': 243610, 'China': 00},
          'population': {'Canada': 37281000, 'France': 65569000, 'German': 81427000, 'Ita': 59984000, 'Jap': 126140000, 'England': 66366000,'US': 329100000},
          'GDP': {'Canada': 1.674, 'France': 2.736, 'German': 4.379, 'Ita': 2.234, 'Jap': 5.747, 'England': 2.808, 'US': 21.439},
          'Gini Coefficient': {'Canada': 0.337, 'France': 0.301, 'German': 0.307, 'Ita': 0.324, 'Jap': 0.379, 'England': 0.316, 'US': 0.390},
          'Human Development Index': {'Canada': 0.922, 'France': 0.891, 'German': 0.939, 'Ita': 0.873, 'Jap': 0.915, 'England': 0.920, 'US': 0.920},
          'currency': {'Canada': 'CAD', 'France': 'EUR', 'German': 'EUR', 'Ita': 'EUR', 'Jap': 'JPY', 'England': 'GBP', 'US': 'USD'}}
G7 = pd.DataFrame(g7Dict1)
print(G7)
print(G7.columns)

# reading data with column name 
print(G7[['Human Development Index', 'GDP']])
print(G7[['population', 'area']])
print('')

# reading each row
for index, row in G7.iterrows():
     print(index, row['currency'])

# reading data with row
print(G7.loc[['France']])
print("")
print(G7.loc[['German', 'Ita']])
print("")

# reading data with row default id 
print(G7.iloc[0]) # row id 0 is Canada 
print(G7.iloc[1:3]) # row id 1 and 2
print(G7['German' : 'China']) # from German to China 
print("")
print(G7.iloc[1,3])

# Sorting/Describing Data


# Making changes to the data


# Saving our Data (Exporting into Desired Format)


# 


# special query 
print(G7[(G7['GDP'] < 3.0) & (G7['currency'] == 'EUR')])

# data calculation
gdp = G7[['GDP']]
gdp_min = gdp.min()
gdp_max = gdp.max()
gdp_med = gdp.median()
gdp_mean = gdp.mean() 
print(gdp_min,"\n")
print(gdp_max,"\n")
print(gdp_med,"\n")
print(gdp_mean,"\n")