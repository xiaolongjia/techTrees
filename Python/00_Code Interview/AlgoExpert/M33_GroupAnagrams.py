#!C:\Python\Python
#coding=utf-8

'''
Group Anagrams

Write a function that takes in an array of strings and groups anagrams together.

Anagrams are strings made up of exactly the same letters, where order doesn't matter.

For example, "cinema" and "iceman" are anagrams; similarly, "foo" and "ofo" are anagrams.

Your function should return a list of anagram groups in no particular order. 

Sample Input:
words = ["yo", "act", "flop", "tac", "foo", "cat", "oy", "olfp"]

Sample Output:
[["yo","oy"],["flop","olfp"],["act","tac","cat"],["foo"]]
'''

def groupAnagrams(words):
	anagrams = {}
	for i in words:
		sortedString = "".join(sorted(i))
		if sortedString in anagrams.keys():
			anagrams[sortedString].append(i)
		else :
			anagrams[sortedString] = [i]   
	return list(anagrams.values())

words = ["yo", "act", "flop", "tac", "foo", "cat", "oy", "olfp"]
print(groupAnagrams(words))

