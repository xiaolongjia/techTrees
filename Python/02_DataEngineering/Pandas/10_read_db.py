#!C:\Anaconda3\python.exe

import numpy as np
import pandas as pd
import os

import sys
sys.path.append('..')

from sqlalchemy import create_engine

# pip install psycopg2

engine = create_engine('postgres+psycopg2://postgres:jiaxl51238@localhost:5432/comIT', echo=True)
dbConnection    = engine.connect()

# Read data from PostgreSQL database table and load into a DataFrame instance
dataFrame       = pd.read_sql("select * from \"test\"", dbConnection);
pd.set_option('display.expand_frame_repr', False);
print(dataFrame)

#Writing to table 
studentScores = [(57, 61, 76, 56, 67), (77, 67, 65, 78, 62), (65, 71, 56, 63, 70)];
scoreDf = pd.DataFrame(studentScores, index = (1211,1212,1213), columns=("Physics", "Chemistry", "Biology", "Mathematics", "Language"))
postgreSQLTable = "StudentScores2"

try:
	frame = scoreDf.to_sql(postgreSQLTable, dbConnection, if_exists='fail');
except ValueError as vx:
	print(vx)
except Exception as ex:
	print(ex)
else:
	print("PostgreSQL Table %s has been created successfully."%postgreSQLTable);
finally:
	dbConnection.close();

#table_df = pd.read_sql_table('test', con=engine)
#print(table_df)

df.to_sql('arb'+date, engine, if_exists='replace', index=False)
cdf.to_sql('MktFutd', engine, if_exists='append', index=False)


# read_sql_query 
# read_sql_table

