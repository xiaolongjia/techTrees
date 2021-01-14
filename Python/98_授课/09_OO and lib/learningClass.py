#!C:\Python\Python

class Student:
    number = 0

    def __init__ (self, name, age):
        self.name = name
        self.age = age
        self.__score = 0 # private attribute
        Student.number += 1

    def show (self):
        print("name: {}, age: {}, score: {}".format(self.name, self.age, self.__score))
    
    def __show (self): # private method just can be called by internal methods
        print("name: {}, age: {}, score: {}".format(self.name, self.age, self.__score))

    # define class method: (can only be called by Class)
    @classmethod
    def total(cls):
        print("total: {}".format(cls.number))

    # define static method: (can be called by both Class and Instance)
    @staticmethod
    def stotal(number):
        print("stotal: {}".format(number))

    # use property to pretend function to attribute
    @property
    def score(self):
        print("score: {}".format(self.__score))


s1 = Student("Chris", 8)
s1.age = 12
s1.show()
s2 = Student("Jack", 7)
print(Student.number)
print(s1.__class__.number)
print(s2.__class__.number)
Student.total()
print("static total")
Student.stotal(9)
s1.stotal(8)

#print(s1.__score)
#s1.__show()
s1.score # not s1.score()

#------------------------------------------------------------
# Inheritance
#------------------------------------------------------------

class SchoolMember: # parent class

    def __init__ (self, name, age):
        self.name = name
        self.age = age

    def tell(self):
        print("name: {}, age: {}".format(self.name, self.age))


class Teacher(SchoolMember): # child class

    def __init__ (self, name, age, salary):
        SchoolMember.__init__(self, name, age)
        self.salary = salary

    def tell(self): # re-write parent class's method
        SchoolMember.tell(self)
        # or 
        super().tell() # super() is parent class
        print("salary: {}".format(self.salary))

class SchoolStudent(SchoolMember): # child class

    def __init__ (self, name, age, score):
        SchoolMember.__init__(self, name, age)
        self.score = score

    def tell(self): # re-write parent class's method
        SchoolMember.tell(self)
        # or 
        super().tell()
        print("score: {}".format(self.score))

teacher1 = Teacher("Joe", 43, 3800)
student1 = SchoolStudent("Chris", 8, 0)
teacher1.tell()
student1.tell()

