#!C:\Python\Python
#coding=utf-8

'''
Find Prime Factors
Sample Input:   data = 30
Sample Output:  [2, 3, 5]
'''

#solution 1
def findPrimeFactors (num):
    factors = []
    base = 2
    while base <= num:
        if num % base == 0:
            factors.append(base)
            num = num/base 
        else:
            base += 1

    return factors

print(findPrimeFactors(49))
