#!C:\python38\python
#coding=utf-8

import os
import time

# 获取当前路径
currDir = os.getcwd()
print(currDir)
# 修改当前路径
os.chdir(r"c:")
print(os.getcwd())
os.chdir(currDir)
print(os.getcwd())
# 获得绝对路径
fileA = os.path.join(os.getcwd(), 'a')
print(fileA)
print(os.path.abspath(fileA))
print("---------------------------------------")
print(os.curdir)
print(os.pardir)

# 删除目录
if os.path.exists('testdir') and os.path.isdir('testdir'):
	os.rmdir('testdir')

if os.path.exists('dirname') and os.path.isdir('dirname'):
	os.rmdir('dirname')

# 创建目录
os.mkdir('dirname')
# 重命名对象(文件或目录)
os.rename("dirname","testdir")
print("---------------------------------------")

# 创建和删除多层空目录
print(os.makedirs('a/b/c/d'))
print(os.removedirs('a/b/c/d'))
print("---------------------------------------")

# 列出目录下所有文件和子目录
allObjects = os.listdir('.')
for i in allObjects:
	print(i)
print("---------------------------------------")

# 判断对象（文件或目录）是否存在： 
if os.path.exists('a'):
	if os.path.isfile('a'):
		#remove file
		os.remove('a')
	if os.path.isdir('a'):
		#remove directory
		os.rmdir('a')
print("---------------------------------------")

# walk() 递归查找所有文件和子目录
try:
    for root, dirs, files in os.walk(r"C:\00\02-FAJob\techTrees\Python"):
        print("%s" % root, "-"*10)
        for directory in dirs:
            print("    %s" % directory)
        for file in files:
            print("    %s" % file)
except OSError as ex:
    print(ex)

# 获得环境变量
print(os.getenv('PATH'))
print(os.environ.get('PATH')) # same
print("---------------------------------------")

# system调用
print(os.system("ipconfig"))

# 当前文件名
print(__file__)
# 当前文件名的绝对路径
print( os.path.abspath(__file__) )
# 返回当前文件的路径
print(os.path.dirname(os.path.abspath(__file__) ))
print("---------------------------------------")

file =  os.path.abspath(__file__)

print( os.path.basename(file) )   # 返回文件名
print( os.path.dirname(file) )    # 返回目录路径
print( os.path.split(file) )      # 分割文件名与路径, 返回包含两个参数(路径，文件名)的tuple 

print( os.path.getatime(file) )   # 输出最近访问时间
print( os.path.getctime(file) )   # 输出文件创建时间
print( os.path.getmtime(file) )   # 输出最近修改时间
print( time.gmtime(os.path.getmtime(file)) )  # 以struct_time形式输出最近修改时间
print( os.path.getsize(file) )   # 输出文件大小（字节为单位）
print( os.path.normpath(file) )  # 规范path字符串形式

print(os.path.exists(os.path.dirname(file))) # 目录是否存在
print(os.path.isfile(file))  #判断是否文件
print(os.path.isdir(file))   #判断是否目录
print(os.path.islink(file))  #判断是否link

print( os.path.join('root','test','runoob.txt') )  # 将目录和文件名合成一个路径

def searchPyFiles (dir, result=[]):
    allPyFiles =  [os.path.join(dir, x) for x in os.listdir(dir) if os.path.isfile(os.path.join(dir, x)) and os.path.splitext(os.path.join(dir, x))[1]=='.py']
    result += allPyFiles
    for x in os.listdir(dir):
        if os.path.isdir(os.path.join(dir, x)):
            searchPyFiles(os.path.join(dir, x), result)
    return result

for i in searchPyFiles("."):
    print(i)


