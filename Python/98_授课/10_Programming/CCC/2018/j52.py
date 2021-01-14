#!C:\Python\Python

def getDepth(currPage, options, depth):
    if isinstance(options, list):
        depth += 1
        for i in options:
            if i not in dataTree:
                dataTree[i] = None
            getDepth(i, data[i-1], depth)
    else:
        print(currPage, " is an ending page!")
        print("depth is: ", depth)
        if currPage not in dataTree:
            dataTree[currPage] = depth
        else:
            lastPath = dataTree[currPage]
            if lastPath is None or lastPath > depth:
                dataTree[currPage] = depth

#==================================
# Data Init
#==================================
length = int(input())
data = list()
for i in range(length):
    inputStr = input()
    currData = list(map(int, inputStr.split(" ")))
    if len(currData) >  1:
        data.append(currData[1:])
    else:
        data.append(currData[0])

print(data)

#==================================
# Calculating...
#==================================
dataTree = dict()
if isinstance(data[0], list):
    dataTree[1] = None
    getDepth(1, data[0], 1)
else:
    dataTree[1] = 1
    if length == 1:
        print("Y")
    else:
        print("N") 
    print("1")
    exit()

print(dataTree)


