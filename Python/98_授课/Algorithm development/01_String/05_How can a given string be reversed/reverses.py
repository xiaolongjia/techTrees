#!C:\Python\Python

'''
def revers_str(str, start, end):
    if (start >= end):
        return

    tempChar = str[start]
    str[start] = str[end]
    str[end] = tempChar
    start += 1
    end -= 1
    revers_str(str, start, end)

myStrA = list("geeksforgeeeks")
revers_str(myStrA, 0, len(myStrA)-1)
print(myStrA)
'''

# using recursion
def recursion(str):
    if len(str) == 0:
        return str
    else:
        return recursion(str[1:]) + str[0]

# using loop
def loop(str):
    newStr=''
    for i in str:
        newStr = i + newStr
    return newStr

# using extended slice syntax
def slice(str):
    str = str[::-1]
    return str

# using function reversed()
def reverse(str):
    str = "".join(reversed(str))
    return str

myStrA = "geeksforgeeeks"
#print(recursion(myStrA))
#print(loop(myStrA))
#print(slice(myStrA))
#print(reverse(myStrA))
print(reversed(myStrA))



