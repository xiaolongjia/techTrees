#!C:\Python\Python
#coding=utf-8

'''
Binary Search 

Write a function that takes in a sorted array of integers as well as a target integer. The function should 

use the Binary Search algorithm to determine if the target integer is contained in the array and should return 

its index if it is, otherwise -1. 

Sample Input:
array = [0, 1, 21, 33, 45, 45, 61, 71, 72, 73]
target = 33

Sample Output:
3
'''

# solution 1: O(n) | O(1)
def binarySearch(array, target):
	left = 0
	right = len(array) - 1
	while left <= right :
		middle = (left + right) //2
		if array[middle] > target:
			right = middle - 1
		elif  array[middle] < target:
			left = middle + 1
		else:
			return middle 
	return -1


