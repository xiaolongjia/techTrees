#!C:\Python\Python
#coding=utf-8

'''
Binary Tree Diameter 

Write a function that takes in a binary Tree and return its diameter.
The diameter of a binary tree is defined as the length of its longest path.
even if that path does not pass through the root of the tree. 

A path is a collection of connected nodes in a tree, where no node is connected to more than two
other nodes. The length of a path is the number of edges between the path's first node 
and its last node. 

Sample Input:
           1
         /   \
        3     2
       / \   
      7   4 
     /     \        
    8       5 
    /        \
   9          6
  
Sample Output: 
6 // 9->8->7->3->4->5>6
'''

class BinaryTree:
    def __init__(self, value, left=None, right=None):
        self.value = value
        self.left = left
        self.right = right

def binaryTreeDiameter(tree):
	return getTreeInfo(tree).diameter
	
def getTreeInfo(tree):
	if tree is None:
		return TreeInfo(0,0)
	leftTree = getTreeInfo(tree.left)
	rightTree = getTreeInfo(tree.right)
	longestPassRoot = leftTree.height + rightTree.height 
	maxDiameter = max(leftTree.diameter, rightTree.diameter)
	currDiameter = max(longestPassRoot, maxDiameter)
	currHeight = 1 + max(leftTree.height, rightTree.height)
	return  TreeInfo(currHeight, currDiameter)
	
class TreeInfo:
	def __init__(self, height, diameter):
		self.height = height
		self.diameter = diameter 
    
    
    