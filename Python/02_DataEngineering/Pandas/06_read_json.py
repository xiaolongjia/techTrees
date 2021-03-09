#!C:\Anaconda3\python.exe

import numpy as np
import pandas as pd
import os
import json

# json viewer 
# http://jsonviewer.stack.hu/

#data = json.load(open('06_example.json'))
#print(data)
#frame = pd.DataFrame(data)
#print(frame)

frame = pd.read_json('06_example.json')
print(frame)

'''
https://vimsky.com/examples/usage/python-pandas.read_json.html

参数：
path_or_buf：a valid JSON str, path object 或 file-like object
任何有效的字符串路径都是可以接受的。该字符串可以是URL。有效的URL方案包括http，ftp，s3和file。对于文件URL，需要一个主机。本地文件可以是：file://localhost/path/to/table.json。

如果要传递路径对象，pandas会接受任何os.PathLike。

对于file-like对象，我们指的是带有read()方法，例如文件处理程序(例如，通过内置open功能)或StringIO。

orient：str
预期的JSON字符串格式的指示。兼容的JSON字符串可以由to_json()具有相应的东方值。可能的方向集是：

'split'：dict喜欢{index -> [index], columns -> [columns], data -> [values]}

'records'：list喜欢[{column -> value}, ... , {column -> value}]

'index'：dict喜欢{index -> {column -> value}}

'columns'：dict喜欢{column -> {index -> value}}

'values'：只是值数组

允许值和默认值取决于typ参数。

当typ == 'series'，

允许的东方{'split','records','index'}

默认是'index'

Series 索引对于东方而言必须是唯一的'index'。

当typ == 'frame'，

允许的东方{'split','records','index', 'columns','values', 'table'}

默认是'columns'

DataFrame索引对于东方而言必须是唯一的'index'和'columns'。

DataFrame列对于东方对象必须是唯一的'index'，'columns'和'records'。

0.23.0版中的新功能：‘table’作为允许的值orient论点

typ：{‘frame’, ‘series’}, 默认为 ‘frame’
要恢复的对象的类型。

dtype：bool 或 dict, 默认为 None
如果为True，则推断dtypes；如果将列的字典指定为dtype，则使用这些字典；如果为False，则根本不推断dtype，仅适用于数据。

对全部orient值除外'table'，默认值为True。

在版本0.25.0中进行了更改：不适用于orient='table'。

convert_axes：bool, 默认为 None
尝试将轴转换为适当的dtype。

对全部orient值除外'table'，默认值为True。

在版本0.25.0中进行了更改：不适用于orient='table'。

convert_dates：bool 或 list of str, 默认为 True
要解析日期的列列表。如果为True，则尝试解析类似日期的列。列标签与日期类似，如果

它以'_at'，

它以'_time'，

它始于'timestamp'，

它是'modified'， 或者

它是'date'。

keep_default_dates：bool, 默认为 True
如果解析日期，则解析默认的类似日期的列。

numpy：bool, 默认为 False
直接解码为numpy数组。仅支持数字数据，但支持非数字列和索引标签。还请注意，如果numpy = True，则每个术语的JSON顺序必须相同。

从1.0.0版开始不推荐使用。

precise_float：bool, 默认为 False
设置为在将字符串解码为双精度值时启用更高精度(strtod)函数的使用。默认值(False)是使用快速但不太精确的内置功能。

date_unit：str, 默认为 None
用于检测是否转换​​日期的时间戳单位。默认行为是尝试检测正确的精度，但是如果不需要此精度，则传递‘s’，‘ms’，‘us’或‘ns’之一以分别分别强制分析秒，毫秒，微秒或纳秒。

encoding：str, 默认为 is ‘utf-8’
用于解码py3字节的编码。

lines：bool, 默认为 False
每行将文件作为json对象读取。

chunksize：int, 可选参数
返回JsonReader对象以进行迭代。看到行分隔的json文档有关更多信息chunksize。只有在以下情况下才能通过lines=True。如果为None，则文件将一次全部读入内存。

0.21.0版中的新功能。

compression：{‘infer’, ‘gzip’, ‘bz2’, ‘zip’, ‘xz’, None}, 默认为 ‘infer’
用于即时解压缩on-disk数据。如果‘infer’，则如果path_or_buf是分别以‘.gz’，‘.bz2’，‘.zip’或‘xz’结尾的字符串，则使用gzip，bz2，zip或xz，否则不进行解压缩。如果使用‘zip’，则ZIP文件必须仅包含一个要读取的数据文件。设置为None则不进行解压缩。

0.21.0版中的新功能。

返回值：
Series
返回的类型取决于的值typ。
'''
