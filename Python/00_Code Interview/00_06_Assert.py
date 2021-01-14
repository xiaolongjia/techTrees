#!C:\Python\Python
#coding=utf-8

# assert condition
# eq
# if not condition:
#     raise AssertionError()

assert 1 in [1, 2, 3]      # lists
assert 4 not in [1, 2, 3]
assert 1 in {1, 2, 3}      # sets
assert 4 not in {1, 2, 3}
assert 1 in (1, 2, 3)      # tuples
assert 4 not in (1, 2, 3)

d = {1: 'foo', 2: 'bar', 3: 'qux'} # dict 
assert 1 in d
assert 'foo' not in d

s = 'foobar'
assert 'b' in s
assert 'x' not in s
assert 'foo' in s 


