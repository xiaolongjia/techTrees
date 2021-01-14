#!C:\Python\Python
#coding=utf-8

'''
Longest Palindromic Substring

Write a function that, given a string, returns its longest palindromic substring.

You can assuem that there will only be one longest palindromic substring. 

Sample Input:
string = "abaxyzzyxf"

Sample Output:
"xyzzyx"
'''

def longestPalindromicSubstring(string):
	longestString = "" 
	if len(string) == 2:
		if string[0] == string[1]:
			return string 
	elif len(string) < 2:
		return string 
	else :
		i = 1
		while i < len(string) - 1:
			if string[i-1] == string[i+1]:
				start, end  = findPalindromic(string, i-1, i+1)
				if len(longestString) < end -1 - start - 1 + 1:
					longestString = string[start+1:end]
			if string[i] == string[i+1]:
				start, end  = findPalindromic(string, i, i+1)
				if len(longestString) < end -1 - start - 1 + 1:
					longestString = string[start+1:end]
			i+=1 
		return longestString

def findPalindromic(string, start, end):
    while start >=0 and end < len(string):
        if string[start] == string[end]:
            start -= 1
            end += 1
        else:
            break 
    return start, end 

string = "zz2345abbbba5432zz"
print(longestPalindromicSubstring(string))

