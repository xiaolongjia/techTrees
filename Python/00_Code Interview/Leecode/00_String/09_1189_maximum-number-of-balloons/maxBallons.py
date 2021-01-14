#!C:\Python\Python

'''
Given a string text, you want to use the characters of text to form as many instances of the word "balloon" as possible.

You can use each character in text at most once. Return the maximum number of instances that can be formed.
'''

def maxNumberOfBalloons(text: str) -> int:
        result = text.count("b")
        for i in ['a', 'l', 'n', 'o']:
            curr_val = 0
            if i in ['o', 'l']:
                curr_val = text.count(i)/2
            else:
                curr_val = text.count(i)
            if curr_val < result:
                result = curr_val
        return (int(result))

A= "you want to use the characters of text to form as many instances of the word balloon as possible"
print(maxNumberOfBalloons(A))

