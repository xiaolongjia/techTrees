#!C:\Python\Python

def QuickSort(lst):

    def partition(arr, left, right):
        key = left  
        while left < right:
            while left < right and arr[right] >= arr[key]:
                right -= 1
            while left < right and arr[left] <= arr[key]:
                left += 1
            (arr[left], arr[right]) = (arr[right], arr[left])
 
        (arr[left], arr[key]) = (arr[key], arr[left])
        return left
 
    def quicksort(arr, left, right):  
        if left >= right:
            return
        mid = partition(arr, left, right)
        print(arr[mid])
        quicksort(arr, left, mid - 1)
        quicksort(arr, mid + 1, right)
 
    n = len(lst)
    if n <= 1:
        return lst
    quicksort(lst, 0, n - 1)
    return lst
 
print("<<< Quick Sort >>>")
x = input("please input numbers\n")
y = x.split()
arr = []
for i in y:
    arr.append(int(i))
arr = QuickSort(arr)
for i in arr:
    print(i, end=' ')
