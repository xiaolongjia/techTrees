#!C:\Python\Python

import time

def quickSort(arr, left, right): 
    if left >= right:
        return
    midIndex =  partition(arr, left, right)
    quickSort(arr, left, midIndex - 1)
    quickSort(arr, midIndex + 1, right)

def partition(arr, left, right):
    key = left
    print("left: ",arr[left],"right: ", arr[right], "array:", arr)
    time.sleep(1)
    while left < right:
        while left < right and arr[right] >= arr[key]:
            right -= 1
        while left < right and arr[left] <= arr[key]:
            left += 1
        (arr[left], arr[right]) = (arr[right], arr[left])

    (arr[key], arr[left]) = (arr[left], arr[key])
    return left

arr = [7, 5, 8, 2, 3, 1, 19, 9, 2]
quickSort(arr, 0, len(arr)-1)
print(arr)

