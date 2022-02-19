#!C:\Python38\Python

#--------------------------------------------------
# Assigning Values to Variables
#--------------------------------------------------
'''
x = 5 
y = 6
z = 7

name = 'Tim'
age = 12
grade = 6

print('-' * 80)
print(x, y, z)
print('name is ', name)
print('age is ', age)
print('grade is ', grade)

x = y = z = 3.1415926
name, age, grade = 'Jack', 8, 2

print('-' * 20)
print(x, y, z)
print('name is ', name)
print('age is ', age)
print('grade is ', grade)
'''

#--------------------------------------------------
# Data types
#--------------------------------------------------

var = 1
var = -200
var = 2.5e5
var = -32.54e100 + 3
#var = complex(2, 4)
#var = 2+4j
#print(var.real)
#print(var.imag)

var = 8892
print(bin(var))
print(oct(var))
print(hex(var))
print(format(var, 'b'))
print(format(var, 'o'))
print(format(var, 'x'))

str = 'Hello!1today2is3Sat'
print(str[-5:-8])
print(str[-8:-5])
print(str[8:2:-1])
print(str[-7:-13:-1])
print("*"*30)

'''
1. Start Index: End Index: Direction 
2. When the value of Direction is 1,  Start Index < End Index 
3. When the value of Direction is -1, Start Index > End Index 
'''

str = 'Start Index: End Index: Direction'
print("!"+str[12]+"!") # Alex:   !_!
print(str[6:15])       # Angel:  Index: En
print(str[2:0:-1])     # Jack:   at
print("!"+str[-2:-12]+"!")     # Alex:   :_Directio  ; _ or null (Jack, Angel)
print(str[-8:-5])      # Angel:  ire 
print(str[8:2:-1])     # Jack:   dnl_tr  (dnl_tr)
print(str[-7:-13:-1])  # Alex:   rid_:x 
print(str[13:])        # Angel:  End Index: Direction
print(str[-2:-6:-1])   # Jack:   oitc
print(str[:])          # Alex:   null  (Jack, Angel )
print(str[3:])
print(str[:10])
print(str[7:10])       # Angel:  nde
print(str[-6:-2])      # Jack:   ecti 

print("========== list ============")

mylist = [ 'abcd', 786 , 2.23, 'john', 70.2, [1, 2, [4, 5, [10,11], 6], [7, 8, 9], 3] ] # different data types
print(mylist[5])
print(mylist[5][2][2][0])
tinylist = [123, 'john']
print (mylist[0])       # Prints first element of the list
print (mylist[1:3])     # Prints elements starting from 2nd till 3rd 
print (mylist[2:])      # Prints elements starting from 3rd element
print (tinylist * 2)    # Prints list two times
print (mylist + tinylist) # Prints concatenated lists
#print(mylist[6])
mylist[0] = 'newnumber'
mylist.append('asdasd')
mylist.append('a2')
mylist.append('a9')
print(mylist)
print(mylist[7])
print(mylist.pop(6))
print(mylist.pop())
print(mylist.pop())
print(mylist.pop())
print(mylist.pop())
print(mylist.pop())
print(mylist.pop())
print(mylist.pop())
print(mylist)

myList = ['Monday', 102, '103', 'Sunday'] 
print(myList.pop())
print(myList)
myList.append("104")
print(myList)
print(myList.pop(2))
print(myList)
myList.insert(2, '***')
print(myList)

#------------ typle ---------------------
mytuple = ( 'abcd', 786 , 2.23, 'john', 70.2  )
tinytuple = (123, 'john')
print (mytuple)           # Prints complete tuple
print (mytuple[0])        # Prints first element of the tuple
print (mytuple[1:3])      # Prints elements starting from 2nd till 3rd 
print (mytuple[2:])       # Prints elements starting from 3rd element
print (tinytuple * 2)   # Prints tuple two times
print (mytuple + tinytuple) # Prints concatenated tuple

myTest1 = ('III', 1119 , 'is', 3.1415)
myTest2 = ['III', 1119 , 'is', 3.1415]
print (myTest1[0])
print (myTest2[2:3])
print (myTest1[1:-1])
print (myTest1[-3:3])
print (myTest1[-4:-1:-1])
myTest2[1] = "one"
'''
myTest1[1] = "two"
print(myTest1)
print(myTest2)
'''

#mylist[0] = 'hello!'
#mytuple[0] = 'hello!'

#---------------
# dictionary 
#---------------
mydict = {}
mydict['one'] = "This is one"  # one ->  "This is one"
mydict[2]     = "This is two"  # 2 -> "This is two"
mydict['2']   = "This is two-2"
print (mydict['one'])       # Prints value for 'one' key
print (mydict[2])           # Prints value for 2 key
print (mydict) 

tinydict = {'name': 'john','code':6734, 'dept': 'sales'}
tinydict['phone'] = 306111111
print (tinydict)          # Prints complete dictionary
print (tinydict.keys())   # Prints all the keys
print (tinydict.values()) # Prints all the values

#-----------------------------------------------------
# Reference
#-----------------------------------------------------

#-----------------------------------
# String Functions
#-----------------------------------
str = "hello! python!"
newStr = str.capitalize()
print(newStr)
print(str)
print(str.center(50, "|"))
print(str)
print(len(str))

print(str.count('d', -10, len(str)))
print(str.find('d', 5, len(str)))  # if not found, return -1

#print(str.index('0', 0, len(str))) # if not found, return an exception
print(len(str)) 

split = "-"
strings = (str, "teacher", "computer")
print(split.join(strings))

print(str.replace("o", "K"))
print(str)

str = "hello! today is 2021-11-13"
print(str.split("-"))
print(str.split("1", 1))
print(str.split("o", 1))
print(str)

#-----------------------------------
# List Functions
#-----------------------------------
list1 = [123, 'Google', 'Runoob', 'Taobao', 123]
print ("list1 : ", list1)
print(list1[0])

list1.append("Hello!")
print(list1)
print(list1.count(123))
print(list1.count("Runoob"))

list1.extend("today is a good day!")
print(list1)

print(list1.index(123))
list1.insert(0, "haha")
print(list1)

print(list1.remove(123))
print(list1)

print(list1.remove(123))
print(list1.reverse())
print(list1)

#--------------------------------------------------
# Dictionary Functions
#--------------------------------------------------
newdict = {}
newdict = newdict.fromkeys([1,2,3,4,5,6,7], "placeholder")
print(newdict)

data = newdict.get(8)
print(data)

if 1 in newdict:
    print("it has key 1")
else:
    print("it does not have key 1")
	
print(newdict.keys())
print(newdict.values())

print(newdict.items())
print(list(newdict.items()))

print(list(newdict.items())[0][1])
print(list(newdict.keys())[0])

newdict.pop("1")
print(newdict)
newdict.popitem()
print(newdict)
