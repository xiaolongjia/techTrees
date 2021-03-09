#!C:\Python\Python
#coding=utf-8

'''
Breadth-first Search

You are given a Node class that has a name and an array of optional children nodes.
When put together, nodes form an acyclic tree-like structure.

Implement the breadth-first search method on the Node class, which takes in an empty array.
traverses the tree using the Breadth-first search approach (specifically navigating the 
tree from left to right), stores all of the nodes' names in the input array, and returns it.

Sample Input:
       A
    /  |   \
   B   C    D
  / \      /  \
 E  F     G   H 
   / \     \      
  I   J    K     

Sample Output: 
[A,B,C,D,E,F,G,H,I,J,K]
'''

class Node:
    def __init__(self, name):
        self.children = []
        self.name = name

    def addChild(self, name):
        self.children.append(Node(name))
        return self

    # solution 1
    def breadthFirstSearch(self, array):
        queue = [self]
        while len(queue) > 0:
            current = queue.pop(0)
            array.append(current.name)
            for child in current.children:
                queue.append(child)
        return array
        
    # solution 2
    def breadthFirstSearch(self, array):
		array.append(self.name)
		self.searchChildren(self.children, array)
		return array
	
	def searchChildren(self, nodes, array):
		if len(nodes) > 0:
			nextNodes = []
			for node in nodes:
				array.append(node.name)
				nextNodes += node.children
			self.searchChildren(nextNodes, array)

