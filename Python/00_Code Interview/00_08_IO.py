#!C:\Python38\Python
#coding=utf-8

import os
import pickle
import json

def searchPyFiles (dir, result=[]):
    allPyFiles =  [os.path.join(dir, x) for x in os.listdir(dir) if os.path.isfile(os.path.join(dir, x)) and os.path.splitext(os.path.join(dir, x))[1]=='.py']
    result += allPyFiles
    for x in os.listdir(dir):
        if os.path.isdir(os.path.join(dir, x)):
            searchPyFiles(os.path.join(dir, x), result)
    return result

for i in searchPyFiles("."):
    print(i)

print(os.name)
print(os.environ)

# os.path functions: abspath(), join(), split(), isdir(), isfile(), splitext()
print(os.path.abspath('.'))
currPath = os.path.abspath('.')
os.mkdir(os.path.join(currPath, 'testdir')) # do not connect string because of separator difference for os
os.rmdir(os.path.join(currPath, 'testdir'))
print(os.path.split(currPath))
childDir = [x for x in os.listdir('.') if os.path.isdir(x)]
print(childDir)
allPyFiles =  [x for x in os.listdir('.') if os.path.isfile(x) and os.path.splitext(x)[1]=='.py']
print(allPyFiles)

# with open()
# read(), readline(), readlines()
with open('./pdTestData.txt', 'r', encoding='gbk', errors='ignore') as f:
    #print(f.read()) # all contents 
	
	#read data one by one
    line = f.readline()
    while (line):
        print(line)
        line = f.readline()

	# all contents in list
    for line in f.readlines(): 
        print(line.strip())
	
# pickle, dumps(), dump(), load()
d = dict(name='Bob', age=20, score=88)
print(pickle.dumps(d))

with open('00_08_IO_pickle.txt', 'wb') as f:
    pickle.dump(d, f)

with open('00_08_IO_pickle.txt', 'rb') as f:
    e = pickle.load(f)
print(d)
print(e)

# json 
d = dict(name='Bob', age=20, score=88)
print(json.dumps(d))
json_str = '{"age": 20, "score": 88, "name": "Bob"}'
print(json.loads(json_str))


class Student(object):
    def __init__(self, name, age, score):
        self.name = name
        self.age = age
        self.score = score


def student2dict(self):
    return {'name':self.name, 'age':self.age, 'score':self.score}


s = Student('Bob', 20, 88)
print(json.dumps(s, default=student2dict))
print(json.dumps(s, default=lambda obj: obj.__dict__))
