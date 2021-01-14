#!C:\Python\Python

#woods = [1,2,3,4]
#woods = [10,15,20,20,30,30,35,40]
woods = [10,15, 20, 20, 20, 30, 30, 30,  35, 40]
#woods = [1,1,1,2,2,2]
allsumResult = dict()
allsumID = dict()

for i in range(0, len(woods)-1):
    for j in range(i+1, len(woods)):
        currSum = woods[i] + woods[j] 
        if currSum not in allsumResult:
            allsumResult[currSum] = []
            allsumResult[currSum].append(str(woods[i]) + "+" + str(woods[j]))
            allsumID[currSum] = set()
            allsumID[currSum].add(i)
            allsumID[currSum].add(j)
        else:
            if i not in allsumID[currSum] and j not in allsumID[currSum]:
                allsumResult[currSum].append(str(woods[i]) + "+" + str(woods[j])) 
                allsumID[currSum].add(i) 
                allsumID[currSum].add(j)
longestFence = 0
ways = 0

for i in allsumResult:
    currLength = len(allsumResult[i])
    if currLength > longestFence:
        print(allsumResult[i])
        longestFence = currLength
        ways = 1
    elif currLength == longestFence:
        print(allsumResult[i])
        ways += 1

print(longestFence)
print(ways)

