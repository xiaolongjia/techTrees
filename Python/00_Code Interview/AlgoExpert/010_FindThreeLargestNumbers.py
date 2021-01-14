#!C:\Python\Python
#coding=utf-8

'''
Find Three Largest Numbers 

Write a function that takes in an array of at least three integers and, without sorting the input array. 

returns a sorted array of the three largest integers in the input array. 

The function should return duplicate integers if necessary: for example, it should 

return [10, 10, 12] for an input array of [10, 5, 9, 10, 12]

Sample Input:
array = [141, 1, 17, -7, -17, -27, 18, 541, 8, 7, 7]

Sample Output:
[18, 141, 541]
'''

# solution 1: O(n) | O(1)
def findThreeLargestNumbers(array):
    one = None 
    two = None 
    three = None
    for i in range(len(array)):
        if i == 0:
            three = array[0]
        elif i == 1:
            if three > array[i]: 
                two, three = three, array[i] 
            else:
                two, three = array[i], three
        elif i == 2:
            if array[i] >= two :
                one = array[i]
            else:
                if array[i] > three :
                    one, two = two, array[i]
                else :
                    one, two, three = two, three, array[i]
        else:
            if array[i] > one:
                one, two, three = array[i], one, two 
            else:
                if array[i] > two :
                    two, three = array[i], two 
                else:
                    if array[i] > three:
                        three = array[i]
    return [three, two, one]

#solution 2
def findThreeLargestNumbers(array):
	threeLargest = [None, None, None]
	for i in array:
		updateLargest(threeLargest, i)
	return threeLargest

def updateLargest(array, num):
	if array[2] is None or num > array[2]:
		shiftArray(array, num, 2)
	elif array[1] is None or num > array[1]:
		shiftArray(array, num, 1)
	elif array[0] is None or num > array[0]:
		shiftArray(array, num, 0)

def shiftArray(array, num, idx):
	for i in range(idx + 1):
		if i == idx:
			array[i] = num 
		else :
			array[i] = array[i+1]
            
array = [141, 1, 17, -7, -17, -27, 18, 541, 8, 7, 7]
print(findThreeLargestNumbers(array))