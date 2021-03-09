#!C:\Anaconda3\python.exe

import numpy as np
import pandas as pd
import os


# https://geek-docs.com/pandas/pandas-tutorials/pandas-tutorial.html

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
print("======================================================")
print (df)

# DataFrame attributes 

print(df.index)
print(df.columns)
print(df.to_numpy())
print(df.describe())  #  shows a quick statistic summary of your data
print(df.T) # Transposing your data
'''
       a    b    c    d
one  1.0  2.0  3.0  NaN
two  1.0  2.0  3.0  4.0
'''

# Getting columns 
print (df['one'])
print (df[['one', 'two']])
print (df.one)
print (df.two)

# Getting rows 
print (df[1:3]) # row index
print (df['a':'c']) # row label
print (df.loc[['a', 'c']]) # row lables 
print (df.iloc[0]) # row index

for index, row in df.iterrows():
     print(index, row['one'])

# Getting rows' some columns
print (df.loc[:, ['two']]) # getting data with row label
print (df.loc['a':'c', ['two']])
print (df.iloc[0:3, 1:2])  # getting data with row index then column index 
print(df.iat[1, 1])
print(df.iloc[1, 1])

# filtering data
print (df[df.one > 2]) # column 'one' value > 2
print (df[df['two'].isin([2,3])])
print (df[df.two.isin([2,3])])

# setting data 
df.at['a', 'one'] = 0  # Setting values by label ( 'a' is label not index)
df.iat[0, 1]  = 0      # Setting values by position
print (df)

# DataFrame operations (add, delete)
df['three'] = pd.Series([5, 6, 7], index=['d', 'b', 'c'])
df['four'] = df['one'] + df['three']
print (df)

del df['one']  # drop column
df.pop('four') # drop column 
print (df)
df = df.drop('a') # drop row
print(df)

df2 = df.copy() # deep copy 

# Stats

print(df.mean())

# String Methods

s = pd.Series(['A', 'B', 'C', 'Aaba', 'Baca', np.nan, 'CABA', 'dog', 'cat'])
print(s)
print(s.str.lower())
print(s.str.upper())
print(s.str.len())

idx = pd.Index([' jack', 'jill ', ' jesse ', 'frank'])
print(idx)
print(idx.str.strip())
print(idx.str.lstrip())
print(idx.str.rstrip())

s2 = pd.Series(['a_b_c', 'c_d_e', np.nan, 'f_g_h'], dtype="string")
print(s2.str.split('_'))
print(s2.str.split('_').str[1])

# Concat 
df = pd.DataFrame(np.random.randn(10, 4))
print(df)
pieces = [df[7:], df[:3], df[3:7]]
print(pd.concat(pieces))

print("sum...")
print(df[2].sum())
print(df[2].mean())
print(df[2].median())
print(df[2].mode())
print(df[2].std())
print(df[2].min())
print(df[2].max())
print(df[2].abs())
exit()

# rename 
# ihdf.rename(columns={'closePrice':'priceIH'}, inplace=True) 
# ihdf.merge(ifdf, on='DateTime', how='inner')


# https://pyzh.readthedocs.io/en/latest/python-pandas.html#id6

# https://pandas.pydata.org/pandas-docs/version/0.23.4/api.html#attributes-and-underlying-data

