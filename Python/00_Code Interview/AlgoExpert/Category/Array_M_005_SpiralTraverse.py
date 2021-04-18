#!C:\Python\Python
#coding=utf-8

'''
Spiral Traverse

Write a function that takes in an n x m two-dimensional array (that can be 
square-shaped when n == m) and returns a one-dimensional array of all the 
array's elements in spiral order. 

Spiral order starts at the top left corner of the two-dimensional array, goes to 
the right, and proceeds in a spiral pattern all the way until every element has been visited. 

Sample Input:
array = [
    [ 1,  2,  3, 4],
    [12, 13, 14, 5],
    [11, 16, 15, 6],
    [10,  9,  8, 7]
]

Sample Output:
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16] 
'''

def spiralTraverse(array):
	result = []
	startCol, endCol = 0, len(array[0])-1
	startRow, endRow = 0, len(array)-1
	while startCol <= endCol and startRow <= endRow:
		for col in range(startCol, endCol+1):
			result.append(array[startRow][col])
		for row in range(startRow+1, endRow+1):
			result.append(array[row][endCol])
		for col in reversed(range(startCol, endCol)):
			if startRow == endRow:
				break
			result.append(array[endRow][col])
		for row in reversed(range(startRow+1, endRow)):
			if startCol == endCol:
				break
			result.append(array[row][startCol])
		startCol+=1
		endCol -=1
		startRow+=1
		endRow -=1
		print(result)
	return result 
    
matrix = [[1, 2, 3, 4, 5], [16,17,18,19,6], [15,24,25,20,7],[14,23,22,21,8],[13,12,11,10,9]]
print(spiralTraverse(matrix))

