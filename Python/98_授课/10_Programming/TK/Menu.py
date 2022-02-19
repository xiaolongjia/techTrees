#!C:\Python38\Python

import tkinter as tk

root = tk.Tk()
root.geometry('400x300')
root.title("My Menu")


def newFile():
    print("new file created")

def openFile():
    print("Open file")
	
def saveFile():
    print("save file")

myMenu = tk.Menu(root)

filemenu = tk.Menu(myMenu, tearoff=0, activebackground='blue', activeforeground='red')
myMenu.add_cascade(label='File', menu=filemenu)

filemenu.add_command(label='New', command=newFile)
filemenu.add_command(label='Open', command=openFile)
filemenu.add_command(label='Save', command=saveFile)
filemenu.add_separator()
filemenu.add_command(label='Exit', command=root.quit) 



submenu = tk.Menu(filemenu)
filemenu.add_cascade(label='subMenu', menu=submenu)
submenu.add_command(label='Submenu_1')


show_all = tk.BooleanVar()
show_all.set(True)
show_done = tk.BooleanVar()
show_not_done = tk.BooleanVar()

def dispButton():
    global show_all, show_done, show_not_done
    print("show all: ", show_all.get())
    print("show done: ", show_done.get())
    print("show not done: ", show_not_done.get())

view_menu = tk.Menu(myMenu)
view_menu.add_checkbutton(label="Show All", onvalue=1, offvalue=0, variable=show_all, command=dispButton)
view_menu.add_checkbutton(label="Show Done", onvalue=1, offvalue=0, variable=show_done, command=dispButton)
view_menu.add_checkbutton(label="Show Not Done", onvalue=1, offvalue=0, variable=show_not_done, command=dispButton)
myMenu.add_cascade(label='View', menu=view_menu)


root.config(menu=myMenu)

root.mainloop()
