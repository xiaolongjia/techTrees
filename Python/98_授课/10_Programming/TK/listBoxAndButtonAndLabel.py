#!C:\Python38\Python

from tkinter import * 

root = Tk()
root.geometry('400x300')

color = "white"

def changeColor():
    colorLabel.config(bg=color)

def getListBoxElement(event):
    global color 
    selection = event.widget.curselection()
    index = selection[0]
    value = event.widget.get(index)
    print(index,' -> ',value)
    color = value 

#Button 
colorButton = Button(root, text="Change Color",command=changeColor)
colorButton.pack()
colorButton.place(x=10, y=10)

# Listbox
listBox  = Listbox(root)
colorList = ["white", "black", "red", "green", "blue", "cyan", "yellow", "magenta"]
for item in colorList:
    listBox.insert(0,item)

listBox.pack()
listBox.place(x=10, y=50)
listBox.bind('<<ListboxSelect>>', getListBoxElement)

# Label
colorLabel = Label(text='color', font=('microsoft yahei',32,'bold'))
colorLabel.pack()
colorLabel.place(x=10, y=220)


root.mainloop()
