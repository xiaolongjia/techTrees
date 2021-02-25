#!C:\python38\python


import pyodbc

conn = pyodbc.connect('DRIVER={sql server};' 'SERVER=DESKTOP-1BOUP1O;' 'DATABASE=comIT;' 'UID=sa;' 'PWD=jiaxl51238')
cursor = conn.cursor()
cursor.execute('SELECT * FROM persons')
for row in cursor:
    print(row)

conn.close()
