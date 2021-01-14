#!C:\Python\Python
#coding=utf-8

# decorators wrap a function, modifying its behavior.
# https://realpython.com/primer-on-python-decorators/
# https://zhuanlan.zhihu.com/p/269012332


#=====================================
# Simple Decorators
#=====================================

def my_decorator(func):
    def wrapper():
        print("Something is happening before the function is called.")
        func()
        print("Something is happening after the function is called.")
    return wrapper

def say_whee():
    print("Whee!")

say_whee = my_decorator(say_whee)
say_whee()


from datetime import datetime 

def not_during_the_neight(func):
    def wrapper():
        if 7 <= datetime.now().hour < 22:
            func()
        else:
            pass
    return wrapper 
            
def say_whee():
    print("WHEE!!!!")

say_whee = not_during_the_neight(say_whee)
say_whee()

#=====================================
# decorator sign '@'
#=====================================

def my_decorator(func):
    def wrapper():
        print("Something is happening before the function is called.")
        func()
        print("Something is happening after the function is called.")
    return wrapper

@my_decorator
def say_whee():
    print("Whee!")

say_whee()

#=====================================
# Using class as decorators
#=====================================

class myDecorator(object):
    def __init__(self, f):
        print("Using class as decorator")
        print ("inside myDecorator.__init__()")
        self.f = f

    def __call__(self):
        print ("inside myDecorator.__call__()")
        self.f()
        print("Using class as decorator End.")

@myDecorator
def aFunction():
    print ("inside aFunction()")

print ("Finished decorating aFunction()")
aFunction()

#=====================================
# decorator without nested function. 
#=====================================

def f1(arg):
    print ("f1")
    rl = arg()
    print (rl)
    return rl + "f1"

@f1
def f2(arg = ""):
    print ("f2")
    return arg + "f2r"

print ("start")
print (f2)

#=====================================
# decorator with arguments 
#=====================================

# example 1

def say_hello(country):
    def wrapper(func):
        def deco(*args, **kwargs):
            if country == "china":
                print("nihao!")
            else:
                print("hello!")
            return func(*args, **kwargs)
        return deco 
    return wrapper 

@say_hello('china')
def china(name):
    print(name)
    
@say_hello("us")
def others(name):
    print(name)

print(china("xiaoming"))
print(others("Tim"))

# example 2

def repeat(num_times):
    def decorator_repeat(func):
        def wrapper_repeat(*args, **kwargs):
            for _ in range(num_times):
                value = func(*args, **kwargs)
            return value
        return wrapper_repeat
    return decorator_repeat
    
@repeat(num_times=4)
def greet(name):
    print(f"Hello {name}")

greet("World")    

#=====================================
# built-in decorator： property
#=====================================
# https://www.freecodecamp.org/news/python-property-decorator/
# https://www.python-course.eu/python3_properties.php

class p:
    def __init__(self,name):
        self.name = name 
    
    @property 
    def name(self):
        print("in getter")
        return self.__name 
    
    @name.setter
    def name(self, name):
        print("in setter")
        self.__name = name 
    
    @name.deleter
    def name(self):
        del self.__name
    
        
aaa = p("haha")
print(aaa.name)

#=====================================
# A Few Real World Examples
#=====================================

# control the run time of a function, raising error when timeout. 

import signal

class TimeoutException(Exception):
    def __init__(self, error='Timeout waiting for response from Cloud'):
        Exception.__init__(self, error)


def timeout_limit(timeout_time):
    def wraps(func):
        def handler(signum, frame):
            raise TimeoutException()

        def deco(*args, **kwargs):
            signal.signal(signal.SIGALRM, handler)
            signal.alarm(timeout_time)
            func(*args, **kwargs)
            signal.alarm(0)
        return deco
    return wraps
    

# Timing Functions / Printing log infornation

import time

def timer(func):
    def wrapper_timer(*args, **kwargs):
        start_time = time.perf_counter()    # 1
        stime = time.time()
        value = func(*args, **kwargs)
        end_time = time.perf_counter()      # 2
        etime = time.time()
        run_time = end_time - start_time    # 3
        rtime = etime - stime
        print(f"Finished {func.__name__!r} in {run_time:.4f} secs")
        print(f"Finished {func.__name__!r} in {rtime:.4f} secs")
        return value
    return wrapper_timer

@timer
def waste_some_time(num_times):
    for _ in range(num_times):
        sum([i**2 for i in range(10000)])
    return "Done"

print(waste_some_time(8))

# Registering Plugins  (not test)

import random
PLUGINS = dict()

def register(func):
    """Register a function as a plug-in"""
    PLUGINS[func.__name__] = func
    return func

@register
def say_hello(name):
    return f"Hello {name}"

@register
def be_awesome(name):
    return f"Yo {name}, together we are the awesomest!"

def randomly_greet(name):
    greeter, greeter_func = random.choice(list(PLUGINS.items()))
    print(f"Using {greeter!r}")
    return greeter_func(name)

#=====================================
# Fancy Decorators
#=====================================

# Decorators on classes
# Several decorators on one function
# Decorators with arguments
# Decorators that can optionally take arguments
# Stateful decorators
# Classes as decorators


