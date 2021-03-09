#!C:\Anaconda3\python.exe

import os
import json
import numpy as np
import pandas as pd

# read html from URL
web_frames = pd.read_html("http://www.meccanismocomplesso.org/meccanismo-complesso-sito-2/classifica-punteggio/")
print(web_frames[0])

#print(np.random.random(100))
#print(np.random.random(10,10))

# read html from file
# create html 
frame = pd.DataFrame(pd.DataFrame(np.random.random((4,4)), index=['white', 'black', 'red', 'blue'], columns=['up', 'down', 'right', 'left']))
print(frame)

s = ['<HTML>']
s.append('<HEAD><TITLE>Python</TITLE></HEAD>')
s.append('<BODY>')
s.append(frame.to_html())
s.append('</BODY></HTML>')
html = ''.join(s)
print("==================== html ====================")
print(html)
html_file = open('08_read_html.html', 'w')
html_file.write(html)
html_file.close()
# read html 
web_frames = pd.read_html("08_read_html.html")
print(web_frames[0])
