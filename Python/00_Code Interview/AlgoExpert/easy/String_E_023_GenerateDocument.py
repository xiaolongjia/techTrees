#!C:\Python\Python
#coding=utf-8

'''
Generate Document 

You're given a string of available characters and a string representing a document 
that you need to generate. Write a function that determines if you can generate the document 
using the available characters. If you can generate the document, return true;
otherwise, return false. 

You're only able to generate the document if the frequency of unique characters 
in the characters string is greater than or equal to the frequency of unique characters in the document 
string. For example, if you're given characters = "abcabc" and document="aabbccc"
you cannot generate the document because you're missing one c.

The document that you need to create may contain any characters, including special 
characters, capital letters, numbers, and spaces. 

Note: you can always generate the empty string ('')


Sample Input:
characters = "Bste!hetsi ogEAxpelrt x "
document = "AlgoExpert is the Best!"

Sample Output:
true
'''

def generateDocument(characters, document):
    # Write your code here.
	charDict = {}
	for i in characters:
		if i in charDict:
			charDict[i] += 1
		else:
			charDict[i] = 1
	
	for j in document:
		if j not in charDict or charDict[j]==0:
			return False 
		else:
			charDict[j] -= 1
	
    return True 
 
characters = "Bste!hetsi ogEAxpelrt x "
document = "AlgoExpert is the Best!"
print(generateDocument(characters, document)

