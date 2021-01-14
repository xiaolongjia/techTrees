#!C:\Python\Python

import time

def bubbleSort(list):
    myLong = len(list)
    if myLong <= 1:
        return list

    for i in range(myLong):
        for j in range(myLong-1-i):
            if list[j] > list[j+1]:
                (list[j], list[j+1]) = (list[j+1], list[j])
                time.sleep(1)
    return list

print(bubbleSort([2,32,5,123,2,1,33,6,8,99]))
