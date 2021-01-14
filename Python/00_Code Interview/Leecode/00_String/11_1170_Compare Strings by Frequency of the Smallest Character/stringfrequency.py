#!C:\Python\Python

'''
Let's define a function f(s) over a non-empty string s, which calculates the frequency of the smallest character in s. For example, if s = "dcce" then f(s) = 2 because the smallest character is "c" and its frequency is 2.

Now, given string arrays queries and words, return an integer array answer, where each answer[i] is the number of words such that f(queries[i]) < f(W), where W is a word in words.

 

Example 1:

Input: queries = ["cbd"], words = ["zaaaz"]
Output: [1]
Explanation: On the first query we have f("cbd") = 1, f("zaaaz") = 3 so f("cbd") < f("zaaaz").
Example 2:

Input: queries = ["bbb","cc"], words = ["a","aa","aaa","aaaa"]
Output: [1,2]
Explanation: On the first query only f("bbb") < f("aaaa"). On the second query both f("aaa") and f("aaaa") are both > f("cc").
'''

queries = ["bbb","cc"]
words = ["a","aa","aaa","aaaa"]

def f (s) -> int: 
    strings = sorted(s) 
    return strings.count(strings[0]) 

answers = list() 
queriesLength = list(map(f, queries)) 
wordsLength = list(map(f, words)) 
print(queriesLength)
print(wordsLength)

for i in queriesLength: 
    counter = 0 
    for j in wordsLength: 
        if i < j: 
            counter += 1 
    print(counter)
    answers.append(counter) 

print(answers)


