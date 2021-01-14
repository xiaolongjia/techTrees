#!C:\Python\Python

def find_unrepeated_char(str):
    myDict = {}
    myCharOrder = []

    for c in str:
        if c in myDict:
            myDict[c] += 1
        else:
            myDict[c] = 1
        myCharOrder.append(c)

    for c in myCharOrder:
        if myDict[c] == 1:
            return c
    return None

myStrA = "geeksforgeeeks"
print(find_unrepeated_char(myStrA))

