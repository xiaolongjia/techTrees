#!C:\Python\Python
#coding=utf-8

mystr = "hello! it is a Good day!"

print(mystr.capitalize()) # first character is Capitalisze 
print(mystr.upper())
print(mystr.lower())


#Option 1: Consecutive Single-line Comments
#
#
#

#Option 2: Using Multi-line Strings as Comments
"""
here is a multiple line comments
line2
line3
"""

#------------
# docstring
#------------

def square(n):
    '''Takes in a number n, returns the square of n'''
    return n**2

print(square.__doc__)
print(square(2)) # docstring does not show. 
help(square) #help() can access __doc__

#------------
# dir()
#------------
class Person:
  name = "John"
  age = 36
  country = "Norway"

print(dir(Person))
print("=="*20)

#------------
# *args **kwargs
#------------

def foo(*args, **kwargs):
    print('args = ', args)
    print('kwargs = ', kwargs)
    print('---------------------------------------')

if __name__ == '__main__':
    foo(1,2,3,4)
    foo(a=1,b=2,c=3)
    foo(1,2,3,4, a=1,b=2,c=3)
    foo('a', 1, None, a=1, b='2', c=3)  

#-------------
# re module 
# https://docs.python.org/zh-cn/3/library/re.html
#-------------
import re

# match 
if re.match(r'^\d{3}-\d{3}', '123-456'):
    print("matched!")
else:
    print("not matched!")

print(re.split(r'\s+', '1   123'))

m = re.match(r'^(\d{3})-(\d{3})', '123-456')
print(m.group(0))
print(m.group(1))
print(m.group(2))
print(m.groups())
print(re.match(r'^(\d+)(0*)$',  '102300').groups())  # ('102300', '')
print(re.match(r'^(\d+?)(0*)$', '102300').groups())  # ('1023', '00')

# compile 
re_compiled =  re.compile(r'^(\d{3})-(\d{3,8})$')
print(re_compiled)
print(re_compiled.match('010-62614991').groups())

# sub 
print("re.sub ------------------")
str = "https://i.cnb1logs.co2m/Edi3tPosts.asp4x?opt=999"
pattern=re.compile(r'(\.)')
print ('\.     :' , re.sub(pattern,'-',str))

# \1 反向引用
pattern=re.compile(r'/([^*]+)/')
print('\/([^*]+)\/ :' ,re.sub(pattern,r'<em>\1<em>',str))

pattern = re.compile(r'(\w+)(\w+)(\d+)')
#先切片测试
print(re.split(pattern,str))
print(re.sub(pattern,r'\3 \1',str))
#subn统计sub替换次数
print(re.subn(pattern,r'\3 \1',str))

#-------------
# array operations (add, remove)
#-------------
import numpy as arr 

a=['d', [1.1 , 2.1 ,3.1] ]
a.append(3.4)
print(a)
a.extend([4.5,6.3,6.8])
print(a)
a.insert(2,3.8)
print(a)

print(a.pop())
print(a[1].pop(2))
a[1].remove(1.1)
print(a)

#-------------
# deep and shallow copy 
#-------------
print("deep and shallow copy ")
import copy
a = [1,2,3,4,['a','b']] #原始对象
b = a                   #赋值，传对象的引用
c = copy.copy(a)        #浅拷贝 只拷贝父对象，不会拷贝对象的内部的子对象。
d = copy.deepcopy(a)    #深拷贝 拷贝对象及其子对象
a.append(5)
a[4].append('c')
print('a=',a)    #a= [1, 2, 3, 4, ['a', 'b', 'c'], 5]
print('b=',b)    #b= [1, 2, 3, 4, ['a', 'b', 'c'], 5]
print('c=',c)    #c= [1, 2, 3, 4, ['a', 'b', 'c']]
print('d=',d)    #d= [1, 2, 3, 4, ['a', 'b']]

#-------------
# Inheritance 
#-------------
print("--------------------- Inheritance ---------------")
#multiple inheritance 
class father():
    fathername = ''
    def father(self):
        print(self.fathername)
        
class mather():
    mathername = ''
    def mather(self):
        print(self.mathername)

class Daughter(father, mather):
    def parents(self):
        print("class Daughter")
        print(self.fathername)
        print(self.mathername)

student = Daughter()
student.fathername = "AAA"
student.mathername = "BBB"
student.parents()

#multiple-level inheritance
class Family():
    def family(self):
        print("this is a family")

class father(Family):
    fathername = ''
    def father(self):
        print(self.fathername)

class mather(Family):
    mathername = ''
    def mather(self):
        print(self.mathername)

class Daughter(father, mather):
    def parents(self):
        print("class Daughter")
        self.father()
        self.mather()

student = Daughter()
student.fathername = "AAA"
student.mathername = "BBB"
student.family()
student.parents()

#-------------------
# monkey patching
#-------------------
import sys
import time

class XiaoMing():
    def favorite(self):
        print("apple")

class God():
    @classmethod
    def new_xiaoming_favorite(self):
        print("banana")

    @classmethod
    def monkey_patch(self):
        XiaoMing.favorite = self.new_xiaoming_favorite
        
print("------------------------------------")
print(sys.modules)
God.monkey_patch()
print("------------------------------------")
print(sys.modules)

#xiaoming = XiaoMing()
#xiaoming.favorite()

#-------------------
# decorator  ??
#-------------------
# no parameters' decorator 
def decorator(func):
    def wrapper(*args, **kw):
        print("decorator start!")
        t1 = time.time()
        func()
        #time.sleep(10)
        t2 = time.time()
        print("decorator end!")
        cost_time = t2-t1 
        print("costed: {} ".format(cost_time))
    return wrapper

@decorator
def hello():
    print("hello, you!")

hello()

# decorator with parameters
def say_hello(name):
    def wrapper(func):
        def secWrapper(*args, **kwargs):
            print("in Wrapper2 {}".format(name))
            func(*args, **kwargs)
        return secWrapper
    return wrapper

@say_hello("Tim")
def hello2():
    print("hello, tim!")

hello2()

# decorator implemented by Class
class my_decorator():
    def __init__(self, func):
        self.func = func
    
    def __call__(self, *args, **kwargs):
        print("[INFO]: the function {func}() is running...".format(func=self.func.__name__))
        return self.func(*args, **kwargs)

@my_decorator
def hello3(name):
    print("hello, Jack!")

hello3("jack")

#------------------------
# Access Modifier
#------------------------

class Geek(object):
    __name = None #private 
    __age  = None #private 
    
    def __init__ (self, name, age):
        self.__name = name 
        self.__age  = age
        
    def _displayInfo(self):
        print(self.__name, self.__age)

student = Geek("Tom", "32")
student._displayInfo()
print(student._Geek__name) # it works 

#------------------------
# map function
#------------------------

def square(x):
    return x**2
    
print(list(map(square, [1,2,3])))
print(list(map(lambda x: x**2, [4,6,8])))

#----------------------------
# Python NumPy Array v/s List
#----------------------------

import numpy as np
 
import time
import sys

S= range(1000)
print(len(S))
print(sys.getsizeof(5)*len(S))
 
D= np.arange(1000)
print(D.size)
print(D.itemsize)
print(D.size*D.itemsize)



