#!C:\Python\Python
#coding=utf-8

'''
Min Number of Coins for change

Given an array of positive integers representing coin denominations 
and a single non-negative integer n representing a target amount of money,

Write a function that returns the smallest number of coins needed to make change 
for (to sum up) that target amount using the given coin denominations. 

Note that you have access to an unlimited amount of coins. In other words, 
if the denominations are [1,5,10], you have access to an unlimited amount of 
1, 5, 10. If it is impossible to make change for the target amount, then return -1

Sample Input:
n = 7
denoms = [1, 5, 10]  
Sample Output: 
3 // 2X1 + 1X5
'''

#solution 1
def minNumberOfCoinsForChange(n, denoms):
	minNumberCoins = [float("inf") for _ in range(n+1)]
	minNumberCoins[0] = 0
	for denom in denoms:
		for amount in range(len(minNumberCoins)):
			if denom <= amount:
				minNumberCoins[amount] = min(minNumberCoins[amount], minNumberCoins[amount-denom]+1)
	return minNumberCoins[n] if minNumberCoins[n] != float("inf") else -1

#solution 2
#def minNumberOfCoinsForChange(n, denoms):
#    memo = dict()
#    return dp(n, denoms, memo)
#
#def dp(n, denoms, memo):
#    if n in memo.keys():
#        return memo[n]
#    if n == 0:
#        return 0
#    if n < 0:
#        return -1
#    res = float("+inf")
#    for denom in denoms :
#        subProblem = dp(n-denom, denoms, memo)
#        if subProblem == -1:
#            continue 
#        res = min(res, subProblem+1)
#    memo[n] = res if res != float("+inf") else -1
#    print("n: {} memo[n]: {}".format(n, memo[n]))
#    return memo[n]

n = 15
denoms = [1, 2, 3, 7]
print(minNumberOfCoinsForChange(n, denoms))
    