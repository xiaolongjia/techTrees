#!C:\Python38\Python

import tkinter as tk

window=tk.Tk()
window.geometry("300x400")
window.title(" My entry ")

nameEntry = tk.Entry(window)
nameEntry.grid(column=1,row=1)


def getInput():
	name=nameEntry.get()
	print(name)


button=tk.Button(window,text="Get input",command=getInput)
button.grid(column=1,row=3)

window.mainloop()
