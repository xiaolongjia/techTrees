#!C:\Python\Python

# translate char to int
print(chr(97))
print(ord('a'))

# using isdigit()
myStr = "123456"
myStr2 = "asd22212"

print(myStr.isdigit())
print(myStr2.isdigit())

# using regex

import re

print(re.match('^\d*$', myStr))
print(re.match('^\d*$', myStr2))

