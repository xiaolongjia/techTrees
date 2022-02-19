#!C:\Python38\Python

import tkinter as tk
from PIL import Image, ImageTk 

window = tk.Tk()
window.geometry("300x400")
window.title("My Image")

myImage = Image.open('mypage.jpg')
myImage.thumbnail((300,400),Image.ANTIALIAS)
photo=ImageTk.PhotoImage(myImage)

myLabel = tk.Label(image=photo)
myLabel.grid(column=1,row=1)

window.mainloop()

