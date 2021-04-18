#!C:\Python38\Python
#coding=utf-8

'''
It is photo day at the local school, and you are the photographer assigned to take class photos. 
The class that you will be photographing has an even number of students, 
and all these students are wearing red or blue shirts. In fact, exactly half of the 
class is wearing red shirts, and the other half is wearing blue shirts. 
You are responsible for arranging the students in two rows before taking 
the photo. Each row should contain the same number of the students and 
should adhere to the following guidelines:
1. all students wearing red shirts must be in the same row. 
2. all students wearing blue shirts must be in the same row. 
3. each student in the back row must be strictly taller than the student directly in front of them in the front row 

you are given two input arrays: one containing the heights of all the students 
with red shirts and another one containing the heights of all the students with 
blue shirts. these arrays will always have the same length, and each height 
will be a positive integer. Write a function that returns whether or not 
a class photo that follows the stated guidelines can be taken. 

Sample input:
refShirtHeights =  [5,8,1,3,4]
blueShirtHeights = [6,9,2,4,5]

Sample output:
true 

'''


def classPhotos(redShirtHeights, blueShirtHeights):
	# redShirtHeights.sort(reverse=true) 
	# blueShirtHeights.sort(reverse=true)
	redShirtHeights.sort()
	blueShirtHeights.sort()
	front = []
	rear = []
	if (redShirtHeights[0] < blueShirtHeights[0]):
		front = redShirtHeights
		rear = blueShirtHeights
	else:
		front = blueShirtHeights 
		rear = redShirtHeights
	
	for index in range(len(front)):
		if (front[index] >= rear[index]):
			return False
	
	return True 

redShirtHeights =  [5,8,1,3,4]
blueShirtHeights = [6,9,2,4,5]
print(classPhotos(redShirtHeights, blueShirtHeights))
