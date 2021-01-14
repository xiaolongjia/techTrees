#!C:\Python\Python

def check(strA, strB):
    if len(strA) != len(strB):
        return False
    for start in range(len(strA)):
        end = len(strA) - 1 - start
        if strA[start] != strB[end]:
            return False
    return True

x = "hello!"
y = "!olleh"
print(check(x, y))

