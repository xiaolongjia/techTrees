#!C:\Python\Python
#coding=utf-8

'''
PowerSet 

Write a function that takes in an array of unique integers and returns its powerset.

The powerset P(x) of a set x is the set of all subsets of x. For example, the powerset
of [1,2] is [[], [1], [2], [1,2]]. Note that the sets in the powerset do not need to be in any particular order.

Sample Input:
array = [1,2,3]

Sample Output:
[[], [1], [2], [3], [1,2], [1,3], [2,3], [1,2,3]]
'''

def powerset(array):
	subsets = [[]]
	for element in array:
		for i in range(len(subsets)):
			subsets.append(subsets[i] + [element])
	return subsets

'''    
def powerset(array, idx=None):
    if idx is None :
        idx = len(array) - 1
    if idx < 0:
        return [[]]
    element = array[idx]
    subsets = powerset(array, idx - 1)
    for i in range(len(subsets)):
        currSubset = subsets[i]
        subsets.append(currSubset + [element])
    return subsets 
'''
array = [1,2,3]
print(powerset(array))
