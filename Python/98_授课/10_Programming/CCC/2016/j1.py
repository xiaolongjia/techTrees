#!C:\Python\Python

win = 0
for i in range(6):
    result = input()
    if result == "W":
        win += 1

if win == 5 or win == 6:
    print("1")
elif win == 3 or win == 4:
    print("2")
elif win == 1 or win == 2:
    print("3")
else:
    print("-1")

