#!C:\Python38\Python
#coding=utf-8

'''
Write a function that takes in a non-empty array of distinct integers and an integer 
representing a target sum. 

If any two numbers in the input array sum up to the target sum, the function should return them in an array, in any order. If no two numbers sum up to the target sum, the function should return an empty array.

Note that the target sum has to be obtained by summing two different integers in the array;
you cannot add a single integer to itself in order to obtain the target sum.

You can assume that there will be at most one pair of numbers summing up to the target sum.

Sample Input
array = [3, 5, -4, 8, 11, 1, -1, 6]
targetSum = 10

Sample Output: 
[-1, 11]
'''

#solution 1
def twoNumberSum1 (array, targetNum):
    for i in range(len(array) - 1):
        firstNum = array[i]
        for j in range(i+1, len(array)):
            secondNum = array[j]
            if firstNum + secondNum == targetNum:
                return [firstNum, secondNum]
    return []
    
#solution 2
def twoNumberSum2 (array, targetNum):
    myHash = {}
    for num in array:
        secNum = targetNum - num 
        if secNum in myHash:
            return [secNum, num]
        else:
            myHash[num] = True
    return []

#solution 3
def twoNumberSum3 (array, targetNum):
    array.sort()
    left = 0
    right = len(array) - 1
    while left < right:
        currSum = array[left] + array[right]
        if currSum == targetNum:
            return [array[left] , array[right]]
        elif currSum > targetNum:
            right -= 1
        else:
            left += 1
    return []
    
            
