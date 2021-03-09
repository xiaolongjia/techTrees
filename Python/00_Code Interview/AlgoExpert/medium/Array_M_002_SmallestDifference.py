#!C:\Python\Python
#coding=utf-8

'''
Smallest Difference

Write a function that takes in two non-empty array of integers, finds the pair of 
numbers (one from each array) whose absolute difference is closest to Zero, 
and returns an array containing these two numbers, with the number from the first array 
in the first position. 

Note that the absolute difference of two integers is the distance between them 
on the real number line. For example, the absolute difference of -5 and 5 is 10, and 
the absolute difference of -5 and -4 is 1. 

(remove) You can assume that there will only be one pair of numbers with the smallest difference.

Sample Input:
arrayOne = [-1, 5, 10, 20, 28, 4, 2, 15]
arrayTwo = [26, 134, 135, 15, 17, 4]

Sample Output:
[28, 26]
'''

def smallestDifference(arrayOne, arrayTwo):
    arrayOne.sort()
    arrayTwo.sort()
    result = []
    oneIdx = 0
    twoIdx = 0
    smallest = float("inf")
    current = float("inf")
    while oneIdx < len(arrayOne) and twoIdx < len(arrayTwo):
        firstNum = arrayOne[oneIdx]
        secNum = arrayTwo[twoIdx]
        current = abs(firstNum - secNum)
        if firstNum > secNum:
            twoIdx += 1
        elif firstNum < secNum:
            oneIdx += 1
        else:
            if smallest == 0:
                result.append([firstNum, secNum])
            else:
                smallest = 0
                result = [[firstNum, secNum]]
            oneIdx +=1
            twoIdx +=1
        if current <  smallest:
            smallest = current
            result = [[firstNum, secNum]]
        elif current == smallest and smallest != 0:
            result.append([firstNum, secNum])
            
    return result

arrayOne = [-1, 5, 10, 20, 28, 4, 2, 15]
arrayTwo = [26, 134, 135, 15, 17, 4]
print(smallestDifference(arrayOne, arrayTwo))
