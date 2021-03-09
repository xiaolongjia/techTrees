#!C:\Python\Python
#coding=utf-8

'''
Permutations 

Write a function that takes in an array of unique integers and returns an array of all 
permutations of those integers in no particular order. 

If the input array is empty, the function should return an empty array. 

Sample Input:
array = [1,2,3]

Sample Output:
[[1,2,3], [1,3,2], [2,1,3], [2,3,1], [3,1,2], [3,2,1]]
'''

def getPermutations(array):
    permutations = []
    getPermutationsAction(array, [], permutations)
    return permutations
    
def getPermutationsAction(array, currPermutation, permutations):
    if not len(array) and len(currPermutation):
        permutations.append(currPermutation)
    else:
        for i in range(len(array)):
            newArray = array[:i] + array[i+1:]
            newPermutation = currPermutation + [array[i]]
            getPermutationsAction(newArray, newPermutation, permutations)

array = [1,2,3, 4, 5]
print(len(getPermutations(array)))
