#!C:\Python\Python
#coding=utf-8

import re

#------------------
# re Functions 
#------------------

# findall(): returns a list with mateched data or empty list. 
txt = "The rain in Spain"
x = re.findall("\w", txt)

# search(): returns a match object or none 
x = re.search("(\w)(2)", txt)
if x:
    print(x.groups())
else:
    print("Not matched!")

# split(): returns a list 
x = re.split("\s", txt)
print(x)

# sub(): replaces matched string with the text of your choice
x = re.sub("\s", "999", txt)
print(x)

exit()

#------------------
# Match object Functions 
#------------------

# expand(template_string) 
xx = re.compile(r"(\d\d)(\d\d)")
yy = xx.search("in the year 1999")
print(yy.expand(r"Year: \1")) # \1 is group 1

# groups(): Return a tuple containing all the subgroups of the match.
print("groups(): {}".format(yy.groups()))
print("group1(): {}".format(yy.group(1)))
print("group2(): {}".format(yy.group(2)))

# start(), end()
print("group1.start(): {}".format(yy.start(1)))
print("group1.end(): {}".format(yy.end(1)))
print("group2.start(): {}".format(yy.start(2)))
print("group2.end(): {}".format(yy.end(2)))

# span() its argument is group name. it equals to (start(1), end(1))
print("span(1): {}\t(start(1), end(1)): {}".format(yy.span(1), (yy.start(1), yy.end(1))))

#------------------
# Match object Attributes  
#------------------

# string 
print("yy.string is {}".format(yy.string))

# lastindex : the last index of matched group 
print("yy.lastindex is {}".format(yy.lastindex))



