#!C:\Python\Python
#coding=utf-8

'''
Depth-firstSearch

You are given a Node class that has a name and an array of optional children nodes.
When put together, nodes form an acyclic tree-like structure.

Implement the depthFirstSearch method on the Node class, which takes in an empty array.
traverses the tree using the depth-first-search approach (specifically navigating the tree from 
left to right), stores all of the nodes' names in the input array, and returns it.

Sample input:
graph =   A
       /  |  \
       B  C   D
      /\     / \
     E  F   G   H  
       / \   \     
      I  J    K       

Sample output:
[A,B,E,F,I,J,C,D,G,K,H]
'''

# Do not edit the class below except
# for the depthFirstSearch method.
# Feel free to add new properties
# and methods to the class.
class Node:
    def __init__(self, name):
        self.children = []
        self.name = name

    def addChild(self, name):
        self.children.append(name)
        return self

	# o(v + e) time | o(v) space
    def depthFirstSearch(self, array):
        array.append(self.name)
        for child in self.children[::-1]:
            child.depthFirstSearch(array)
        return array

a = Node('A')
b = Node('B')
c = Node('C')
d = Node('D')
e = Node('E')
f = Node('F')
g = Node('G')
h = Node('H')
i = Node('I')
j = Node('J')
k = Node('K')

a.addChild(b)
a.addChild(c)
a.addChild(d)
b.addChild(e)
b.addChild(f)
f.addChild(i)
f.addChild(j)
d.addChild(g)
d.addChild(h)
g.addChild(k)

myRoot = []
print(a.depthFirstSearch(myRoot))