#!C:\Python\Python
#coding=utf-8

'''
Min Heap Construction

Implement a Minheap class that supports:

- Building a Min Heap from an input array of integers
- Interting integers in the heap 
- Removing the heap's minimum / root value 
- Peeking at the heap's minimum / root value 
- Sifting integers up and down the heap, which is to be used when inserting and removing values 

Note that the heap should be represented in the form of an array. 

Sample Usage:
array = [48,12, 24, 7, 8, -5, 24, 391, 24, 56, 2, 6, 8, 41]

MinHeap(array)
buildHeap(array): [-5,2,6,7,8,8,24,391,24,56,12,24,48,41]
insert(76):  [-5,2,6,7,8,8,24,391,24,56,12,24,48,41,76]
peek():-5
remove(): -5 [2,7,6, 24, 8,8,24,391,76,56,12,24,48,41]
peek(): 2
remove():2 [6,7,8,24,8,391,24,56,12,24,48,41,76]
peek(): 6
insert(87): 
'''

class MinHeap:
    def __init__(self, array):
        self.heap = self.buildHeap(array)

    def buildHeap(self, array):
        firstParentIdx = (len(array) - 2) // 2
        for currIdx in reversed(range(firstParentIdx+1)):
            self.siftDown(currIdx, len(array)-1, array)
        return array

    def siftDown(self, currentIdx, endIdx,  heap):
        childOneIdx = currentIdx*2 + 1
        while childOneIdx <= endIdx :
            childTwoIdx = currentIdx*2 + 2 if currentIdx*2 + 2 <= endIdx else -1
            if childTwoIdx != -1 and heap[childTwoIdx] < heap[childOneIdx]:
                idx2Swap = childTwoIdx
            else:
                idx2Swap = childOneIdx
            if heap[currentIdx] > heap[idx2Swap]:
                self.swap(currentIdx, idx2Swap, heap)
                currentIdx = idx2Swap
                childOneIdx = currentIdx*2 + 1
            else:
                return 

    def siftUp(self, currentIdx, heap):
        parentIdx = (currentIdx -1)//2
        while currentIdx > 0 and heap[currentIdx] < heap[parentIdx]:
            self.swap(currentIdx, parentIdx, heap)
            currentIdx = parentIdx
            parentIdx =  (currentIdx -1)//2

    def peek(self):
        return self.heap[0]

    def remove(self):
        self.swap(0, len(self.heap)-1, self.heap)
        removedValue = self.heap.pop()
        self.siftDown(0, len(self.heap)-1,  self.heap)
        return removedValue

    def insert(self, value):
        self.heap.append(value)
        self.siftUp(len(self.heap)-1, self.heap)
	
    def swap(self, i, j, heap):
        #print("swap: i {} (value: {}) -> j {} (value: {})".format(i, heap[i], j,  heap[j]))
        heap[i], heap[j] = heap[j], heap[i]

array = [48,12, 24, 7, 8, -5, 24, 391, 24, 56, 2, 6, 8, 41]
minHeapObj = MinHeap(array)
print(minHeapObj.heap)



     