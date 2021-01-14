#!C:\Python\Python
#coding=utf-8

'''
Nth Fibonacci 

The Fibonacci sequence is defined as follows: the first number of the sequence is 0.
the second number is 1. and the nth number is the sum of the (n-1)th and (n-2)th numbers.

Write a function that takes in an integer n and returns the nth Fibonacci number.

Important note:
the Fibonacci sequence is often defined with its first two numbers as F0=0
and F1=1. For the purpose of this question, the first Fibonacci number is F0;
therefore, getNthFib(1) is equal to F0, getNthFib(2) is equal to F1, etc. 
'''

# solution 1: O(n) | O(1)
def getNthFib(n):
    i, j =0, 1
    if n ==1:
        return i
    elif n == 2:
        return j
    else :
        for counter in range(n-2):
            i, j = j, i+j 
        return j 

# solution 2: O(n) | O(1)
def getNthFib(n):
	lastTwo = [0, 1]
	counter = 3
	while counter <= n:
		nextFib = lastTwo[1] + lastTwo[0]
		lastTwo[0] = lastTwo[1]
		lastTwo[1] = nextFib
		counter += 1
	return lastTwo[1] if n > 1 else lastTwo[0]
    
print(getNthFib(9))
