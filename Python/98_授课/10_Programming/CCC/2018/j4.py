#!C:\Python\Python

def rollingover(data, n):
    for i in range(n):
        if i == n-1:
            break
        for c in range(i+1, n):
            data[i][c], data[c][i] = data[c][i], data[i][c]
    return(data)

def rollingoverWithZip(data, n):
    tmp=list()
    for i in zip(*data):
        tmp.append(list(i))
    #data = list(map(list,zip(*data[::-1])))
    return(tmp)

def clockwiseRotation(data, n):
    rollingover(data, n)
    for i in range(n):
        for j in range(int(n/2)):
            data[i][j], data[i][n-1-j] = data[i][n-1-j], data[i][j]
    return data

def counterclockwiseRoataion(data, n):
    rollingover(data, n) 
    for i in range(int(n/2)): 
        data[i], data[n-1-i] = data[n-1-i], data[i]
    return data

arrayLength = int(input())
data = list()

for i in range(arrayLength):
    inputStr = input()
    currData = list(map(int, inputStr.split(" ")))
    data.append(currData)

print(data)
n = arrayLength-1
topLeft = data[0][0]
topRight = data[0][n]
botLeft = data[n][0]
botRight = data[n][n]

minData = min(topLeft, topRight, botLeft, botRight)

if minData == topLeft:
    print("no need rotation!")
elif minData == topRight:
    print("counter-clockwise rotation!")
    print(counterclockwiseRoataion(data, arrayLength))
elif minData == botLeft: 
    print("clockwise rotation!")
    print(clockwiseRotation(data, arrayLength))
else:
    print("clockwise rotation!")
    print("clockwise rotation!")
    clockwiseRotation(data, arrayLength)
    clockwiseRotation(data, arrayLength)
    print(data)

    # or
    # counterclockwiseRoataion(data, arrayLength)
    # counterclockwiseRoataion(data, arrayLength)

