#!C:\Python\Python

#--------------------------------------------------
# Assigning Values to Variables
#--------------------------------------------------

x = 5 
y = 6
z = 7

name = 'Tim'
age = 10
grade = 4

print('-' * 20)
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

#--------------------------------------------------
# Data types
#--------------------------------------------------

var = 1
var = -200
var = 2.5e5
var = -32.54e100 + 3
var = complex(2, 4)
var = 2+4j
print(var.real)
print(var.imag)

var = 1987
print(bin(var))
print(oct(var))
print(hex(var))
print(format(var, 'b'))
print(format(var, 'o'))
print(format(var, 'x'))
print(int(bin(var), 2))
print(int(oct(var), 8))
print(int(hex(var), 16))

str = 'Hello World!'
print (str)          # Prints complete string
print (str[0])       # Prints first character of the string
print (str[2:5])     # Prints characters starting from 3rd to 5th
print (str[2:])      # Prints string starting from 3rd character
print (str * 2)      # Prints string two times
print (str + "TEST") # Prints concatenated string
print("*"*30)
print (str[-2:-5:-1])
print("*"*30)
exit()
print (str[7:10])

mylist = [ 'abcd', 786 , 2.23, 'john', 70.2 ] # different data types
tinylist = [123, 'john']
print (mylist[0])       # Prints first element of the list
print (mylist[1:3])     # Prints elements starting from 2nd till 3rd 
print (mylist[2:])      # Prints elements starting from 3rd element
print (tinylist * 2)  # Prints list two times
print (mylist + tinylist) # Prints concatenated lists

mylist.append('asdasd')
print(mylist)
print(mylist.pop())
print(mylist)

mytuple = ( 'abcd', 786 , 2.23, 'john', 70.2  )
tinytuple = (123, 'john')
print (mytuple)           # Prints complete tuple
print (mytuple[0])        # Prints first element of the tuple
print (mytuple[1:3])      # Prints elements starting from 2nd till 3rd 
print (mytuple[2:])       # Prints elements starting from 3rd element
print (tinytuple * 2)   # Prints tuple two times
print (mytuple + tinytuple) # Prints concatenated tuple

#mylist[0] = 'hello!'
#mytuple[0] = 'hello!'

mydict = {}
mydict['one'] = "This is one"
mydict[2]     = "This is two"

tinydict = {'name': 'john','code':6734, 'dept': 'sales'}

print (mydict['one'])       # Prints value for 'one' key
print (mydict[2])           # Prints value for 2 key
print (tinydict)          # Prints complete dictionary
print (tinydict.keys())   # Prints all the keys
print (tinydict.values()) # Prints all the values

#-----------------------------------------------------
# Reference
#-----------------------------------------------------

#-----------------------------------
# String Functions
#-----------------------------------
str = "jiaxil"
print(str.capitalize())
print(str.center(20, "*"))
print(str.count('i', 0, len(str)))
print(str.find('0', 0, len(str)))  # if not found, return -1
#print(str.index('0', 0, len(str))) # if not found, return an exception
print(len(str)) # return the length of the string

split = "-"
strings = (str, "teacher", "computer")
print(split.join(strings))

print(str.replace("j", "K"))
print(str)

print(str.split("i"))
print(str.split("i", 1))
print(str)

#-----------------------------------
# List Functions
#-----------------------------------
list1 = list((123, 'Google', 'Runoob', 'Taobao', 123))
print ("list1 : ", list1)

list1.append("Hello!")
print(list1)
print(list1.count(123))
print(list1.count("o"))

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
print(list1.sort())
print(list1)

print(list1.copy())
list1.clear()
print(list1)

#--------------------------------------------------
# Dictionary Functions
#--------------------------------------------------
newdict = {}
newdict = newdict.fromkeys("1234", "placeholder")
print(newdict)
data = newdict.get("5")
print(data)

if "1" in newdict:
    print("it has key 1")
else:
    print("it does not have key 1")

print(newdict.items())
print(newdict.keys())
print(newdict.values())
print(list(newdict.items())[0][1])
print(list(newdict.keys())[0])

newdict.pop("1")
print(newdict)
newdict.popitem()
print(newdict)


