#!C:\Python38\Python

from tkinter import * 

root = Tk()
root.geometry('400x300')

gColor = 'red' 

def getListBoxElement(event):
   global gColor
   selection = event.widget.curselection()
   print(selection)
   index = selection[0] 
   value = event.widget.get(index) 
   print(index, '  ->  ', value )
   gColor = value 

def changeColor():
   global gColor
   colorLabel.config(bg=gColor)

# ListBox 
myListBox = Listbox(root) 
colorList = ['white', 'black', 'red', 'green', 'blue', 'cyan', 'yellow', 'magenta']

for item in colorList:
   myListBox.insert(0, item)

myListBox.pack()
myListBox.place(x=10, y=50)
myListBox.selection_set(2) # set default selection. 
myListBox.bind('<<ListboxSelect>>', getListBoxElement)

# Label 
colorLabel = Label(text='Color', font = ('microsoft yahei', 32, 'bold'))
colorLabel.pack()
colorLabel.place(x=10, y=220)

# button 
button = Button(root, text="Click Me",command=changeColor)
button.pack()
button.place(x=10, y=100)


root.mainloop()


