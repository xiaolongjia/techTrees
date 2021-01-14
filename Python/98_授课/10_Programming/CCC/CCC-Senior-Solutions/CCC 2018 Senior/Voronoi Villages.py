#Get all the data and sort it
valleys = sorted([int(input()) for valley in range(int(input()))])

#Loop through to find smallest differance 
lowest = 99999999999999999999999999999999999
for a in range(1,len(valleys)-1): #Doesn't check first or last 
    cur = valleys[a]
    start = (valleys[a-1] + cur)/2
    end = (valleys[a+1] + cur)/2

    total = end - start
    if total < lowest:
        lowest = total

print(lowest)
    
