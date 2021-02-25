#!C:\python38\Python
#coding=utf-8


# https://foofish.net/iterators-vs-generators.html
# https://foofish.net/what-is-python-generator.html
# https://lotabout.me/2017/Python-Generator/


#=======================
# Container 
#=======================
# list, deque, ....
# set, frozensets, ....
# dict, defaultdict, OrderedDict, Counter, ....
# tuple, namedtuple, …
# str


#=======================
# iterable object 
#=======================
# iterable object like list, dictionary has function __iter__

x = [1, 2, 3]
y = iter(x)   # iter(object[, sentinel]), iter() used to create iterator, 
z = iter(x)
print(next(y))
print(next(y))
print(next(z))
print(type(x)) # <class 'list'>
print(type(y)) # <class 'list_iterator'>

#=======================
# iterator
#=======================
# iterator has __iter__ and __next__

# itertools provider many iterators. 
# https://docs.python.org/zh-cn/3/library/itertools.html
from itertools import count, cycle, islice

counter = count(start=13)
print(next(counter)) # 13
print(next(counter)) # 14

colors = cycle(['red', 'white', 'blue'])
print(next(colors)) # 'red'
print(next(colors)) # 'white'
print(next(colors)) # 'blue'
print(next(colors)) # 'red'

print("=========================")
newcolors = cycle(['red', 'white', 'blue'])
limited = islice(newcolors, 0, 4) 
for x in limited: 
    print(x)



# self-defined iterator 
class fib():
    def __init__(self):
        self.prev = 0
        self.curr = 1
    
    def __iter__(self):
        return self
        
    def __next__(self):
        value = self.curr
        self.curr += self.prev
        self.prev = value 
        return value

f = fib()
print(list(islice(f, 0, 10)))

#=======================
# yield
#=======================

# https://blog.csdn.net/mieleizhi0522/article/details/82142856

print("yield")
def foo():
    print("starting...")
    while True:
        res = yield 4
        print("res:",res)
g = foo()
print("*****")
print(next(g))
print("*****")
print(next(g))


#=======================
# generator
#=======================

# self-defined generator 
print("self-defined generator")
def fib2():
    prev, curr = 0, 1
    while True:
        yield curr
        prev, curr = curr, curr + prev
        
f = fib2()
print(list(islice(f, 0, 10)))

print("self-defined generator2")
def fib3(n):
    pre, curr = 0, 1
    while n > 0: 
        n -= 1
        yield curr 
        pre, curr = curr, curr+pre 

print([i for i in fib3(10)])

print("self-defined generator3")
def func(n):
    value = n
    while True:
        yield value*value
        value += 1

f = func(4)
print(next(f))
print(next(f))
print(next(f))

#=======================
# generator comprehension
#=======================
print("generator comprehension")
g = (x*2 for x in range(10))
print(next(g))
print(next(g))
print(next(g))
print(next(g))

#=======================
# Code compare 
#=======================
# using generator 
def fibonacci():
    a, b = (0, 1)
    while True:
        yield a
        a, b = b, a+b

fibos = fibonacci()
next(fibos) #=> 0
next(fibos) #=> 1
next(fibos) #=> 1
next(fibos) #=> 2

#not using generator
class Fibonacci():
    def __init__(self):
        self.a, self.b = (0, 1)
    def __iter__(self):
        return self
    def __next__(self):
        result = self.a
        self.a, self.b = self.b, self.a + self.b
        return result

fibos = Fibonacci()
next(fibos) #=> 0
next(fibos) #=> 1
next(fibos) #=> 1
next(fibos) #=> 2

#=======================
# yield from 
#=======================

# without yield from 
def odds(n):
    for i in range(n):
        if i % 2 == 1:
            yield i

def evens(n):
    for i in range(n):
        if i % 2 == 0:
            yield i

def odd_even(n):
    for x in odds(n):
        yield x
    for x in evens(n):
        yield x

for x in odd_even(6):
    print(x)
#=> 1, 3, 5, 0, 2, 4

#with yield from 
def odd_even2(n):
    yield from odds(n)
    yield from evens(n)



myData = [2, 3, 5, 4, 9]
myIterator = iter(myData)
print(myIterator)
print(next(myIterator))
print(next(myIterator))
print(next(myIterator))


class Mynumber :

    def __init__(self, number):
        self.a = number 

    def __iter__ (self):
        return self
        
    def __next__(self):
        if self.a <= 20:
            x = self.a
            self.a += 1
            return x
        else:
            raise StopIteration
    
    def __call__(self):
        print("myself call")

myNumber = Mynumber(10)
#myNumber()
myNumber.__call__()
#myIter = iter(myNumber)
#print(next(myIter))
myIter = myNumber.__iter__()
print(myIter.__next__())



for i in myIter:
    print(i)


