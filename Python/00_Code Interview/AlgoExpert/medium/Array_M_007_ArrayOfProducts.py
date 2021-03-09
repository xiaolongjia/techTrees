#!C:\Python\Python
#coding=utf-8

'''
Array of products

Write a function that takes in a non-empty array of integers and returns an array of the same length, 
where each element in the output array is equal to the product of every other number in the input array. 

In other words, the value at output[i] is equal to the product of every number in the input 
array other than input[i].

Note that you're expected to solve this problem without using division. 

Sample Input:
array = [ 5, 1, 4, 2]

Sample Output:
[8, 40, 10, 20]
'''


def arrayOfProducts(array):
    products = [1 for _ in range(len(array))]
    
    leftRunningProduct = 1
    for i in range(len(array)):
        products[i] = leftRunningProduct
        leftRunningProduct *= array[i]

    rightRunningProduct = 1
    for i in reversed(range(len(array))):
        products[i] *= rightRunningProduct
        rightRunningProduct *= array[i]

    return products
    
array = [5, 1, 4, 2]
print(arrayOfProducts(array))

