#!C:\Python\Python

import os

name = "./test"

if os.path.exists(name):
    if os.path.isdir(name):
        os.rmdir(name)
    elif os.path.isfile(name):
        os.remove(name)
    else:
        print("Cannot identify ", name)

os.mkdir(name)
print(os.getcwd())
print(os.getenv("PATH"))
print(os.getlogin())

for root, dirs, files in os.walk(".", topdown=False):
    print("--")
    for name in files:
        print(os.path.join(root, name))
    for name in dirs:
        print(os.path.join(root, name))


print("-"*20)
if os.access(r".\test.txt", os.R_OK):
    with open(r".\test.txt") as fp:
        print(fp.read())
print("-"*20)

