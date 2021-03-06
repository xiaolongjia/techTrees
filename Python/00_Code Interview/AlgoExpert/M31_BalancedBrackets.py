#!C:\Python\Python
#coding=utf-8

'''
Balanced Brackets

Write a function that takes in a string made up of brackets (, [, {,),],}
and other optional characters. The function should return a boolean representing 
whether the string is balanced with regards to brackets.

A string is said to be balanced if it has as many opening brackets of a certain type
as it has closing brackets of that type and if no bracket is unmacthed. Note that 
an opening bracket cannot math a corresponding closing bracket that comes before it. 
and similarly, a closing bracket cannot match a corresponding opening bracet that comes 
after it. Also, brackets cannot overlap each other as in [(])

Sample Input:
string = "([])(){}(())()()"

Sample Output:
true // it's balanced
'''

def balancedBrackets(string):
	opening = "([{"
	closing = ")]}"
	matching = {")":"(", "]":"[", "}":"{"}
	stack = []
	for i in string:
		if i in opening:
			stack.append(i)
		elif i in closing:
			if len(stack) == 0:
				return False 
			if matching[i] == stack[-1]:
				stack.pop()
			else:
				return False
	return len(stack) == 0
