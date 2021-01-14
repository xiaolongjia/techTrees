#!C:\Python\Python

from collections import Counter


def duplicateChars(str):
    myDict = {}
    for c in str:
        if c in myDict.keys():
            myDict[c] += 1
        else:
            myDict[c] = 1
    i = 0
    for dvalue in myDict.values():
        if dvalue > 1:
            print(list(myDict.keys())[i], "-->",dvalue)
        i += 1

def find_dup_char(str):
    # create dictionary using counter method 
    # which will have strings as key and their  
    # frequencies as value 
    myDict = Counter(str) 

    j = 0
    for i in myDict.values():
        if i > 1:
            print(list(myDict.keys())[j], " --> ",i)
        j += 1

myStrA = "geeksforgeeeks"
#duplicateChars(myStrA)
find_dup_char(myStrA)

