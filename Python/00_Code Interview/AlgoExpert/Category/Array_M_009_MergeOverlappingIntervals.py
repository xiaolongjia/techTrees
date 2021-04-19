#!C:\Python38\Python
#coding=utf-8

'''
Merge Overlapping Intervals

Write a function that takes in a non-empty array of arbitrary integers,
merges any overlapping intervals, and returns the new intervals in no particular order. 

Each interval interval is an array of two integers, with interval[0] as the start of the 
interval and interval[1] as the end of the interval. 

Note that back-to-back intervals are not considered to be overlapping. 
For example, [1,5] and [6,7] are not overlapping; hower [1,6] and [6,7]
are indeed overlapping. 

Also note that the satrt of any particular interval will always be less than or equal to the 
end of that interval. 

Sample Input:
intervals = [ [1,2], [3,5], [4,7], [6,8], [9,10]]

Sample Output:
[[1,2]. [3,8], [9,10]]
'''

def mergeOverlappingIntervals(intervals):
    # Write your code here.
    sortedintervals = sorted(intervals, key=lambda x: x[0])
    result = []
    currStart = sortedintervals[0][0]
    currStop = sortedintervals[0][1]
    for i in range(1, len(sortedintervals)):
        start, stop = sortedintervals[i][0], sortedintervals[i][1]
        if start <= currStop:
            if stop > currStop:
                currStop = stop
        else:
            result.append([currStart, currStop])
            currStart = start 
            currStop = stop
    result.append([currStart, currStop])
    return result

intervals = [ [1,9],  [6,10], [3,5], [10,11],  [4,7]]
print(mergeOverlappingIntervals(intervals))

