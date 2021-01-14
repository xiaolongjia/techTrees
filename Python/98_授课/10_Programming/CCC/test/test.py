#!C:\Python\Python

a = int(input())
list1 = []
list2 = []
for m in range(a):
	b = input()
	b = b.split(' ')
	list1.append(b)
list2.append(list1[0][0])
list2.append(list1[-1][0])
list2.append(list1[-1][-1])
list2.append(list1[0][-1])
list3 = list2.copy()
list3.sort()
c = int(list2.index(list3[0]))
print(c)
exit()
for n in range(c):
    for i in range(a): 
        for k in range(a-i): 
            list1[i][k+i],list1[k+i][i] = list1[k+i][i],list1[i][k+i] 
    for o in range(a): 
        for q in range(round(a/2)): 
            list1[o][q],list1[o][-q-1] = list1[o][-q-1],list1[o][q] 
print('-------------')
for p in range(a):
    print(' '.join(list1[p]))
