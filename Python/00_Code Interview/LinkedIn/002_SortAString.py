#!C:\Python\Python
#coding=utf-8

'''
Sort A String
Sample Input:   banana ORANGE apple
Sample Output:  apple banada ORANGE
'''

def sort_words (input):
    words = input.split()
    words = [w.lower() + w for w in words]
    words.sort()
    words = [w[len(w)//2:] for w in words]
    return(words)
    
sort_words('banana ORANGE apple')
