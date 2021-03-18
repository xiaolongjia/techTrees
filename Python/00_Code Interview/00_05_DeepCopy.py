#!C:\Python38\Python
#coding=utf-8

import copy 

a = {1: [1,2,3]}

b = a 
c = copy.copy(a)
d = copy.deepcopy(a)

a[1].append(4)

print(a)
print(b)
print(c)
print(d)

