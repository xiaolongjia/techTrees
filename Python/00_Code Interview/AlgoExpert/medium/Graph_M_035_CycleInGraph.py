#!C:\Python\Python
#coding=utf-8

'''
Cycle In Graph

You are given a list of edges representing an unweighted, directed graph with at least one node.
Write a function that returns a boolean representing whether the given graph contains a cycle.

For the purpose of this question, a cycle is defined as any number of vertices, 
including just one vertex, that are connected in a closed chain. A cycle can also be defined 
as a chain of at least one vertex in which the first vertex is the same as the last.

The given list is what's called an adjacency list, and it represents a graph.
The number of vertices in the graph is equal to the length of edges, where 
each index i in edges contains vertex i's outbound edges, in no particular order. 
Each individual edge is represented by a positive integer that 
denotes an index ( a destination vertex) in the list that 
this vertex is connected to. Note that these edges are directed, meaning that you can only 
travel from a particular vertex to its destination, not the other way around (unless the destination vertex 
itself has an outbound edge to the original vertex).

Also note that this graph may contain self-loops. A self-loop is an edge that has the same 
destination and origin; In other words, it's an edge that connects a vertex to itself. 
For the purpose of this question, a self-loop is considered a cycle.

Sample Input:
edges = [
[1,3],
[2,3,4],
[0],
[],
[2,5],
[],
]

Sample Output:
true 
// 1. 0->1->2->0
// 2. 0->1->4->2->0
// 3. 1->2->0->1
'''

class SuffixTrie:
    def __init__(self, string):
        self.root = {}
        self.endSymbol = "*"
        self.populateSuffixTrieFrom(string)

    def populateSuffixTrieFrom(self, string):
        for i in range(len(string)):
            node = self.root
            for j in range(i, len(string)):
                letter = string[j]
                if letter not in node:
                    node[letter] = {}
                node = node[letter]
            node[self.endSymbol] = True 

    def contains(self, string):
        node = self.root 
        for letter in string:
            if letter not in node:
                return False 
            node = node[letter]
        return self.endSymbol in node 

string = "babc"
st = SuffixTrie(string)
print(st.root)

