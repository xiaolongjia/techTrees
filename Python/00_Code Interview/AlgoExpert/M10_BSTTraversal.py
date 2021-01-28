#!C:\Python\Python
#coding=utf-8

'''
BST Traversal

Write three functions that takes in a Binary Search Tree(BST) and an empty array.
traverse the BST. add its nodes' values to the input array, and return that array.
The three functions should traverse the BST using the in-order, pre-order, and post-order
tree-traversal techniques, respectively. 

Sample Input:
     10
    /   \
   5     15
  / \     \
  2  5    22
 /       
1       

Sample Output: 
preOrderTraverse: [10, 5, 2, 1, 5, 15, 22] # Preorder  (Root, Left, Right) 
inOrderTraverse: [1,2,5,5,10,15,22]        # Inorder   (Left, Root, Right)
postOrderTraverse: [1,2,5,5,22,15,10]      # Postorder (Left, Right, Root)
'''
class BST:
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None

# Preorder (Root, Left, Right) 
def preOrderTraverse(tree, array):
	if tree is not None:
		array.append(tree.value)
		preOrderTraverse(tree.left, array)
		preOrderTraverse(tree.right, array)
	return array
# Inorder (Left, Root, Right) 
def inOrderTraverse(tree, array):
	if tree is not None:
		inOrderTraverse(tree.left, array)
		array.append(tree.value)
		inOrderTraverse(tree.right, array)
	return array
# Postorder (Left, Right, Root) 
def postOrderTraverse(tree, array):
	if tree is not None:
		postOrderTraverse(tree.left, array)
		postOrderTraverse(tree.right, array)
		array.append(tree.value)
	return array

root = BST(10)
root.left = BST(5)
root.left.left = BST(2)
root.left.right = BST(5)
root.left.left.left = BST(1)
root.right = BST(15)
root.right.left = BST(13)
root.right.left.right = BST(14)
root.right.right = BST(22)
array1=[]
array2=[]
array3=[]
print(preOrderTraverse(root, array2))
print(inOrderTraverse(root, array1))
print(postOrderTraverse(root, array3))
