#!C:\Python\Python
#coding=utf-8

'''
Search in Sorted Matrix  

You are given a two-dimensional array (a matrix) of distinct integers and a target integer 
Each row in the matrix is sorted, and each column is alse sorted; the matrix doesnot 
necessarily have the same height and width 

Write a function that returns an array of the row and column indices of the target integer 
if its contained in the matrix, otherwise [-1, -1]

Sample Input:
matrix  =
[1, 4, 7, 12, 15, 1000],
[2, 5, 19, 31, 32, 1001],
[3, 8, 24, 33, 35, 1002],
[40, 41, 42, 44, 45, 1003],
[99, 100, 103, 106, 128, 1004],
]
target = 44

Sample Output:
[[3, 3]]
'''

def searchInSortedMatrix(matrix, target):
	row = 0
	col = len(matrix[0]) - 1
	while row < len(matrix) and col >= 0:
		val = matrix[row][col]
		if val == target:
			return [row, col]
		elif val > target:
			col -= 1
		else:
			row += 1
	return [-1, -1]


matrix  = [
[1, 4, 7, 12, 15, 1000],
[2, 5, 19, 31, 32, 1001],
[3, 8, 24, 33, 35, 1002],
[40, 41, 42, 44, 45, 1003],
[99, 100, 103, 106, 128, 1004]
]
target = 44

print(searchInSortedMatrix(matrix, target))


