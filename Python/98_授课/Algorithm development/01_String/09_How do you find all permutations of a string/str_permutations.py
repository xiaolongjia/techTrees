#!C:\Python\Python

def permutation(list):

    if len(list) == 0 :
        return []
    if len(list) == 1:
        return [list]

    l = []

    for i in range(len(list)):
        m = list[i]
        remainList = list[:i] + list[i+1:]
        for p in permutation(remainList):
            l.append([m] + p)
    return l

string = "ABCDE"
data = list(string) 
print(permutation(data))

from itertools import permutations 
l = list(permutations(range(1, 4))) 
print(l)

