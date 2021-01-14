#!C:\Python\Python

#Question 1
print(1 + 2 ** 2 ** 3)


#Question 3
if 'bar' in {'foo': 1, 'bar': 2, 'baz': 3}:
    print(1)
    print(2)
    if 'a' in 'qux':
        print(3)
print(4)


#Question 5
a = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri']
while a:
    if len(a) < 3:
        break
    print(a.pop())
print('Done.')


#Question 6
s = ""
n = 5
while n > 0:
    n -= 1
    if (n % 2) == 0:
        continue
    a = ['Mon', 'Tue', 'Fri']
    while a:
        s += str(n) + a.pop()
        if len(a) < 2: break
print(s)

