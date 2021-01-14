#!C:\Python\Python

'''
string rotation:
 time  complexity: O(n)
 space complexity: O(1)
'''

def strrotationForce(str, m):       # T(n) = n^m  S(n) = O(m)
    print("old string is",str)
    i=0
    while(i<m):
        firstCharacter = str[0]
        j=1
        while(j<len(str)):
            str[j-1] = str[j]
            j += 1
        str[j-1] = firstCharacter
        i += 1
    print("new string is", str)

def reversStr(str, start, end):     #start, end is index
    print(str, start, end)
    while(start<end):
        firstCharacter = str[start]
        str[start] = str[end]
        str[end] = firstCharacter
        start += 1
        end -= 1
    print(str)

def strRotationFromHead(str, m):    # T(n) = O(n)
    m %= len(str)
    reversStr(str, 0, m-1)
    reversStr(str, m, len(str)-1)
    reversStr(str, 0, len(str)-1)

def strRotationFromTail(str, m):
    m = (len(str)-m) % len(str)
    strRotationFromHead(str, m)



myStr = list("Ilovebaofeng")
strrotationForce(myStr, 5)
myStr = list("Ilovebaofeng")
strRotationFromHead(myStr,5)
myStr = list("Ilovebaofeng")
strRotationFromTail(myStr,7)


