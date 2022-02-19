#!C:\Python38\Python


from tkinter import * 

root = Tk()
root.geometry('400x300')

gNum = 0

def changeColor():
    global gNum; gNum += 1
    if gNum % 2 == 0: colorLabel.config(bg='red')
    if gNum % 2 != 0: colorLabel.config(bg='blue')
	
	
# Label
colorLabel = Label(text='color', font=('microsoft yahei',20,'bold'))
colorLabel.pack()
colorLabel.place(x=10, y=10)

# Button 
button = Button(root, text="Change Color",command=changeColor)
button.pack()
button.place(x=10, y=100)

root.mainloop()
