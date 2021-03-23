#!C:\Python38\Python
#coding=utf-8

'''
Sorted Squared Array

Write a function that takes in a non-empty array of integers that are sorted in 
ascending order and returns a new array of the same length with the squares of the 
original integers also sorted in ascending order. 

Sample Input:
array = [1, 2, 3, 4, 5, 6, 8, 9]

Sample Output:
[1, 4, 9, 16, 25, 36, 64, 81]
'''

# solution 1: O(n) | O(n)
def sortedSquaredArray(array):
	sortedQueue = [0 for _ in array]
	leftIdx = 0
	rightIdx = len(array) - 1
	for currIdx in reversed(range(len(array))):
		leftValue = array[leftIdx]
		rightValue = array[rightIdx]
		if abs(leftValue) > abs(rightValue):
			sortedQueue[currIdx] = leftValue * leftValue
			leftIdx += 1
		else:
			sortedQueue[currIdx] = rightValue * rightValue
			rightIdx -=1 
	return sortedQueue

array = [-3, -2, -1, 0, 1, 3, 4, 8, 10]
print(sortedSquaredArray(array))