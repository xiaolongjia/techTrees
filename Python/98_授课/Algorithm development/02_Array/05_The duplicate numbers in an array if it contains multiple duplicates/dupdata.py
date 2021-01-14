#!C:\Python\Python

# number in arr is 0 ~ n-1, no negative number
def printRepeating(arr, size): 
    for i in range(0, size): 
        if arr[abs(arr[i])] >= 0: 
            arr[abs(arr[i])] = -arr[abs(arr[i])] 
        else: 
            print (abs(arr[i]), end = " ") 

#
def printDup(arr, size):
    myDict = {}
    dupList = []
    for i in range(0, size):
        if arr[i] in myDict.keys():
            if arr[i] not in dupList:
                print(arr[i])
                dupList.append(arr[i])
        else:
            myDict[arr[i]] = 1

arr = [1, 2, 2, 3, 3, 4] 
arr_size = len(arr) 
printDup(arr, arr_size) 
printRepeating(arr, arr_size) 

