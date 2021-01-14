#!C:\Python\Python
#coding=utf-8

'''
Min Height BST

Write a function that takes in a non-empty sorted array of distinct integers, constructs a BST
from the integers, and returns the root of the BST. The function should minimize the height of the BST.

Sample Input:
array = [1,2,5,7,10,13,14,15,22]
Sample Output: 
     10
    /   \
   2     14
  / \    / \
 1   5  13  15
     \        \
     7        22
OR:
      10
    /    \
   5     15
  / \    /  \
 2   7  13  22
/       \
1        14
'''

def minHeightBst(array):
    return constructBST(0, len(array)-1, None, array)

def constructBST(start, end, bst, array):
    if start > end:
        return 
    middle = (start + end) //2
    toAdd = array[middle]
    if bst is None:
        bst = BST(toAdd)
    else:
        bst.insert(toAdd)
    constructBST(start, middle-1, bst, array)
    constructBST(middle+1, end, bst, array)
    return bst 

class BST:
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None

    def insert(self, value):
        if value < self.value:
            if self.left is None:
                self.left = BST(value)
            else:
                self.left.insert(value)
        else:
            if self.right is None:
                self.right = BST(value)
            else:
                self.right.insert(value)
