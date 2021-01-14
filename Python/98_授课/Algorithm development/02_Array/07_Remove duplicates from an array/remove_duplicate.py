#!C:\Python\Python

myList = [1, 3, 4, 2, 2, 4, 5, 6, 7, 8]

finalList = []
for i in myList:
    if i not in finalList:
        finalList.append(i)
print(finalList)

myList = list(set(myList))
print(myList)
