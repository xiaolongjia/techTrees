#!C:\Python\Python

magicFlag = True
total = None

for i in range(4):
    data = input()
    if magicFlag == True:
        currTotal = sum(map(int, data.split(" ")))
        if total == None:
            total = currTotal
        else:
            if total != currTotal:
                magicFlag = False
if magicFlag == True:
    print("magic")
else:
    print("not magic")

