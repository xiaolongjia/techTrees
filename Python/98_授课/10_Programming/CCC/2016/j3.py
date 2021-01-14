#!C:\Python\Python

myStr = input()
maxlength = 0
start = 0
length = len(myStr)

for i in range(1, length):
    low = i-1
    high = i
    while(low >=0 and high < length and myStr[low] == myStr[high]):
        if maxlength < high - low + 1:
            maxlength = high - low + 1
            start = low
        low -= 1
        high += 1

    low = i - 1
    high = i + 1
    while(low >=0 and high < length and myStr[low] == myStr[high]):
        if maxlength < high - low + 1:
            maxlength = high - low + 1
            start = low
        low -= 1
        high += 1

print("longest palindromic is:", myStr[start:start+maxlength])

