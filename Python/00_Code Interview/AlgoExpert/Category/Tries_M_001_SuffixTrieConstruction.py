#!C:\Python\Python
#coding=utf-8

'''
Suffix Trie Construction 

Write a Suffix Trie class for a Suffix-Trie-like data structure. The class should 
have a root property set to be the root node of the trie and should support:
- creating the trie from a string; this will be done by calling the 
populateSuffixTrieFrom method upon class instantiation, which should populate 
the root of the class 
- searching for strings in the trie. 

Note that every string added to the trie should end with the special endSymbol character 
"*"

Sample Input:
string = "babc"

Sample Output:
{
"c": {"*": true},
"b": {
    "c": {"*": true},
    "a": {"b": {"c": {"*": true}}},
},
"a": {"b": {"c": {"*": true}}}
}
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

