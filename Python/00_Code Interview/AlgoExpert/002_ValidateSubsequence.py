#!C:\Python\Python
#coding=utf-8

'''
Given two non-empty arrays of integers, write a function that determines whether the second array is a subsequence of the first one. 

A subsequence of an array is a set of numbers that aren't necessarily adjacent in the array but that are in the same order as they appear in the array. 
For instance, the numbers [1,3,4] from a subsequence of the array [1,2,3,4], and so do the numbers [2, 4]. 

Note that a single number in an array and the array itself are both valid subsequences of the array. 

Sample input:
array = [5, 1, 22, 25, 6, -1, 8, 10]
sequence = [1,6, -1, 10]

Sample output:
true
'''

#solution 1
def isValidSubsequence(array, sequence):
    arrayIdx = 0
    seqIdx = 0
    while arrayIdx < len(array) and seqIdx < len(sequence):
        if sequence[seqIdx] == array[arrayIdx]:
            seqIdx +=1
        arrayIdx += 1
    return seqIdx == len(sequence)
    
#solution 2
def isValidSubsequence(array, sequence):
	seqIndex = 0
	for i in array:
		if seqIndex == len(sequence):
			break
		if i == sequence[seqIndex]:
			seqIndex += 1
		
    return seqIndex == len(sequence)

