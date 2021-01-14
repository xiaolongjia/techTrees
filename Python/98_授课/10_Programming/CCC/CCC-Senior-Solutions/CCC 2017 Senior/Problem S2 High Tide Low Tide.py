import math
tides = int(input())
tide_list = sorted([int(e) for e in input().split()])

wanted = []
if tides%2 != 0: #It was an odd number
    wanted.append(tide_list[tides//2])
    
for a in range (tides//2):
    if tides%2 == 0: #even
        wanted.append(tide_list[tides//2 - 1 - a])
        wanted.append(tide_list[math.ceil(tides/2) + a])
    else:
        wanted.append(tide_list[math.ceil(tides/2) + a])
        wanted.append(tide_list[tides//2 - 1 - a])
        

print(*wanted)
