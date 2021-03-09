#!C:\Anaconda3\python.exe
#coding=utf-8

import numpy as np
import pandas as pd

# https://geek-docs.com/pandas/pandas-tutorials/pandas-tutorial.html

# data structure:  series, data frame, pannel

#--------------
# pandas.Series( data, index, dtype, copy)
#--------------

data = np.array(['a','b','c','d'])
s = pd.Series(data, index=[100,101,102,103])
print (s)

data = {'a' : 0., 'b' : 1., 'c' : 2.}
s = pd.Series(data)
'''
a    0.0
b    1.0
c    2.0
'''

s = pd.Series(data, index=['b','c','d','a'])
print (s)
'''
b    1.0
c    2.0
d    NaN
a    0.0
'''

s = pd.Series(5, index=[0, 1, 2, 3])
print(s)
'''
0    5
1    5
2    5
3    5
'''

s = pd.Series([1,2,3,4,5],index = ['a','b','c','d','e'])
print(s)
print(s[4]) # 0 -> 'a' ... 5 -> 'e'
print(s['e'])
print(s[:3])  #retrieve the first three element
print(s[-3:]) #retrieve the last three element
print(s[['a','c','d']])
print(s[[0, 2, 3]])

#--------------
# pandas.DataFrame( data, index, columns, dtype, copy)
#--------------

data = [['Alex',10],['Bob',12],['Clarke',13]]
df = pd.DataFrame(data, index=[0,1,2], columns=['Name','Age'],dtype=float)
'''
     Name   Age
0    Alex  10.0
1     Bob  12.0
2  Clarke  13.0
'''

data = {'Name':['Tom', 'Jack', 'Steve', 'Ricky'],'Age':[28,34,29,42]}
df = pd.DataFrame(data)
'''
    Name  Age
0    Tom   28
1   Jack   34
2  Steve   29
3  Ricky   42
'''

data = [{'a': 1, 'b': 2},{'a': 5, 'b': 10, 'c': 20}]
df = pd.DataFrame(data, index=['first', 'second'] )
'''
        a   b     c
first   1   2   NaN
second  5  10  20.0
'''
d = {'one' : pd.Series([1, 2, 3], index=['a', 'b', 'c']), 'two' : pd.Series([1, 2, 3, 4], index=['a', 'b', 'c', 'd'])}
df = pd.DataFrame(d)
'''
   one  two
a  1.0    1
b  2.0    2
c  3.0    3
d  NaN    4
'''
print (df)

# columns operations (add, delete)
df['three'] = pd.Series([5, 6, 7], index=['d', 'b', 'c'])
df['four'] = df['one'] + df['three']
print (df)

print (df[['one','three','four']])

del df['one']  # drop column
df.pop('four') # drop column 
print (df)

# row operations 
print (df.loc['a'])
print (df.iloc[0])
print (df[1:3])
df = df.drop('a') # drop row
print (df)



exit()


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