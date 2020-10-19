#!C:\Python\python

import psycopg2

conn = psycopg2.connect(database='mydb',user='postgres',password='121119',host='127.0.0.1',port='5432')
cur = conn.cursor()
cur.execute("SELECT * FROM cities")
rows = cur.fetchall()
print(rows)
conn.commit()
cur.close()
