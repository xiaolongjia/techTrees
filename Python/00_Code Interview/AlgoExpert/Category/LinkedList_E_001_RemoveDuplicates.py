#!C:\Python38\Python
#coding=utf-8

'''
Remove Duplicates From Linked List

You're given the head of s Single Linked List whose nodes are in sorted order 
with respect to their values. Write a function that returns a modified version of the Linked
List that doesn't contain any nodes with duplicate values. The Linked List should 
be modified in place (i.e., you shouldn't create a brand new list), and the modified Linked
List should still have its nodes sorted with respect to their values.

Each Linked List node has an integer value as well as a next node pointing to 
the next node in the list or to None / null if it's the tail of the list. 

Sample input:
linkedlist = 1 -> 1 -> 1-> 3 -> 4 -> 4 -> 5 -> 6 -> 6

Sample output:
1 -> 3 -> 4 -> 5 -> 6  

'''

class LinkedList:
    def __init__(self, value):
        self.value = value
        self.next = None
	
    def printLList(self):
        next = self 
        output = []
        while next is not None:
            output.append(str(next.value))
            next = next.next 
        print(" -> ".join(output))

def removeDuplicatesFromLinkedList(linkedList):
	next = linkedList
	while next is not None:
		if next.next is None:
			break
		if next.value == next.next.value:
			next.next = next.next.next 
		else :
			next = next.next 
	return linkedList

root = LinkedList(1)
root.next =  LinkedList(1)
root.next.next =  LinkedList(1)
root.next.next.next =  LinkedList(3)
root.next.next.next.next =  LinkedList(4)
root.next.next.next.next.next =  LinkedList(4)
root.next.next.next.next.next.next =  LinkedList(5)
root.next.next.next.next.next.next.next =  LinkedList(6)
root.next.next.next.next.next.next.next.next =  LinkedList(6)
root.printLList()

removedList = removeDuplicatesFromLinkedList(root)
removedList.printLList()
