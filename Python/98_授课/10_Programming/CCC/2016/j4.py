#!C:\Python\Python

time = input()
(hour, minutes) = map(int, time.split(":"))
allMinutes = hour*60 + minutes
freeMinutes, busyMinutes, leftMinutes = 0,0,0
cost = 0

if hour < 7:
    freeMinutes = 7*60 - allMinutes
    if freeMinutes >= 2*60:
        cost = 2*60
    else:
        busyMinutes = 2*60 - freeMinutes 
        if busyMinutes*2 > 3*60: 
            leftMinutes = (busyMinutes*2 - 3*60)/2 
            cost = freeMinutes + 3*60 + leftMinutes
        else:
            cost = freeMinutes + busyMinutes*2
elif (hour >= 7 and hour < 10):
    busyMinutes = 10*60 - allMinutes
    cost = (2*60 - busyMinutes/2) + busyMinutes
elif (hour >= 10 and hour < 15):
    freeMinutes = 15*60 - allMinutes
    if freeMinutes >= 2*60:
        cost = 2*60
    else:
        busyMinutes = 2*60 - freeMinutes 
        if busyMinutes*2 > 3*60: 
            leftMinutes = (busyMinutes*2 - 3*60)/2 
            cost = freeMinutes + 3*60 + leftMinutes
        else:
            cost = freeMinutes + busyMinutes*2
elif (hour >=15 and hour < 19):
    busyMinutes = 19*60 - allMinutes
    cost = (2*60 - busyMinutes/2) + busyMinutes
else:
    cost = 2*60

print(int(cost))
print(str(int((allMinutes + cost)/60)) + ":" + str(int((allMinutes + cost)%60)))

