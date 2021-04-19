#!C:\Python\Python
#coding=utf-8

'''
First Duplicate Value 

Given an array of integers between 1 and n, inclusive, where n is the length of the 
array, write a function that returns the first integer that appears more than 
once (where the array is read from left to right).

In other words, out of all the integers that might occur more than once in the input array,
your function should return the one whose first duplicate value has the minimum index.

If no integer appears more than once, your function should return -1.

Note that you're allowed to mutate the input array. 

Sample Input:
array = [ 2, 1, 5, 2, 3, 3, 4]

Sample Output:
2
'''


def firstDuplicateValue(array):
    # Write your code here.
	myDict = {}
	for i in array:
		if i in myDict.keys():
			return i
		else:
			myDict[i] = 1
    return -1
    
array = [ 2, 1, 5, 2, 3, 3, 4]
print(firstDuplicateValue(array))

