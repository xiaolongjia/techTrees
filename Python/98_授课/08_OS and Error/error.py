#!C:\Python\Python

assert True
#assert False

import sys
#assert ('linux' in sys.platform), "it only run on linux"

a = 100
if a > 99:
    #raise Exception('it is larger than 100')
    pass

try:
    raise NameError('name error here')
except RuntimeError:
    print("it is normal!")
else:
    print("it is real name")
finally:
    print("go here whatever real or fake name")


