#!C:\Python\Python
#coding=utf-8

'''
Find All List Items
Sample Input:  [[[1,2,3], 2, [1,3]], [1,2,3]]
Sample Output:  [[0, 0, 1], [0, 1], [1, 1]]
'''

def index_all (search_list, item):
    indices = list()
    for i in range(len(search_list)):
        if search_list[i] == item:
            indices.append([i])
        elif isinstance(search_list[i], list):
            for index in index_all(search_list[i], item):
                indices.append([i]+index)
    return indices 

slist = [[[1,2,3], 2, [1,3]], [1,2,3]]
number = 2
print(index_all(slist, number))



