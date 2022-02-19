#!C:\Python38\Python

from tkinter import * 

root = Tk()
root.geometry('400x300')

def getListBoxElement(event):
   selection = event.widget.curselection()
   print(selection)
   index = selection[0] 
   value = event.widget.get(index) 
   print(index, '  ->  ', value )
   colorLabel.config(bg=value)
   

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

root.mainloop()


