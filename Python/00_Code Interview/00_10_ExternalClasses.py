#!C:\Anaconda3\Python
#coding=utf-8


from pillow import Image

print("=============== PIL ==================")

im = Image.open('00_10_ExternalClasses.png')
w, h = im.size
print('Original image size: %sx%s' % (w, h))

im.thumbnail((w//2, h//2))
print('Resize image to: %sx%s' % (w//2, h//2))
im.save('00_10_ExternalClasses_0.jpg', 'jpeg')
