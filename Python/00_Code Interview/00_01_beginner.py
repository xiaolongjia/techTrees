#!C:\Python\Python
#coding=utf-8

#----------------------------
# list all arguments 
#----------------------------
import sys
for i in sys.argv:
    print (i)
print ('\n python path ',sys.path)

#----------------------------
# Global Variable
#----------------------------
A = 10
def myfunction():
    global A
    A += 10
    print(A)
print(A)
myfunction()

#----------------------------
# 正负无穷大的表示方法
#----------------------------
float("inf")
float("-inf")

#----------------------------
# list
#----------------------------
# square brackets
subjects = ['physics', 'chemistry', 'biology']
print(subjects)
print(subjects[0])
print(subjects[0:2])
subjects[2] = 'math'
del subjects[2]
print(subjects)
print(len(subjects))
print(subjects*2)
print(subjects[::-1])
subjects = [0,1,3,3,2,4,2,1]
subjects.remove(0)
print(subjects)
# Lists Remove Duplicates
newSubjects = list(dict.fromkeys(subjects))
print(newSubjects)

#----------------------------
# Tuples
#----------------------------
chelsea = ('hazard', 'terry', 'lampard')  

#----------------------------
# Sets
#----------------------------
mySet = {1,2,3,3,4,5}
youSet = {3,4,5,6,7}
print(mySet)
print(mySet | youSet) #union 
print(mySet & youSet) #Intersection
print(mySet - youSet) #Difference
print(youSet - mySet) #Difference

#----------------------------
# Negative index 
#----------------------------
a = "string"
print(a[:-1])

#----------------------------
# Dictionary
#----------------------------
myDict = {'Name' : 'Saurabh', 'Age' : 23}
myDictRef = myDict
myNewDict = myDict.copy() #浅拷贝
myDict['address'] = 'saskatoon'
print(myDict)
print(myNewDict)
print(myDictRef)

# function as dictionary's value. 
def mySum (x, y):
    return x+y
    
myDict = {'+':mySum}
print(myDict['+'](4,5))

myDict.clear() # clear dictionary data
print(myDict)

# fromkeys()
listOne = ['name', 'class', 'age']
listTwo = ['Tim', 'G3', '8']
stuDict = dict.fromkeys(listOne, listTwo)
print(stuDict)
# get()
reData = stuDict.get('name')
print(reData)
# keys() values()
stuKeys = list(stuDict.keys())
stuValues = list(stuDict.values())
stuItems = stuDict.items()
print(stuKeys)
print(stuValues)
print(stuItems)
for i,j in stuItems:
    print("{}:{}".format(i,j))

#update()
myDict1 = {'name':'Tim'}
myDict2 = {'age':43, 'gender':'male', 'data':{'grade1':95,'grade2':88}}
myDict1.update(myDict2)
print(myDict1)
myDict2['data']['grade1'] = 99
print(myDict1)
print(myDict2)

#pop(key)
myDict2['data'].pop('grade1')
print(myDict1)
print(myDict2)

#----------------------------
# Operators
#----------------------------
# Arithmetic Operators:
'''
+ Addition	
– Subtraction	
* Multiplication	
/ Division
// 	除取整
% Modulus	
** Exponent
'''
print(32//3)
print(32/3)
print(32%3)
# Comparison Operators:
'''
==
!=
>
<
>=
<=
'''
# Assignment Operators:
'''
+=
-=
*=
/=
%=
**=
'''
# Bitwise Operators:
'''
&  binary AND (同1为1)
|  binary OR  (有1为1)
^  binary XOR  (同0异1)
~  binary ones compliment
<< binary left shift  (左移位)
>> binary right shift (右移位)
'''
# Logical Operators:
'''
and     or      not 
'''
# Membership Operators:
'''
in      not in
'''
# Identity Operators:
'''
is      is not 
'''
