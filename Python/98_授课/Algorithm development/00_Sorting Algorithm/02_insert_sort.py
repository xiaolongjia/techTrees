#!C:\Python\Python

import time

def insertSort(list):
    myLength = len(list)
    if myLength <= 1:
        return list

    for i in range(1, myLength):
        j = i 
        target = list[i]
        while (j>0 and target < list[j-1]):
            list[j] = list[j-1]
            j -=1
        list[j] = target
    return list

myList = [10,2,5,3,18,9,1500,232]
print(myList)
print(insertSort(myList))



