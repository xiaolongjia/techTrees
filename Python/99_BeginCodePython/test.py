import turtle
from itertools import cycle
import time

import tkinter
from datetime import date, datetime

#draw cycle
#colors = cycle(['red', 'orange', 'yellow', 'green', 'blue', 'purple'])
#
#def draw_shape(size, angle, shift, shape):
#    turtle.pencolor(next(colors))
#    next_shape = ''
#    if shape == 'circle':
#    	turtle.circle(size)
#    	next_shape = 'square'
#    elif shape == 'square':
#    	for i in range(4):
#    		turtle.forward(size*2)
#    		turtle.left(90)
#    	next_shape = 'cycle'
#    turtle.right(angle)
#    turtle.forward(shift)
#    draw_shape(size + 5, angle + 1, shift + 1, next_shape)
#
#turtle.bgcolor('black')
#turtle.speed('fast')
#turtle.pensize(4)
#draw_shape(30, 0, 1, 'circle')

#draw star
#size = 300
#points = 5
#angle = 180 - (180 / points)
#
#turtle.color('red')
#turtle.pensize(4)
#turtle.begin_fill()
#
#for i in range(points):
#	turtle.forward(size)
#	turtle.right(angle)
#
#turtle.end_fill()
#time.sleep(60)
#exit()


#import tkinter
#root = tkinter.Tk()
#label = tkinter.Label(root,text="Hello,tkinter!")
#label.pack()
#button1 = tkinter.Button(root,text="Button1")
#button1.pack(side = tkinter.LEFT)
#button2 = tkinter.Button(root,text ="Button2")
#button2.pack(side = tkinter.RIGHT)
#root.mainloop()


root = tkinter.Tk()
c = tkinter.Canvas(root, width=800, height=800, bg='black')
c.pack()
c.create_text(100, 50, anchor='w', fill='orange', font='Arial 28 bold underline', text='My Countdown Calendar')
root.mainloop()

