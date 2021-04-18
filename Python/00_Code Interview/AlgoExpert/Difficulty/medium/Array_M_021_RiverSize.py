#!C:\Python\Python
#coding=utf-8

'''
River Sizes 

You are given a two-dimensional array (a matrix) of potentially unequal height and 
width containing only 0 and 1. Each 0 represents land and each 1 represents part of a river.
A river consists of any number of 1 that are either horizontally or vertically 
adjacent (but not diagonally adjacent). The number of adjacent 1 forming a river 
determine its size. 

Note that a river can twist. In other words, it doesnot have to be a straight 
vertical line or a straight horizontal line; it can be L-shaped, for example.

Write a function that returns an array of the sizes of all rivers represented in 
the input matrix. The sizes do not need to be in any particular order. 

Sample Input:
matrix = [
    [1, 0, 0, 1, 0],
    [1, 0, 1, 0, 0],
    [0, 0, 1, 0, 1],
    [1, 0, 1, 0, 1],
    [1, 0, 1, 1, 0],
]

Sample Output: 
[1, 2, 2, 2, 5]
'''

def riverSizes(matrix):
    rivers = []
    matrixFlag = [[0 for _ in matrix[0]] for _ in range(len(matrix))]
    for i in range(len(matrix)):
        for j in range(len(matrix[0])):
            if matrix[i][j] == 0 or matrixFlag[i][j] == 1:
                continue 
            print("i: {} j: {} ==>".format(i, j))
            queue = [[i, j]]
            currSize = 1
            while len(queue) > 0:
                x,y = queue.pop()
                matrixFlag[x][y] = 1
                print("x: {} y: {}".format(x, y))
                if y > 0 and matrix[x][y-1]==1 and matrixFlag[x][y-1]==0 and [x, y-1] not in queue:
                    currSize += 1
                    queue.append([x, y-1])
                if y < len(matrix[0]) -1 and matrix[x][y+1]==1 and matrixFlag[x][y+1]==0 and [x, y+1] not in queue:
                    currSize += 1
                    queue.append([x, y+1])
                if x > 0 and matrix[x-1][y]==1 and matrixFlag[x-1][y]==0 and [x-1, y] not in queue:
                    currSize += 1
                    queue.append([x-1, y])
                if x < len(matrix)-1 and matrix[x+1][y]==1 and matrixFlag[x+1][y]==0 and [x+1, y] not in queue:
                    currSize += 1
                    queue.append([x+1, y])
            print("river size: {}".format(currSize))
            rivers.append(currSize)
    return rivers 

matrix = [
    [1, 1, 0],
    [1, 0, 1],
    [1, 1, 1],
    [1, 1, 0],
    [1, 0, 1],
    [0, 1, 0],
    [1, 0, 0],
    [1, 0, 0],
    [0, 0, 0],
    [1, 0, 0],
    [1, 0, 1],
    [1, 1, 1]
]
print(riverSizes(matrix))
