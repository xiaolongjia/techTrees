#!C:\Python\Python
#coding=utf-8

# https://pythonspot.com/encapsulation/


# Inheritance allows us to define a class that inherits all the methods and properties from another class.

# Parent class is the class being inherited from, also called base class.
# Child class is the class that inherits from another class, also called derived class.

class Person:
    def __init__(self, fname, lname):
        self.firstname = fname
        self.lastname = lname

    def printname(self):
        print(self.firstname, self.lastname)
    
class Student(Person):
    pass 

stu = Student("Jack", "Jia")
stu.printname()

# Polymorphism means the ability to take multiple forms
# In Python, Polymorphism allows us define methods in the child class that have the same name as the methods in the parent class.  
# This process of re-implementing a method in the child class is known as Method Overriding.

class Bird: 
    def intro(self): 
        print("There are many types of birds.") 
      
    def flight(self): 
        print("Most of the birds can fly but some cannot.") 
    
class sparrow(Bird): 
    def flight(self): 
        print("Sparrows can fly.") 
      
class ostrich(Bird): 
    def flight(self): 
        print("Ostriches cannot fly.") 

objBird = Bird()
objOstrich = ostrich()
objBird.flight()
objOstrich.flight()

# In python, abstraction can be implemented by creating abstract classes and methods. 
# class ABC help to create a abstract class.  
# abstract decorator 'abstractrmethod' help to indicate abstract methods

from abc import ABC, abstractmethod 

class People(ABC):
    @abstractmethod
    def walk(self):
        pass
        
    @abstractmethod
    def eat(self):
        pass        

    def dance(self):
        print("people is dancing")

class me(People):
    
    def walk(self):
        print("I am walking")
        
    def eat(self):
        print("I am eating")
    
    pass

myself = me()
myself.walk()

# Encapsulation 

'''
1) What is Encapsulation in Python?

Encapsulation in Python is the process of wrapping up variables and methods into a single entity. 
In programming, a class is an example that wraps all the variables and methods defined inside it.

2) How can we achieve Encapsulation in Python?

In Python, Encapsulation can be achieved using Private and Protected Access Members.

3) How can we define a variable as Private?

In Python, Private variables are preceded by using two underscores.

4) How can we define a variable as Protected?

In Python, Protected variables are preceded by using a single underscore.
'''

class money:
    def __init__(self):
        self.__money=100   # private variable 
        
    def  __getmoney(self): # private method 
        print("getmoney")
        return self.__money
        
    def show(self):
        print(self.__money)
 
aa = money()
print(dir(aa))

aa._money__money=100000  # access private variable 
aa._money__getmoney()   
aa.show()

