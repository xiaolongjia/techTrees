#!C:\Python\Python

def word_reverse(str):
    tempWord = ''
    words = []

    for s in str:
        if s == ' ' and tempWord != ' ':
            words.append(tempWord)
            tempWord = ''
        else:
            tempWord += s
    if tempWord != ' ':
        words.append(tempWord)

    print("before:", str)

    str = " ".join(words[::-1])
    print("after:", str)

word_reverse(" I am a child")
exit()

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



