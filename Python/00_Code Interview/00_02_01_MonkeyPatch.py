#!C:\Python\Python
#coding=utf-8

# monkey patch refers to dynamic modifications of a class or method at run-time 

class myMonkey:
    def rawFunction(self):
        print("this is raw function")
    
    def monkey(self):
        print("this is monkey patch")

def exMonkey(a):
    print("this is my monkey patch")

myMonkey.rawFunction = myMonkey.monkey
obj = myMonkey()
obj.rawFunction()

myMonkey.rawFunction = exMonkey
obj2 = myMonkey()
obj2.rawFunction()

# name space type: local -> global -> __builtins__

import sys
print(sys.modules)

