#!C:\Python\Python

'''
Given a string, you need to reverse the order of characters in each word within a sentence while still preserving whitespace and initial word order.

Example 1:
Input: "Let's take LeetCode contest"
Output: "s'teL ekat edoCteeL tsetnoc"
Note: In the string, each word is separated by single space and there will not be any extra space in the string.
'''

def reverseWordsOneline(s: str) -> str:
    return(" ".join([i[::-1] for i in s.split(" ")]))

def reverseWords(s: str) -> str:
    newwords = list()
    for currWord in s.split(" "):
        newwords.append(currWord[::-1])
    return(" ".join(newwords))

str = "Let's take this contest"
print(reverseWords(str))
print(reverseWordsOneline(reverseWords(str)))
