#!C:\Python\Python
#coding=utf-8

#============================================
# string functions
#============================================

#----------------------------
# string methods
#----------------------------
# 1. 大小写转换 
mystring = 'hello! Tim'
print(mystring.lower()) #全部转为小写
print(mystring.upper()) #全部转为大写
print(mystring.title()) #每个单词首字符大写，其余小写
print(mystring.capitalize()) #整个字符串的首字母大写，其余小写
print(mystring.swapcase()) #大小写转换（大写换为小写；小写换为大写）
# 2. is判断
mystring = '123wjg'
print(mystring.isdecimal())
print(mystring.isdigit())
print(mystring.isnumeric())
print(mystring.isalpha())
print(mystring.isalnum())
print(mystring.islower())
print(mystring.isupper())
print(mystring.istitle()) #必须每个单词的首字母都大写才返回True
print(mystring.isspace())      #空格, \t, \n是space
print(mystring.isprintable())  #\t \n 不可打印
print(mystring.isidentifier()) #标识符定义：只能是字母或下划线开头、不能包含除数字、字母和下划线以外的任意字符
# 3. 填充
mystring = '*'
print(mystring.center(15,'-')) #以mystring为中心，指定长度后进行扩充，不指定扩充符则用空格
print(mystring.ljust(15, '-')) #以mystring为左边，向右扩充
print(mystring.rjust(15, '-')) #以mystring为右边，向左扩充
print(mystring.zfill(15))      #以0为填充符，在字符串左边补齐指定位数，如果字符串中有+ -号，0从+ -号之后开始填充
# 4. 搜索
mystring = 'hiello! Tim'
print(mystring.count('l'))
print(mystring.count('l', 0, 3))     # start index, end index, 不包括右边界
print(mystring.endswith('o', 0, 5))  # 第一个参数可以是tuple, 满足一个即为True
print(mystring.startswith('l', 1, 4))
print(mystring.find('i'))  #返回第一个找到的index, 如果没有返回-1
print(mystring.rfind('i')) #返回搜索到的最右边子串的位置
print(mystring.index('i')) #与find功能一样，如果没有找到则报错ValueError
print(mystring.rindex('i'))
print('i' in mystring) # in 关键字返回是否存在字符串中
# 5. 替换
print(mystring.replace('l','n'))
print(mystring.replace('l','n',1))
print(mystring.expandtabs(20),"|") #将\t转为空格
# maketrans(str1, str2),  translate(maptable)
in_str='abcxyz'
out_str='123456'
# maketrans()生成映射表
map_table=str.maketrans(in_str,out_str)
print(map_table)
# 使用translate()进行映射
my_love='I love Fairy'
result=my_love.translate(map_table)
print(result)
# 6. 分割
my_string = '1,2,3'
print(my_string.split(',',1))
print(my_string.rsplit(',',1)) #从右向左进行分割
my_string = '1 2 3'
print(my_string.split(maxsplit=1))
print(my_string.rsplit(maxsplit=1))
my_string = '1 2 3 \n 1 2 3'
print(my_string.split('\n'))
print(my_string.splitlines())
# 7. join 将可迭代对象(iterable)中的元素使用S连接起来。注意，iterable中必须全部是字符串类型，否则报错。
my_string = 'ABCDC'
print(' '.join(my_string))
my_string2 = 'ABCDC'
print("%s %s"%(my_string, my_string2))

# 8. strip, lstrip, rstrip
my_string = '    CBA    '
print(my_string.strip())
print(my_string.lstrip())
print(my_string.rstrip())
# 9. length and format 
print(len(my_string))
my_string = "hello"
my_world = "world"
print("hello! {0[2]} to {1[2]}".format(my_string, my_world))
# 10. string to ascii
print(ord('a'))
print(chr(ord('a')))
# 11. reverse string
print(my_string[::-1])


