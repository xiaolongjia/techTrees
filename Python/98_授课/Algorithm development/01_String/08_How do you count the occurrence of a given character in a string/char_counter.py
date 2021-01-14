#!C:\Python\Python

mystr = "geeks for geeks121"

# using string function count()
print(mystr.count('e'))

# using collections.Counter
from collections import Counter
myDict = Counter(mystr)
print(myDict['e'])

# using re
import re
print(len(re.findall('e', mystr)))


