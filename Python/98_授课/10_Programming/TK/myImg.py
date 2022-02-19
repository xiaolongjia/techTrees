#!C:\Python38\Python

import tkinter as tk
from PIL import Image,ImageTk

window=tk.Tk()
window.geometry("600x800")
window.title(" My Image ")

image=Image.open('mypage.jpg')
image.thumbnail((600,800),Image.ANTIALIAS)
photo=ImageTk.PhotoImage(image)

label_image=tk.Label(image=photo)
label_image.grid(column=0,row=0)

window.mainloop()