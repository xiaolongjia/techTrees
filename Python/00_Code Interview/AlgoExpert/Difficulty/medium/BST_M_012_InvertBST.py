#!C:\Python\Python
#coding=utf-8

'''
Invert Binary Tree

Write a function that takes in a binary Tree and inverts it. In other words, the 
function should swap every left node in the tree for its corresponding right node.

Sample Input:
      1
    /   \
   2      3
  / \    / \
 4   5  6   7
/ \        
8  9

Sample Output: 
      1
    /   \
   3      2
  / \    / \
 7   6  5   4
           / \        
           9  8
'''

def invertBinaryTree(tree):
    queue = [tree]
    while len(queue):
        currTree = queue.pop(0)
        if currTree is None:
            continue
        currTree.left, currTree.right = currTree.right, currTree.left 
        queue.append(currTree.left)
        queue.append(currTree.right)
        


# This is the class of the input binary tree.
class BinaryTree:
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None
        