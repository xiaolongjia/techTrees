#!C:\Python\Python
#coding=utf-8

'''
Monotonic Array

Write a function that takes in an array of integers and returns a boolean representing whether the array is monotonic.

An array is said to be monotonic if its elements, from left to right, are entirely non-increasing or 
entirely non-decreasing. 

Non-increasing elements aren't necessarily exclusively decreasing; they simply don't increase.
Similarly, non-decreasing elements aren't necessarily exclusively increasing; 
they simply don't decrease. 

Note that empty arrays and arrays of one element are monotonic. 

Sample Input:
array = [-1, -5, -10, -1100, -1100, -1101, -1102, -9001]

Sample Output:
True 
'''

def isMonotonic(array):
    if len(array) <= 2:
        return True 
    direction = array[1] - array[0]
    for i in range(2, len(array)):
        currDirec = array[i] - array[i-1]
        if direction == 0:
            direction = currDirec
            continue 
        elif direction > 0:
            if currDirec < 0:
                return False 
        elif direction < 0:
            if currDirec > 0:
                return False 
    return True 
    