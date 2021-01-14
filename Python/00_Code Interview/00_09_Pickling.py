#!C:\Python\Python
#coding=utf-8

import pickle 

data = {"key" : "value"}
file = open('data.txt', 'wb') # must be binary mode 
pickle.dump(data, file)
file.close()

readfile = open('data.txt', 'rb') # must be binary mode 
dataloaded = pickle.load(readfile)
readfile.close()
print(dataloaded)


 
 
