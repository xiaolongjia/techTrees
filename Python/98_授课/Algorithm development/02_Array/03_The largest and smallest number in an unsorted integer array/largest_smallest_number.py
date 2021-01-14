#!C:\Python\Python

def largeAndSmall(list):
    largestNum = smallestNum = list[0]
    for currNum in list:
        if currNum > largestNum:
            largestNum = currNum
        if currNum < smallestNum:
            smallestNum = currNum
    return (largestNum, smallestNum)

myList = [10, 20, 30, 20, 20, 30, 40,50, -20, 60, 60, -20, -20]
print(largeAndSmall(myList))

