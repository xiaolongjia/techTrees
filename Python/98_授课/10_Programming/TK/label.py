#!C:\Python38\Python


from tkinter import * 

root = Tk()
root.geometry('400x300')

gNum = 0

def changeColor(event):
    global gNum; gNum += 1
    if gNum % 2 == 0: colorLabel.config(bg='red')
    if gNum % 2 != 0: colorLabel.config(bg='blue')
	
	
# Label
colorLabel = Label(text='color', font=('microsoft yahei',32,'bold'))
colorLabel.bind('<Button-1>', changeColor)
colorLabel.pack()
colorLabel.place(x=10, y=10)

root.mainloop()
