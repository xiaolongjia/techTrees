#!C:\Python\Python

'''
Write a function that reverses a string. The input string is given as an array of characters char[].

Do not allocate extra space for another array, you must do this by modifying the input array in-place with O(1) extra memory.

You may assume all the characters consist of printable ascii characters.
'''

def reverseString(s) -> None: 
    """
    Do not return anything, modify s in-place instead.
    """
    for i in range(0, int(len(s)/2)):
        (s[i], s[len(s)-i-1]) = (s[len(s)-i-1], s[i])
    print(s)

s = ["h","e","l","l","o"]
reverseString(s)
