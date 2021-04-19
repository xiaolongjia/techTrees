#!C:\Python\Python
#coding=utf-8

'''
Find Kth Largest Value in BST

Write a function that takes in a Binary Search Tree (BST) and a positive integer k 
and returns the kth largest integer contained in the BST.

You can assume that there will only be integer values in the BST and that k is 
less than or equal to the number of nodes in the tree. 

Also, for the purpose of this question, duplicate integers will be treated as 
distinct values. In other words, the second largest value in a BST 
containing values {5, 7, 7} will be 7 not 5. 


Sample Input:
tree =  10
       /   \
      2     14
     / \    / \
    1   5  13  15
        \        \
        7        22
k = 3 

Sample Output:

14

'''

def findKthLargestValueInBst(tree, k):
    array = []
	backTraverse(tree, array)
	if len(array) < k:
	    return None 
    else:
        return array[k-1]

def backTraverse(tree, array):
    if tree.right is not None:
	    backTraverse(tree.right , array) 
	array.append(tree.value)
	if tree.left is not None:
	    backTraverse(tree.left , array)
	
class BST:
    def __init__(self, value, left=None, right=None):
        self.value = value
        self.left = left
        self.right = right
