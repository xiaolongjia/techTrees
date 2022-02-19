#!C:\Python38\Python

import keyboard

# pip3 install keyboard

while(True):
	if keyboard.is_pressed('right'):
		print("right")
		break
	elif keyboard.is_pressed('left'):
		print("left")
		break
	elif keyboard.is_pressed('up'):
		print("up")
		break
	elif keyboard.is_pressed('down'):
		print("down")
		break
