fav_team = int(input())
scoring = [[0,0,0,0] for i in range(4)]
matches = [[a+1,b+1] for a in range(2) for b in range(4)] + [[3,4]]
matches.remove([2,1])
matches.remove([1,1])
matches.remove([2,2])

for game in range(int(input())):
    t1, t2, s1, s2 = [int (e) for e in input().split()]
    if s1>s2:
        scoring[t1-1][t2-1] += 3
    elif s1<s2:
        scoring[t2-1][t1-1] += 3
    else:
        scoring[t2-1][t1-1] += 1
        scoring[t1-1][t2-1] += 1
        
    matches.remove([t1,t2])

combinations = [scoring]
for game in matches:
    new_combs = []
    for item in combinations: #Every current combination branches into 3 more
        for i in range(3): #Win, lose, tie
            comb = item[:]
            if i==1:
                item[game[0]-1][game[1]-1] += 3
            elif i==2:
                item[game[1]-1][game[0]-1] += 3
            else:
                item[game[0]-1][game[1]-1] += 1
                item[game[1]-1][game[0]-1] += 1
            new_combs.append(comb)
    combinations = new_combs
        
    
works = 0
for pos_outcome in combinations:
    highest = 0
    ref = 0
    occured = 0
    for a in range(4):
        tot = sum(pos_outcome[a])
        if tot > highest:
            highest = tot
            occured = 1
            ref = a + 1
        elif tot == highest:
            occured += 1
    if ref == fav_team and occured == 1:
        works += 1

print(works)

    
