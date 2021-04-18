#!C:\Python\Python
#coding=utf-8

'''
Validate BST

Write a function that takes in a potentially invalid Binary Search Tree (BST) and 
return a boolean representing whether the BST is valid. 

Each BST node has an integer value, a left child node, and a right child node. 
A node is said to be a valid BST node if and only if it satisfies the BST property:
its value is strictly greater than the values of every node to its left;
its value is less than or equal to the values of every node to its right;
and its children nodes are either valid BST nodes themselves or NONE/NULL

a BST is valid if and only if all of its nodes are valid BST nodes. 

Sample Input:
     10
    /   \
   5     15
  / \   /  \
  2  5  13  22
 /       \
 1       14

Sample Output: True
'''

class BST:
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None

def validateBst(tree):
	return validateBSTAct(tree, float("-inf"), float("+inf"))

def validateBSTAct(tree, minValue, maxValue):
	if tree is None:
		return True 
	if tree.value < minValue or tree.value >= maxValue:
		return False 
	validateLeft = validateBSTAct(tree.left, minValue, tree.value)
	validateRight = validateBSTAct(tree.right, tree.value, maxValue)
	return validateLeft and validateRight 
