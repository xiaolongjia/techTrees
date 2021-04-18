#!C:\Python\Python
#coding=utf-8

'''
First Non-Repeating Character 

Write a function that takes in a string of lowercase English-alphabet letters 
and returns the index of the string's first non-repeating character.

The first non-repeating character is the first character in a string 
that occurs only once. If the input string does not have any non-repeating
characters, your function should return -1.

Sample Input:
string = "abcdcaf"

Sample Output:
1
'''

def firstNonRepeatingCharacter(string):
	characterFreq = {}
	for i in string:
		characterFreq[i] = characterFreq.get(i, 0) + 1
	for idx in range(len(string)):
		key = string[idx]
		if characterFreq[key] == 1:
			return idx
	return -1
 

string = "abcdcaf"
print(firstNonRepeatingCharacter(string)

