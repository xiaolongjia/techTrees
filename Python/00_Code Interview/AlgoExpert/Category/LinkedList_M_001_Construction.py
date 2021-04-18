#!C:\Python\Python
#coding=utf-8

'''
Linked List Construction

Write a DoublyLinkedList class that has a head and a tail. both of which point to 
either a linked list Node or None/Null. The class should support:

- Setting the head and tail of the linked list. 
- Inserting nodes before and after other nodes as well as at given positions (the position of the head node is 1)
- Removing given nodes and removing nodes with given values. 
- Searching for nodes with given values. 

Note that the setHead, setTail, insertBefore, insertAfter, insertAtPosition. 
and remove methods all take in actual Node as input parameters -- not integers (except 
for insertAtPosition, which also takes in an integer representing the position); this means 
that you do not need to create any new Node in these methods. 
The input nodes can be either stand-alone nodes or nodes that are already in the linked list.
if they are nodes that are already in the linked list, the methods will effectively be mobing 
the nodes within the linked list. you won't be told if the input nodes are already 
in the linked list. so your code will have defensively handle this scenario. 

Each Node has an integer value as well as a prev node and a next node, both of which 
can point to either another node or None/null.

Sample Usage: 1<->2 <->3 <-> 4 <-> 5
3, 3, 6, # stand-alone nodes
setHead(4): 4 <-> 1 <-> 2 <-> 3 <-> 5
setTail(6): 4 <-> 1 <-> 2 <-> 3 <-> 5 <->6
insertBefore(6,3):  4 <-> 1 <-> 2 <-> 5 <-> 3 <->6
insertAfter(6,3):  4 <-> 1 <-> 2 <-> 5 <-> 3  <-> 6 <-> 3 
insertAtPosition(1,3): 3<-> 4 <-> 1 <-> 2 <-> 5 <-> 3  <-> 6 <-> 3 
removeNodesWithValue(3): 4 <-> 1 <-> 2 <-> 5 <-> 6
remove(2): 4 <-> 1 <-> 5 <-> 6
containsNodeWithValue(5): true 
'''

# This is an input class. Do not edit.
class Node:
    def __init__(self, value):
        self.value = value
        self.prev = None
        self.next = None

# Feel free to add new properties and methods to the class.
class DoublyLinkedList:
    def __init__(self):
        self.head = None
        self.tail = None

    def linkPrint(self):
        if self.head is None:
            print("It is a Null linked list")
        else:
            values = []
            node = self.head
            while node is not None:
                values.append(str(node.value))
                node = node.next
            print(" <-> ".join(values))

    def setHead(self, node):
        if self.head is None:
            self.head = node
            self.tail = node 
            return 
        self.insertBefore(self.head, node)

    def setTail(self, node):
        if self.tail is None:
            self.setHead(node)
            return 
        self.insertAfter(self.tail, node)

    def insertBefore(self, node, nodeToInsert):
        if nodeToInsert == self.head and nodeToInsert == self.tail:
            return 
        self.remove(nodeToInsert)
        nodeToInsert.prev = node.prev
        nodeToInsert.next = node
        if node.prev is None:
            self.head = nodeToInsert
        else: 
            node.prev.next = nodeToInsert
        node.prev = nodeToInsert
		
    def insertAfter(self, node, nodeToInsert):
        if nodeToInsert == self.head and nodeToInsert == self.tail:
            return 
        self.remove(nodeToInsert)
        nodeToInsert.prev = node 
        nodeToInsert.next = node.next
        if node.next is None:
            self.tail = nodeToInsert
        else:
            node.next.prev = nodeToInsert
        node.next = nodeToInsert

    def insertAtPosition(self, position, nodeToInsert):
        if position == 1:
            self.setHead(nodeToInsert)
            return
        node = self.head
        currPosition = 1
        while node is not None and currPosition != position:
            node = node.next
            currPosition += 1
        if node is not None:
            self.insertBefore(node, nodeToInsert)
        else:
            self.setTail(nodeToInsert)

    def removeNodesWithValue(self, value):
        node = self.head 
        while node is not None:
            node2Remove = node
            node = node.next
            if node2Remove.value == value :
                self.remove(node2Remove)

    def remove(self, node):
        if node == self.head:
            self.head = self.head.next 
        if node == self.tail :
            self.tail = self.tail.prev 
        self.removeNodeRelation(node)

    def removeNodeRelation(self, node):
        if node.prev is not None:
            node.prev.next = node.next
        if node.next is not None:
            node.next.prev = node.prev 
        node.prev = None 
        node.next = None

    def containsNodeWithValue(self, value):
        node = self.head 
        while node is not None:
            if node.value == value :
                return True 
            node = node.next 
        return False 

nodeOne = Node(1)
nodeTwo = Node(2)
nodeThree = Node(3)
nodeFour = Node(4)
nodeFive = Node(5)

llist = DoublyLinkedList()
llist.setHead(nodeFive)
llist.setHead(nodeFour)
llist.setHead(nodeThree)
llist.setHead(nodeTwo)
llist.setHead(nodeOne)
llist.linkPrint()

nodeSix = Node(6)
llist.setTail(nodeSix)
llist.linkPrint()
llist.insertBefore(nodeSix,Node(3))
llist.linkPrint()
llist.insertAfter(nodeSix,Node(3))
llist.linkPrint()
llist.insertAtPosition(1,Node(3))
llist.linkPrint()
llist.removeNodesWithValue(3)
llist.linkPrint()
llist.remove(nodeTwo)
llist.linkPrint()
print(llist.containsNodeWithValue(5))
