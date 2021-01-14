#!C:\Python\Python

'''
Does array contains only positive or negative numbers?
What if the same pair repeats twice, should we print it every time?
Is reverse of pair is acceptable e.g. 
can we print both (4,1) and (1,4) if given sum is 5.
Do we need to print only distinct pair? 
does (3, 3) is a valid pair forgiven sum of 6?
How big the array is?
'''

# Given an array of integers, and a number sum 
# find the number of pairs of integers in the array whose sum is equal to sum.

#brute-force
def getPairs(arr, n, sum):
    counter = 0
    for i in range(0, n):
        for j in range(i+1, n):
            if ((arr[i] + arr[j]) == sum):
                print(arr[i],"+",arr[j],"=", sum)
                counter += 1
    return counter

#use Dict
def getPairsByDict(arr, n, sum):
    myDict = {}
    for i in range(0, n):
        if arr[i] in myDict.keys():
            myDict[arr[i]] += 1
        else:
            myDict[arr[i]] = 1
    twice_count = 0
    for key in myDict.keys():
        if ((sum - key) in myDict.keys()):
            if ((sum - key) == key):
                twice_count +=  (myDict[key]-1)*myDict[key]
            else:
                twice_count += myDict[sum - key]*myDict[key]
    return (int(twice_count/2))

arr = [1, 1, 5, 7, -1, 5, 3]
print(getPairsByDict(arr, len(arr), 6))
print(getPairs(arr, len(arr), 6))

