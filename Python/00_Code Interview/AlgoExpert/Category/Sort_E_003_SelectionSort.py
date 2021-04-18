#!C:\Python38\Python
#coding=utf-8

'''
Selection Sort  

Write a function that takes in an array of integers and returns a sorted version of that array.

Use the Selection Sort algorithm to sort the array. 

Sample Input:
array = [8, 5, 2, 9, 5, 6, 3]

Sample Output:
[2, 3, 5, 5, 6, 8, 9]
'''

# Best:  O(n^2) | O(1)
# Ave:   O(n^2) | O(1)
# Worst: O(n^2) | O(1)
def selectionSort(array):
    for i in range(len(array)): 
        min_idx = i 
        for j in range(i+1, len(array)): 
            if array[min_idx] > array[j]: 
                min_idx = j 
                
        array[i], array[min_idx] = array[min_idx], array[i] 
    return array 
    

array = [141, 1, 17, -7, -17, -27, 18, 541, 8, 7, 7]
print(selectionSort(array))