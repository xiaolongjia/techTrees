#!C:\Python\Python
#coding=utf-8

'''
Three Number Sum 

Write a function that takes in a non-empty array of distinct integers and an integers
representing a target sum. The function should find all triplets in the array that sum up to 
the target sum and return a two-dimensional array of all these triplets. The numbers in each triplet
should be ordered in ascending order. and the triplets themselves should be ordered 
in ascending order with respect to the numbers they hold. 

if no three numbers sum up to the target sum, the function should return an empty array. 

Sample Input:
array = [12, 3, 1, 2, -6, 5, -8, 6]
targetSum = 0

Sample Output:
[[-8, 2, 6], [-8, 3, 5], [-6, 1, 5]]
'''

def threeNumberSum(array, targetSum):
	array.sort()
	result = []
	for i in range(len(array)):
		left = i+1
		right = len(array)-1
		while left < right:
			currSum = array[left] + array[right] + array[i]
			if currSum > targetSum:
				right -=1
			elif currSum < targetSum:
				left +=1
			else:
				result.append([array[i], array[left], array[right]])
				left += 1
				right -= 1
	return result