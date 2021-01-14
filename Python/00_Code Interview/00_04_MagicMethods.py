#!C:\Python\Python
#coding=utf-8

#============================================
# Magic Methods
#============================================

# __new__()
# __init__()

class employee:
    def __new__(cls):
        print("__new__ magic method is called") # cls is class 
        inst = object.__new__(cls) # inst is instance of class employee 
        return inst
        
    def __init__(self):
        print("__init__ magic method is called")
        self.name = "Tim" 
        self.age = 42
myEmployee = employee()

# __str__()

class employee:        
    def __init__(self, name, age):
        print("__init__ magic method is called")
        self.name = name 
        self.age = age

    
    def __str__(self):
        return "name: {} age: {}".format(self.name, self.age)

myEmployee = employee("Tim", 42)
print(myEmployee) # default value without overriding __str__:  <__main__.employee object at 0x0000000002851F08>
