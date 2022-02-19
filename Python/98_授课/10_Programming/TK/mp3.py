#!C:\Python38\Python

# pip install playsound

# import playsound

# playsound.playsound('01.mp3')

from tkinter import * 

root = Tk()
root.geometry('400x300')

gNum=0

def changeColor():
	global gNum 
	gNum += 1
	if gNum % 2 == 0:
		clickLabel.config(bg='red')
	if gNum % 2 != 0:
		clickLabel.config(bg='blue')
	clickLabel.config(text=gNum)

button = Button(root, text='Click me', command=changeColor)
button.pack()

#Label
clickLabel = Label(text='click me', font=('microsoft yahei', 32, 'bold'))
#clickLabel.bind('<Button-1>', changeColor)
clickLabel.pack()
clickLabel.place(x=40, y=50)

root.mainloop()


