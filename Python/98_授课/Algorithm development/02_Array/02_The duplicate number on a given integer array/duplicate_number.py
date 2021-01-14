#!C:\Python\Python

def duplicateNumber(list):
    repeatedNums = []
    myDic = {}
    for currNum in list:
        if currNum in myDic:
            myDic[currNum] += 1
            if currNum not in repeatedNums:
                repeatedNums.append(currNum)
        else:
            myDic[currNum] = 1
    return repeatedNums

myList = [10, 20, 30, 20, 20, 30, 40,50, -20, 60, 60, -20, -20]
print(duplicateNumber(myList))

