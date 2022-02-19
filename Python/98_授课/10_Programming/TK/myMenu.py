#!C:\Python38\Python

import tkinter as tk 

root = tk.T k()
root.geometry('400x300')
root.title('Menu')

def newFile():
    print("New File created")

def openFile():
    print("opened file successfully")

def saveFile():
    print("file saved!")

def delFile():
    print("file removed!")

myMenu = tk.Menu(root)

filemenu = tk.Menu(myMenu, tearoff=0)
myMenu.add_cascade(label='File', menu=filemenu)

filemenu.add_command(label='New', command=newFile)
filemenu.add_command(label='Open', command=openFile)
filemenu.add_command(label='Save', command=saveFile)
filemenu.add_command(label='Delete', command=delFile)
filemenu.add_separator()
filemenu.add_command(label='Exit', command=root.quit)

...
submenu = tk.Menu(filemenu, tearoff=0)
filemenu.add_cascade(label='Submenu', menu=submenu)
submenu.add_command(label='Submenu1')


show_all = tk.BooleanVar()
show_all.set(True)

def dispButton():
    global show_all
    print('show all:', show_all.get())

view_menu = tk.Menu(myMenu, tearoff=0) 
myMenu.add_cascade(label='View', menu=view_menu)

view_menu.add_checkbutton(label='Show All', onvalue=1, offvalue=0, variable=show_all, command=dispButton)
...



root.config(menu=myMenu)
root.mainloop()

