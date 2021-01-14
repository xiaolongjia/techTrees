#!C:\Python\Python

minutes = 1789

counter = 0
myHours = int(minutes/60)
myhalfDays = int(myHours/12)
myHours %= 12
myMinutes = minutes%60
print("half days: ", myhalfDays)
print("hours:" , myHours)
print("minutes: ", myMinutes)

favoriteTimes = dict()
halfdayCounter = 0

for hour in range(1, 13):
    diff = None
    currHour = hour
    if hour >= 10:
        currHour -= 10
        if hour == 11:
            diff = 0
        elif hour == 12:
            diff = 1
        else:
            diff = -1
    
    if hour not in favoriteTimes:
        favoriteTimes[hour] = dict()

    for tenMinute in range(6):
        currDiff = diff
        if diff is None:
            currDiff = tenMinute - hour
        if ((tenMinute - currHour) == currDiff) and ((tenMinute + currDiff) in range(10)):
            time = str(hour)+":"+str(tenMinute)+str(tenMinute+currDiff)
            favoriteTimes[hour][tenMinute*10+tenMinute+currDiff] = time
            halfdayCounter += 1
print("each half day has ", halfdayCounter, " favorite time!")

if myhalfDays > 0:
    counter = myhalfDays*halfdayCounter

baselineHour = 12
if myHours > 0:
    baselineHour = myHours
    for i in range(0, myHours):
        if i == 0:
            counter += len(favoriteTimes[12])
        else:
            counter += len(favoriteTimes[i])

if myMinutes > 0:
    for lastMinute in favoriteTimes[baselineHour]:
        if myMinutes >= lastMinute:
            counter += 1

print(counter)
