#!C:\Python\Python

start = (-9, -10)
end = (5, 8)
charge = 40

minDistance = abs(start[0] - end[0]) + abs(start[1] - end[1])
if charge < minDistance:
    print(False)
elif (charge - minDistance)%2 == 0 :
    print(True)

