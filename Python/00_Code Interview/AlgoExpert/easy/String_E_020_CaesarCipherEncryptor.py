#!C:\Python38\Python
#coding=utf-8

'''
Caesar Cipher Encryptor

Given a non-empty string of lowercase letters and a non-negative integer representing a key, write a function
that returns a new string obtained by shifting every letter in the input string by k positions in the alphabet,
where k is the key.

Note that letters should "wrap" around the alphabet; in order words, the letter z shifted by one 
returns the letter a. 

Sample Input:
string = "xyz"
key = 2

Sample Output:
"zab"
'''

def caesarCipherEncryptor(string, key):
    key %= 26
    myNewStr = []
    for i in string:
        j = ord(i) + key
        c = chr(j) if j <= 122 else chr(96+j%122)
        myNewStr.append(c)
    return ''.join(myNewStr)
    
string = "xyz"
key = 72
print(caesarCipherEncryptor(string, key))