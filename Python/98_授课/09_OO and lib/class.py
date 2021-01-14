#!C:\Python\Python

#-----------------------
# global, nonlocal
#-----------------------

def scope_test():
    def do_local():
        spam = "local spam"

        def mycall():
            nonlocal spam
            print("mycall spam is:", spam)

        mycall()

    def do_nonlocal():
        nonlocal spam
        spam = "nonlocal spam"

    def do_global():
        global spam
        spam = "global spam"

    spam = "test spam"
    do_local()
    print("After local assignment:", spam)
    do_nonlocal()
    print("After nonlocal assignment:", spam)
    do_global()
    print("After global assignment:", spam)

scope_test()
print("In global scope:", spam)

#-----------------------
# class
#-----------------------

class myComplex:

    tricks = []             # mistaken use of a class variable. a class variable is shared by all instances.

    def __init__ (self, x, y):
        self.r = x
        self.i = y 
        self.tricks = []     # correct way to set a instance variable

    def myPrint(self, message):
        print("**************", message)

x = myComplex(-30, 200)
print(x.r)
print(x.i)

pp = x.myPrint
print(pp)

#-----------------
# class variable and instance variable searching order
#-----------------
# If the same attribute name occurs in both an instance and in a class, then attribute lookup prioritizes the instance:
class Warehouse:
    purpose = "storage"
    region = "west"

w1 = Warehouse()
print (w1.purpose, w1.region)

w2 = Warehouse()
w2.region = "east"
print(w2.purpose, w2.region)


#--------------------
# inheritance
#--------------------

#class business (Warehouse, myComplex):


#---------------
# Iterators, iterable, iter() and next()
#---------------

class Reverse:
    """Iterator for looping over a sequence backwards."""
    def __init__(self, data):
        self.data = data
        self.index = len(data)

    def __iter__(self):
        return self

    def __next__(self):
        if self.index == 0:
            raise StopIteration
        self.index = self.index - 1
        return self.data[self.index]


rev = Reverse("spam")
iter(rev)
for m in rev:
    print(m)

print(sum(i*i for i in range(10)))
