#!C:\Python\Python

# Global Relay questions
#
cars = [7, 9, 13, 3, 12, 5, 11, 1, 1]
dispensers = [18, 21, 13, 19]
waittime = [0, 0, 0, 0]
total = 0
for carindex in range(len(cars)):
    minIndex   =99999999
    minwaittime=99999999
    for i in range(len(dispensers)):
        if dispensers[i] >= cars[carindex]:
            if waittime[i] < minwaittime:
                minwaittime = waittime[i]
                minIndex = i
    if minIndex == 999999:
        print(-1)
        exit()
    if carindex == len(cars) -1 :
        break
    else:
        dispensers[minIndex] -= cars[carindex]
        waittime[minIndex] += cars[carindex]
print(max(waittime))
exit()
#------------------


t = 0
xs = 0
ys = 0
zs = 0
list1.append(0)
i = list1.pop(0)
while True:
	if xs == 0:
		if i <= x:
			xs = i - 1
			x -= 1
			i = list1.pop(0)
			if len(list1) == 0:
				break
	else:
		xs -= 1
		x -= 1
	if ys == 0:
		if i <= y:
			ys = i - 1
			y -= 1
			i = list1.pop(0)
			if len(list1) == 0:
				break
	else:
		ys -= 1
		y -= 1
	if zs == 0:
		if i <= z:
			zs = i - 1
			z -= 1
			i = list1.pop(0)
			if len(list1) == 0:
				break
	else:
		zs -= 1
		z -= 1
	t += 1
print(t)
