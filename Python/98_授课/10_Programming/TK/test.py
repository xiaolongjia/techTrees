#!C:\Python38\Python

import tkinter as tk

window = tk.Tk()
window.geometry("300x400")
window.title("My Entry")

myEntry = tk.Entry(window)
myEntry.grid(column=1,row=1)

def aaa():
	myInput = myEntry.get() 
	print(myInput)

button = tk.Button(window, text="Get input", command=aaaa)
button.grid(column=1, row=3)

window.mainloop()
