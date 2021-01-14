#!C:\Python\Python

x = "ABCBA"

# using loop
def palinedrome_check(strA):
    for start in range(len(strA)):
        end = len(strA) - 1 - start
        if strA[start] != strA[end]:
            return False
    return True

print(palinedrome_check(x))

# using extend slice syntax
newString = x[::1]
if newString == x:
    print True
else:
    print False

# using function reversed()
rev = ''.join(reversed(x)) 
if rev == x:
    print True
else:
    print False

