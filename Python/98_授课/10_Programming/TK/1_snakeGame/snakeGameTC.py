#!C:\Python38\Python

import tkinter as tk 
import random 
import keyboard 
import time 
from PIL import Image, ImageTk

def update(x1, y1):
	global x_snake, y_snake, x_mouse, y_mouse, mouse
	
	x_snake = 1468 if x_snake <18 else x_snake
	x_snake = 18 if x_snake >1468 else x_snake
	y_snake = 807 if y_snake<7 else y_snake 
	y_snake = 7 if y_snake>807 else y_snake

	if (x1+25) in range(x_mouse, x_mouse+51) and (y1+25) in range(y_mouse, y_mouse+51):
		# snake body increased. 
		snake_body.append(canvas.create_rectangle(x1, y1, x1+50, y1+50, fill='black'))

		# remove mouse 
		canvas.delete(mouse)
		
		# create mouse 
		x_mouse = random.randrange(18,1469,50)
		y_mouse = random.randrange(7,808,50)
		mouse = canvas.create_rectangle(x_mouse, y_mouse, x_mouse+50, y_mouse+50, fill='red')

	canvas.delete(snake_body[0])
	snake_body.pop(0)
	snake_body.append(canvas.create_rectangle(x1, y1, x1+50, y1+50, fill='black'))

def goLeft():
	global x_snake, y_snake, direction
	
	if keyboard.is_pressed('left'):
		x_snake -= 50
		direction = 'left'
	elif direction == 'left':
		x_snake -= 50
		direction = 'left'

def goRight():
	global x_snake, y_snake, direction
	
	if keyboard.is_pressed('right'):
		x_snake += 50
		direction = 'right'
	elif direction == 'right':
		x_snake += 50
		direction = 'right'

def goUp():
    global x_snake,y_snake,direction

    if keyboard.is_pressed('up'):
        y_snake-=50
        direction='up'
    elif direction=='up':
        y_snake-=50
        direction='up'

def goDown():
    global x_snake,y_snake,direction

    if keyboard.is_pressed('down'):
        y_snake+=50
        direction='down'
    elif direction=='down':
        y_snake+=50
        direction='down'

def myRun():
	global direction 
	
	if keyboard.is_pressed('esc'):
		img = ImageTk.PhotoImage(Image.open("snakeGame.png").resize((1536,864)))
		canvas.create_image(752, 400, image=img)
		canvas.update()
		time.sleep(2)
		root.destroy()
	
	if direction == 'up':
		goLeft()
		goRight()
		goUp()
	elif direction == 'down':
		goLeft()
		goRight()
		goDown()
	elif direction == 'left':
		goUp()
		goDown()
		goLeft()
	elif direction == 'right':
		goUp()
		goDown()
		goRight()

	update(x_snake, y_snake)

root = tk.Tk()
root.geometry("1536x864")

# create a canvas 
canvas = tk.Canvas(root, width=1536, height=864)
canvas.pack()

# create a mouse 
x_mouse = random.randrange(18,1469)
y_mouse = random.randrange(7,808,50)
mouse = canvas.create_rectangle(x_mouse, y_mouse, x_mouse+50, y_mouse+50, fill='red')

# create a snake 
x_snake = random.randrange(18, 1369)
y_snake = random.randrange(7, 808) 
snake_body = []
for i in range(3):
	x_snake += 50
	snake_body.append(canvas.create_rectangle(x_snake, y_snake, x_snake+50, y_snake+50, fill='black'))
direction = 'up'

while(True):
	myRun()
	canvas.update()
	time.sleep(0.1)

root.mainloop()
