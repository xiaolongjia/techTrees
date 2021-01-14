#!C:\Python\Python
#coding=utf-8

'''
Branch Sums 

Write a function that takes in a Binary Tree and returns a list of its branch sums ordered from 
leftmost branch sum to rightmost branch sum.

A branch sum is the sum of all values in a Binary Tree branch. A Binary Tree branch is a path
of nodes in a tree that starts at the root node and ends at any leaf node.

Each BinaryTree node has an integer value. a left child node, and a right child node.
Children nodes can either be BinaryTree nodes themselves or None/Null.

Sample input:
tree =  1
       /  \
       2    3
      /\   /   \
     4  5  6    7 
    / \ /     
   8  9 10       

Sample output:
[15, 16, 18, 10, 11]
// 15 = 1+2+4+8
// 16 = 1+2+4+9
// 18 = 1+2+5+10
// 10 = 1+3+6
// 11 = 1+3+7

'''
# This is the class of the input tree. Do not edit.
class BinaryTree:
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None

# recursion 
# O(n) time | O(n) space 
def branchSums(root):
    sums = []
    calculationNode(root, 0, sums)
    return sums 

def calculationNode(node, suming, sums):
    if node is None :
        return
    
    newSuming = suming + node.value
    if node.left is None and node.right is None:
        sums.append(newSuming)
        return 

    calculationNode(node.left,  newSuming, sums)
    calculationNode(node.right, newSuming, sums)
