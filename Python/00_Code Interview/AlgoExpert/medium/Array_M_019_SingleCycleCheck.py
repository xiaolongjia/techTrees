#!C:\Python\Python
#coding=utf-8

'''
Single Cycle Check 

You are given an array of integers where each integer represents a jump of its value 
in the array. For instance, the integer 2 represents a jump of two indices forward 
in the array; the integer -3 represents a jump of three indices backward in the array. 

If a jump spills past the array's bounds, it wraps over to the other side. for instance, a jump 
of -1 at index 0 brings us to the last index in the array. Similarly, a jump of 1
at the last index in the array brings us to index 0.

Write a function that returns a boolean representing whether the jumps in the array form 
a sing cycle. A single cycle occurs if, starting at any index in the array and following the jumps, 
every element in the array is visited exactly once before landing back on the starting index.

Sample Input:
array = [2, 3, 1, -4, -4, 2]
  
Sample Output: 
true 
'''

def hasSingleCycle(array):
	loop = 0
	visited = [0]
	nextTo = 0
	while loop < len(array):
		nextTo = moveToNext(array, nextTo)
		print("loop: {}, nextTo: {}".format(loop, nextTo))
		if nextTo not in visited:
			visited.append(nextTo)
		loop+=1
	return len(visited) == len(array) and nextTo ==0

def moveToNext(array, index):
	jumpSteps = array[index]
	nextTo = (index + jumpSteps) % len(array)
	return nextTo if nextTo >=0 else nextTo + len(array)

#array = [3, 5, -9, 1, 3, -2, 3, 4, 7, 2, -9, 6, 3, 1, -5, 4]
array = [2, 3, 1, -4, -4, 2]
print(hasSingleCycle(array))

