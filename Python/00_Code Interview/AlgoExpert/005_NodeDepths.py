#!C:\Python\Python
#coding=utf-8

'''
NodeDepths

The distance between a node in a Binary Tree and the tree's root is called the node's depth.

Write a function that takes in a Binary Tree and returns the sum of its node's depths.

Each BinaryTree node has an integer value, a left child node and a right child node.

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
19
// 19 = 1+1+2+2+2+2+3+3+3 

'''
# This is the class of the input tree. Do not edit.
class BinaryTree:
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None

# solution1: recursion 
# O(n) time | O(n) space 
def nodeDepths(root):
    return calculationNodeDepths(root, 0, 0) 
    
def calculationNodeDepths(node, currDepth, allNodesDepths) :   
    if node is None :
        return allNodesDepths

    allNodesDepths += currDepth
    if node.left is None and node.right is None :
        return allNodesDepths

    allNodesDepths = calculationNodeDepths(node.left,   currDepth + 1, allNodesDepths)
    allNodesDepths = calculationNodeDepths(node.right,  currDepth + 1, allNodesDepths)
    return allNodesDepths

# solution2: stack 
# O(n) time | O(n) space
def nodeDepths(root):
    sumofDepths = 0
    stack = [{'node':root, 'depths':0}]
    while len(stack) >0:
        currNode = stack.pop()
        node, depth = currNode['node'], currNode['depths']
        if node is None:
            continue 
        sumofDepths += depth 
        stack.append({'node': node.left,  'depths': depth+1})
        stack.append({'node': node.right, 'depths': depth+1})
        
	return sumofDepths
        

btRoot = BinaryTree(1)
btRoot.left   = BinaryTree(2)
btRoot.right  = BinaryTree(3)
print(nodeDepths(btRoot))