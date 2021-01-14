#!C:\Python\Python

def missedNumber(list):
    n = len(list)
    total = ((n+1)*(n+2))/2
    sumL = sum(list)
    return (total - sumL)

myList = [1, 2, 4, 5, 6, 7, 8]
print(int(missedNumber(myList)))

