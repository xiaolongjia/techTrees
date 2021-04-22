#!C:\Python38\Python
#coding=utf-8

'''
Reconstruct BST

The pre-order traversal of a Binary Tree is a traversal technique that 
starts at the tree's root node and visits nodes in the following order:

1. current node 
2. left subtree
3. right subtree 

Given a non-empty array of integers representing the pre-order traversal of a 
binary search tree (BST), write a function that creates the relevant BST 
and returns its root node. 

The input array will contain the value of BST nodes in the order in which these nodes 
would be visited with a pre-order traversal. 


Sample Input:
array = [10, 4, 2, 1, 5, 17, 19, 18]

Sample Output:
tree =  10
       /   \
      4     17
     / \     \
    2   5    19
   /         /
  1         18

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
