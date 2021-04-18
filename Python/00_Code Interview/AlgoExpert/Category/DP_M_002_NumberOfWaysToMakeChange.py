#!C:\Python\Python
#coding=utf-8

'''
Number of ways to make change

Given an array of distinct positive integers representing coin denominations 
and a single non-negative integer n representing a target amount of money,

Write a function that returns the number of ways to make change for that target 
amount using the given coin denominations. 

Note that an unlimited amount of coins is at your disposal. 

Sample Input:
n = 6
denoms = [1, 5]  
Sample Output: 
2 // 1X1 + 1X5 and 6X1
'''

def numberOfWaysToMakeChange(n, denoms):
	memo = [0 for _ in range(0, n+1)]
	memo[0] = 1
	for denom in denoms:
		for i in range(1, n+1):
			if denom <= i:
				memo[i] += memo[i-denom]
	return memo[n]

n = 15
denoms = [1, 2, 3, 7, 4, 5]
print(numberOfWaysToMakeChange(n, denoms))
    