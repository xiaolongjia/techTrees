#!C:\Anaconda3\python.exe
#coding=utf-8

import psycopg2
import numpy as np
import pandas as pd
import os

fundA = pd.read_csv('02_read_csv.csv', encoding = "gb2312")
#print(fundA.head())


# Connect to your postgres DB
conn = psycopg2.connect("dbname=comIT user=postgres password=jiaxl51238")

# Open a cursor to perform database operations
cur = conn.cursor()

# Execute a query
cur.execute("SELECT * FROM \"onlineTest_fundrate\"")

# Retrieve query results
records = cur.fetchall()

for row in records:
	print(row)

sql = "INSERT INTO \"onlineTest_fundrate\" (rate, \"FundID\" , \"FundName\", \"increaseRate\", \"avgIncrease\") VALUES(%s,%s,%s,%s,%s)"
strings = []
for index, row in fundA.iterrows():
     strings.append([row['rate'], row['FundID'], row['FundName'], row['increaseRate'], row['avgIncrease']])
cur.executemany(sql, strings)
conn.commit()
exit()

#fundB = pd.read_table('02_read_csv.csv',  encoding = "ISO-8859-1", sep=',')
#print(fundB.head())

'''
https://blog.csdn.net/brucewong0516/article/details/79092579

pandas.read_csv常用参数整理
filepath_or_buffer ：可以是URL，可用URL类型包括：http, ftp, s3和文件。对于多文件正在准备中本地文件读取。
sep：如果不指定参数，则会尝试使用逗号分隔。分隔符长于一个字符并且不是‘\s+’,将使用python的语法分析器。并且忽略数据中的逗号。正则表达式例子：’\r\t’。
delimiter ：定界符，备选分隔符（如果指定该参数，则sep参数失效）
delim_whitespace ： 指定空格(例如’ ‘或者’ ‘)是否作为分隔符使用，等效于设定sep=’\s+’。如果这个参数设定为True那么delimiter 参数失效。
header ：指定行数用来作为列名，数据开始行数。如果文件中没有列名，则默认为0【第一行数据】，否则设置为None。如果明确设定 header = 0 就会替换掉原来存在列名。header参数可以是一个list例如：[0,1,3]，这个list表示将文件中的这些行作为列标题（意味着每一列有多个标题），介于中间的行将被忽略掉。注意：如果skip_blank_lines=True 那么header参数忽略注释行和空行，所以header=0表示第一行数据而不是文件的第一行。
names ：用于结果的列名列表，如果数据文件中没有列标题行，就需要执行 header=None。names属性在header之前运行默认列表中不能出现重复，除非设定参数mangle_dupe_cols=True。
index_col ：用作行索引的列编号或者列名，如果给定一个序列则有多个行索引。
usecols：返回一个数据子集，该列表中的值必须可以对应到文件中的位置（数字可以对应到指定的列）或者是字符传为文件中的列名。例如：usecols有效参数可能是 [0,1,2]或者是 [‘foo’, ‘bar’, ‘baz’]。使用这个参数可以加快加载速度并降低内存消耗。
prefix：在没有列标题时，也就是header设定为None，给列添加前缀。例如：添加prefix= ‘X’ 使得列名称成为 X0, X1, …
dtype： 每列数据的数据类型。例如 {‘a’: np.float64, ‘b’: np.int32}
skipinitialspace：忽略分隔符后的空白（默认为False，即不忽略）.
skiprows ：需要忽略的行数（从文件开始处算起），或需要跳过的行号列表（从0开始）。
nrows ：需要读取的行数（从文件头开始算起）。
na_values ：一组用于替换NA/NaN的值。如果传参，需要制定特定列的空值。默认为‘1.#IND’, ‘1.#QNAN’, ‘N/A’, ‘NA’, ‘NULL’, ‘NaN’, ‘nan’`.
keep_default_na：如果指定na_values参数，并且keep_default_na=False，那么默认的NaN将被覆盖，否则添加
na_filter：是否检查丢失值（空字符串或者是空值）。对于大文件来说数据集中没有空值，设定na_filter=False可以提升读取速度。
skip_blank_lines ：如果为True，则跳过空行；否则记为NaN。
'''
