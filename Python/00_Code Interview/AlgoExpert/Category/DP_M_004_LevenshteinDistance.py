#!C:\Python\Python
#coding=utf-8

'''
Levenshtein Distance

Write a function that takes in two strings and returns the minimum number 
of edit operations that need to be performed on the first string to obtain 
the second string. 

There are three edit operation: Insertion of a character, deletion of a character,
and substitution of a character for another. 

Sample Input:
str1 = "abc"
str2 = "yabd"
  
Sample Output: 
2 // insert "y"; substitute "c" for "d"
'''

def levenshteinDistance(str1, str2):
	memo = dict()
	return findEditDistance(str1, str2, memo, len(str1)-1, len(str2)-1)

def findEditDistance(str1, str2, memo, idx1, idx2):
	if (idx1, idx2) in memo.keys():
		return memo[(idx1, idx2)]
	if idx1 == -1:
		return idx2+1
	if idx2 == -1:
		return idx1+1
	if str1[idx1] == str2[idx2]:
		memo[(idx1, idx2)] = findEditDistance(str1, str2, memo, idx1-1, idx2-1)
	else:
		memo[(idx1, idx2)] =  min(findEditDistance(str1, str2, memo, idx1-1, idx2)+1, findEditDistance(str1, str2, memo, idx1, idx2-1)+1, findEditDistance(str1, str2, memo, idx1-1, idx2-1)+1)
    return memo[(idx1, idx2)]

str1 = "today is good day"
str2 = "good morning!"
print(levenshteinDistance(str1, str2))

