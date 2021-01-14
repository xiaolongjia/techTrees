#!C:\Python\Python
#coding=utf-8

# https://dbader.org/blog/python-first-class-functions

#=====================================
# Functions Are Objects 
#=====================================

def yell(text):
    return text.upper() + '!'

bark = yell 
print(bark("wowo!!"))

del yell 
# print(yell("wowo!!")) -- NameError: name 'yell' is not defined 
print(bark("wowo!!")) # still works. 
print(bark.__name__)

#=====================================
# Functions Can Be Stored In Data Structures 
#=====================================

anythings = [bark, {"sound":bark}]
print(anythings)

#=====================================
# Functions Can Be Passed To Other Functions
#=====================================

# pass function to another function 
def greet(func):
    greeting = func('Hi, I am a Python program')
    print(greeting)

greet(bark)

def whisper(text):
    return text.lower() + '...'
    
greet(whisper)

# map function 
print(list(map(bark, ['hello', 'hey', 'hi'])))

#=====================================
# Functions Can Be Nested
#=====================================

def speak(text):
    def whisper(t):
        return t.lower() + '...'
    return whisper(text)

print(speak("hi"))

# two nested functions 

def get_speak_func(volume):
    def whisper(text):
        return text.lower() + '...'
    def yell(text):
        return text.upper() + '!'
    if volume > 0.5:
        return yell
    else:
        return whisper

speakFunc = get_speak_func(0.2)
print(speakFunc("hi"))
print(get_speak_func(2)("hi"))

# function closures example

def get_speak_func2(text, volume):
    def whisper():
        return text.lower() + '...'
    def yell():
        return text.upper() + '!'
    if volume > 0.5:
        return yell
    else:
        return whisper

print(get_speak_func2('Hello, World', 0.7)())

#=====================================
# Objects Can Behave Like Functions
#=====================================

class Adder:
    def __init__(self, n):
         self.n = n
    def __call__(self, x):
        return self.n + x

obj = Adder(3)
print(obj(4)) # equal to obj.__call__(4)
print(obj.__call__(4))
