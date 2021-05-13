#!C:\python38\python

# https://geek-docs.com/python/python-tutorial/python-psycopg2.html

# https://www.psycopg.org/docs/install.html

import psycopg2

# Connect to your postgres DB
conn = psycopg2.connect("dbname=comIT user=postgres password=jiaxl51238")

# Open a cursor to perform database operations
cur = conn.cursor()

# Execute a query
cur.execute("SELECT * FROM test")

# Retrieve query results
records = cur.fetchall()

for row in records:
	print(row)

