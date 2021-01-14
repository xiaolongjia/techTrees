#!C:\Python\Python

length = int(input())
y = input()
t = input()
same = 0

for i in range(length):
    if y[i] == t[i] and y[i] == "C":
        same += 1
print(same)

