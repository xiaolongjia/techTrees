#!C:\Python\Python
#coding=utf-8

'''
Min Max Stack Construction

Write a MinMaxStack class for a Min Max Stack. The class should support:
- pushing and popping values on and off the stack 
- peeking at the value at the top of the stack 
- Getting both the minimum and the maximum values in the stack at any given point in time 

All class methods, when considered independently, should run in constant time and with constant space. 
'''

class MinMaxStack:
    def __init__(self):
		self.MinMaxStack = []
        self.stack = []
        
    def peek(self):
        return self.stack[len(self.stack)-1]

    def pop(self):
		self.MinMaxStack.pop()
        return self.stack.pop()

    def push(self, number):
		newMinMax = {"min": number , "max": number}
		if len(self.MinMaxStack):
			lastMinMax = self.MinMaxStack[len(self.MinMaxStack)-1]
			newMinMax["min"] = min(lastMinMax["min"], newMinMax["min"])
			newMinMax["max"] = max(lastMinMax["max"], newMinMax["max"])
		self.MinMaxStack.append(newMinMax)
        self.stack.append(number)

    def getMin(self):
        return (self.MinMaxStack[len(self.MinMaxStack)-1]["min"])

    def getMax(self):
        return (self.MinMaxStack[len(self.MinMaxStack)-1]["max"])
