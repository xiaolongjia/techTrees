#!C:\Python38\Python
#coding=utf-8

import re

# match() search(), groups(), group(), string 

result = re.match(r'(\d+)-((\d+)-(\d+)) (\d+):(\d+):(\d+)', '2021-03-19 10:00:21')
print(result.groups())
print(result.group())  # all matched data. 
print(result.group(0)) # all matched data. 
print(result.string)   # all matched data.

print(result.group(2,4,5,6))
print(result[0]) # same 
print(result[2]) # does not support result[2,4,5,6]
print(result.lastindex)

# (?P<first_name>\w+)

m = re.match(r"(?P<first_name>\w+) (?P<last_name>\w+)", "Malcolm Reynolds")
print(m.groupdict())
print(m['first_name'])
print(m.lastgroup) # group name

# search(), start(), end(), span()

email = "tony@tiremove_thisger.net"
s = re.search(r'(remove)_(this)', email)
print("start {}, end {}".format(s.start(), s.end()))
print("start1 {}, end1 {}".format(s.start(1), s.end(1))) # start/end of group 1
print("start2 {}, end2 {}".format(s.start(2), s.end(2))) # start/end of group 2

# span() its argument is group name. it equals to (start(1), end(1))

print("span(1): {}\t(start(1), end(1)): {}".format(s.span(1), (s.start(1), s.end(1))))
print(email[:s.start()]+email[s.end():])

# split 

r = re.split(r'\s+', '2021-03-19 10:00:21')
print(r)

# compile  ???

pair = re.compile(r".*(.).*")
print(pair.match("717ak").group())
print(pair.match("717ak").groups())

pair = re.compile(r".*(.).*\1")
print(pair.match("717ak").group())
print(pair.match("717ak").groups())

# non-greedy modifier suffix ?

print(re.match(r'(\d+?)', '123').group(1)) # non-greedy
print(re.match(r'(\d+)', '123').group(1)) # greedy

# findall(): returns a list with mateched data or empty list. 

txt = "The rain in Spain"
print(re.findall("\w+", txt))
print(re.findall("\w", txt))

# sub(): substitutes matched string with the text of your choice

x = re.sub("\s", "999", txt)
print(x)

# expand(template_string) ???

xx = re.compile(r"(\d\d)(\d\d)")
yy = xx.search("in the year 1999")
print(yy.expand(r"Year: \2")) # \1 is group 1
