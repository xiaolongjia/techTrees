#!C:\Python\Python

myList = [1, 3, 4, 2, 2, 4, 5, 6, 7, 8]

print(myList)
myList.reverse()
print(myList)

left = 0
right = len(myList) - 1
while left < right:
    (myList[left], myList[right]) = (myList[right], myList[left])
    left += 1
    right -= 1
print(myList)


