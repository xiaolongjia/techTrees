#!C:\Python\Python

#Question 1
myStr = "192.168.1.2"
print("[.]".join(myStr.split(".")))

#Question 2
myStr = 'aAAbBbb'
myStr2 = 'aAb'

counter = 0
for c in myStr2:
    counter += myStr.count(c)
print(counter)

#Question 3
moves = 'ULLDDDRLRR'
x=y=0

for move in moves:
    if move == 'U':
        y += 1
    elif move == 'D':
        y -= 1
    elif move == 'L':
        x += 1
    else:
        x -= 1
print(x==0 and y==0)
print((moves.count('U') == moves.count('D')) and (moves.count('L') == moves.count('R')))
