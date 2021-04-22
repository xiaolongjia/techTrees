#!C:\Python38\Python
#coding=utf-8

import requests as req

url = 'http://localhost:5000/upload'

with open('./test/img.jpg', 'rb') as f:

    files = {'image': f}

    r = req.post(url, files=files)
    print(r.text)
	