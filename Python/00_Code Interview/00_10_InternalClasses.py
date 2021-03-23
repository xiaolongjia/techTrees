#!C:\Python38\Python
#coding=utf-8


from datetime import datetime, timedelta, timezone
from collections import namedtuple, deque, defaultdict, OrderedDict, ChainMap, Counter
import os, argparse
import hashlib
import hmac
import itertools
from urllib import request
from xml.parsers.expat import ParserCreate
from html.parser import HTMLParser
from html.entities import name2codepoint

print("=========== datetime ==============")
now = datetime.now()
print(now)
print(type(now))

# timestamp(), fromtimestamp(), utcfromtimestamp()
print(now.timestamp()) # seconds from 1970 01-01 00:00
seconds = 102391230
print(datetime.fromtimestamp(seconds)) # seconds to local datetime 
print(datetime.utcfromtimestamp(seconds))  # seconds to utc datetime

# string to datetime object 
cday = datetime.strptime('2015-6-1 18:19:59', '%Y-%m-%d %H:%M:%S')
print(cday)
# datetime object to string 
print(now.strftime('%Y-%m-%d %H:%M:%S'))
# time calculation
print(now + timedelta(hours=10))
print(now - timedelta(days=1, seconds=30))
print(now - timedelta(days=1) +  timedelta(hours=10))
# timezone 
utc_dt = datetime.utcnow().replace(tzinfo=timezone.utc)
print(utc_dt)
bj_dt = utc_dt.astimezone(timezone(timedelta(hours=8)))
print(bj_dt)
tokyo_dt = utc_dt.astimezone(timezone(timedelta(hours=9)))
print(tokyo_dt)

print("=========== collections ==============")
# named tuple 
Point = namedtuple('Point', ['x', 'y'])
p = Point(1,2)
print(p, p.x, p.y) # Point(x=1, y=2) 1 2
# double link
q = deque(['a', 'b', 'c'])
q.append('x')
print(q)
q.appendleft('y')
print(q)
# defaultdict
dd = defaultdict(lambda: 'N/A')
dd['key1'] = 'abc'
print(dd['key2'])
# OrderedDict
d = dict([('a', 1), ('b', 2), ('c', 3)])
print(d)
od = OrderedDict([('a', 1), ('b', 2), ('c', 3)])
print(od)
od = OrderedDict()
od['z'] = 1
od['x'] = 2
od['y'] = 3
print(list(od.keys()))
# ChainMap
defaults = {
    'color': 'red',
    'user': 'guest'
}

parser = argparse.ArgumentParser()
parser.add_argument('-u', '--user')
parser.add_argument('-c', '--color')
namespace = parser.parse_args()
command_line_args = { k: v for k, v in vars(namespace).items() if v }

combined = ChainMap(command_line_args, os.environ, defaults)

print('color=%s' % combined['color'])
print('user=%s' % combined['user'])
# Counter (case sensetive)
c = Counter()
c.update("today is Sunday")
print(c)
print(c['t'])

print("=========== hashlib ==============")
md5 = hashlib.md5()
md5.update('how to use md5 in python hashlib?'.encode('utf-8'))
print("MD5 : ", md5.hexdigest())

sha1 = hashlib.sha1()
sha1.update('how to use md5 in python hashlib?'.encode('utf-8'))
print("SHA1: ", sha1.hexdigest())

print("=========== hmac ==============")
message = b'Hello, world!'
print(message)
key = b'secret'
print(key)
h = hmac.new(key, message, digestmod='MD5')
print(h.hexdigest())

print("=========== itertools ==============")
# count(), cycle(), repeat(), takewhile()
'''
natuals = itertools.count(1)
for i in natuals:
    print(i)
'''
'''
cs = itertools.cycle('ABC')
for i in cs:
    print(i)
'''
ns = itertools.repeat('A', 3)
for i in ns:
    print(i)

natuals = itertools.count(1)
ns = itertools.takewhile(lambda x: x <= 10, natuals)
print(list(ns))

for c in itertools.chain('ABC', 'XYZ'):
    print(c)

for key, group in itertools.groupby('AAABBBCCAAA'):
    print(key, list(group))

# context management 

class Query(object):

    def __init__(self, name):
        self.name = name

    def __enter__(self):
        print('Begin')
        return self
    
    def __exit__(self, exc_type, exc_value, traceback):
        if exc_type:
            print('Error')
        else:
            print('End')
    
    def query(self):
        print('Query info about %s...' % self.name)

with Query('Bob') as q:
    q.query()


print("=========== urllib ==============")

req = request.Request('http://www.douban.com/')
req.add_header('User-Agent', 'Mozilla/6.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/8.0 Mobile/10A5376e Safari/8536.25')
with request.urlopen(req) as f:
    print('Status:', f.status, f.reason)
    for k, v in f.getheaders():
        print('%s: %s' % (k, v))
    print('Data:', f.read().decode('utf-8'))

print("=========== xml ==============")

class DefaultSaxHandler(object):
    def start_element(self, name, attrs):
        print('sax:start_element: %s, attrs: %s' % (name, str(attrs)))

    def end_element(self, name):
        print('sax:end_element: %s' % name)

    def char_data(self, text):
        print('sax:char_data: %s' % text)

xml = r'''<?xml version="1.0"?>
<ol>
    <li><a href="/python">Python</a></li>
    <li><a href="/ruby">Ruby</a></li>
</ol>
'''

handler = DefaultSaxHandler()
parser = ParserCreate()
parser.StartElementHandler = handler.start_element
parser.EndElementHandler = handler.end_element
parser.CharacterDataHandler = handler.char_data
parser.Parse(xml)

print("=========== html parser ==============")

class MyHTMLParser(HTMLParser):

    def handle_starttag(self, tag, attrs):
        print('<%s>' % tag)

    def handle_endtag(self, tag):
        print('</%s>' % tag)

    def handle_startendtag(self, tag, attrs):
        print('<%s/>' % tag)

    def handle_data(self, data):
        print(data)

    def handle_comment(self, data):
        print('<!--', data, '-->')

    def handle_entityref(self, name):
        print('&%s;' % name)

    def handle_charref(self, name):
        print('&#%s;' % name)

parser = MyHTMLParser()
parser.feed('''<html>
<head></head>
<body>
<!-- test html parser -->
    <p>Some <a href=\"#\">html</a> HTML&nbsp;tutorial...<br>END</p>
</body></html>''')
