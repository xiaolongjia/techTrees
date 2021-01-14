#!C:\Python\Python
#coding=utf-8

'''
with open(SOME_LARGE_FILE) as fh:
count = 0
text = fh.read()
for character in text:
    if character.isupper():
count += 1
'''

# count = sum(1 for line in fh for character in line if character.isupper())