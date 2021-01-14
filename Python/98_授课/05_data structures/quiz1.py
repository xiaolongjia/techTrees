#!C:\Python\Python

a = ['a', 'b', 'c']
a.extend(['d', 'e'])
print(a)
#exit()

a = ['a', 'b', 'c']
a += 'de'
print(a)
#exit()

a = ['a', 'b', 'c']
a[-1:] = ['d', 'e']
print(a)
#exit()

a = ['a', 'b', 'c']
a.append(['d', 'e'])
print(a)
#exit()

a = ['a', 'b', 'c']
a[len(a):] = ['d', 'e']
print(a)
#exit()

a = ['a', 'b', 'c']
a += ['d', 'e']
print(a)
exit()

myList =  [1,2,3,4,5,3,2,1,2,3,4,2,3,2]
myList2 = myList.copy()
print(myList is mylist2)

