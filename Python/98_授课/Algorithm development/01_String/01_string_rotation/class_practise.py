#!C:\Python\Python

def strRotation(str, m):
    i= 0
    newStr = ''
    while(i<m):
        newStr += str[i]
        i += 1
    j= len(str) - 1
    while(j>=i):
        newStr = str[j] + newStr
        j -= 1
    return newStr

myStr = "abcdefg"
print(myStr[4:]+myStr[:4])
print(strRotation(myStr, 4))

