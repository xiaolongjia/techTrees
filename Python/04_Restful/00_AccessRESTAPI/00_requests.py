#!C:\Python38\Python
#coding=utf-8

"""
import urllib2, urllib

github_url = 'https://api.github.com/user/repos'
password_manager = urllib2.HTTPPasswordMgrWithDefaultRealm()
password_manager.add_password(None, github_url, 'brp768', 'Sak_20170424')

auth = urllib2.HTTPBasicAuthHandler(password_manager) # create an authentication handler
opener = urllib2.build_opener(auth) # create an opener with the authentication handler
urllib2.install_opener(opener) # install the opener... 
request = urllib2.Request(github_url, urllib.urlencode({'name':'Test repo', 'description': 'Some test repository'})) # Manual encoding required
handler = urllib2.urlopen(request)
print(handler.read())
"""

import requests

print(requests.__version__)
print(requests.__copyright__)


#=================
# GET
#=================

r = requests.get('https://www.douban.com/search', params={'q': 'python', 'cat': '1001'}, headers={'User-Agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit'})
print('URL address:', r.url)
print('status code:', r.status_code)
print('header:', r.headers)
print('cookie:', r.cookies)
#print('data：', r.text)
#print('json data', r.json())

# pip install pillow 
from PIL import Image
from io import BytesIO
import requests

# 
# 请求获取图片并保存 (binary)
r = requests.get('https://pic3.zhimg.com/247d9814fec770e2c85cc858525208b2_is.jpg')
i = Image.open(BytesIO(r.content))
# 查看图片
i.show()  
# 将图片保存
with open('img.jpg', 'wb') as fd:
   for chunk in r.iter_content():
       fd.write(chunk)
	   
#=================
# POST
#=================

import json

# 带参数表单类型post请求
data={'custname': 'woodman','custtel':'13012345678','custemail':'woodman@11.com', 'size':'small'}
r = requests.post('http://httpbin.org/post', data=data)
print('url:', r.url)
print('data0:', r.text)

'''
url = 'https://api.github.com/some/endpoint'
payload = {'some': 'data'}
r = requests.post(url, data=json.dumps(payload))
print('data1:', r.text)

r = requests.post(url, json=payload)
print('data2:', r.text)
'''

