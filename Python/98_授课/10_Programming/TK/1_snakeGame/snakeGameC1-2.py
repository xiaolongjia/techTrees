#!C:\Python38\Python

import tkinter as tk
import random
import keyboard
import time
from PIL import Image, ImageTk

def update(x1,y1):
	canvas.delete(snake_body[0])
	snake_body.pop(0)
	snake_body.append(canvas.create_rectangle(x1,y1,x1+50,y1+50,fill='black'))

def goLeft():
    global x_snake,y_snake,direction

    if keyboard.is_pressed('left'):
        print("left pressed")
        x_snake-=50
        direction='left'

    elif direction=='left':
        x_snake-=50
        direction='left'

def goRight():
    global x_snake,y_snake,direction

    if keyboard.is_pressed('right'):
        print("right pressed")
        x_snake+=50
        direction='right'
    
    elif direction=='right':
        x_snake+=50
        direction='right'

def goUp():
    global x_snake,y_snake,direction

    if keyboard.is_pressed('up'):
        print("up pressed")
        y_snake-=50
        direction='up'

    elif direction=='up':
        y_snake-=50
        direction='up'

def goDown():
    global x_snake,y_snake,direction

    if keyboard.is_pressed('down'):
        print("down pressed")
        y_snake+=50
        direction='down'

    elif direction=='down':
        y_snake+=50
        direction='down'

def run():
    global direction

    if direction=='up':
        goLeft()
        goRight()
        goUp()

    elif direction=='down':
        goLeft()
        goRight()
        goDown()

    elif direction=='left':
        goUp()
        goDown()
        goLeft()

    elif direction=='right':
        goUp()
        goDown()
        goRight()

    update(x_snake, y_snake)

root = tk.Tk()
root.geometry("1536x864")

# create a canvas 
canvas = tk.Canvas(root,width=1536,height=864)
canvas.pack()

# create a snake 
x_snake = random.randrange(18,1369)
y_snake = random.randrange(7,808)
snake_body = []
for i in range(3):
    x_snake+=50
    snake_body.append(canvas.create_rectangle(x_snake,y_snake,x_snake+50,y_snake+50,fill='black'))
direction = 'up'

while(True):
    run()
    canvas.update()
    time.sleep(0.1)
root.mainloop()

