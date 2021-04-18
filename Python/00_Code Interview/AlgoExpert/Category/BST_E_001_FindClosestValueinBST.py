#!C:\Python38\Python
#coding=utf-8

'''
Find Closest Value in BST

Write a function that takes in a Binary Search Tree(BST) and a target integer value and returns the closest value to that target value contained in the BST.

You can assume that there will only be one closest value.

Each BST node has an integer value, a left child node, and a right child node. A node is said to be a valid BST if and only if it satisfies the BST propertities:
its value is strictly greater than the values of every node to its left;
its value is less than or equal to the values of every node to its right;
and its children nodes are either valid BST nodes themselves or None/Null.

Sample input:
tree =  10
       /   \
       5    15
      /\   /   \
     2  5  13  22 
    /        \
   1          14
target = 12

Sample output:
13

iteratively , recursively
'''

def findClosestValueInBst(tree, target):
    return findClosestValueInBstAction(tree, target, tree.value)

#solution 1: recursion 
#Average: O(log(n)) time | O(log(n)) space 
#Worst: O(n) time | O(n) space 
def findClosestValueInBstAction(tree, target, closest):
    if tree is None:
        return closest
    if abs(target - tree.value) < abs(target - closest) :
        closest = tree.value 
    if target > tree.value :
        return findClosestValueInBstAction(tree.right, target, closest)
    elif target < tree.value :
        return findClosestValueInBstAction(tree.left, target, closest)
    else:
        return closest 

#solution 2: iteration 
#Average: O(log(n)) time | O(1) space 
#Worst: O(n) time | O(1) space
def findClosestValueInBstAction(tree, target, closest):
    currNode = tree 
    while currNode is not None:
        if abs(target - currNode.value) < abs(target - closest):
            closest = currNode.value 
        if target > currNode.value:
            currNode = currNode.right 
        elif target < currNode.value :
            currNode = currNode.left
        else:
            break 
    return closest 
  
# This is the class of the input tree. Do not edit.
class BST:
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None
