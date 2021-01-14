num_games = int(input())
team1 = [int(e) for e in input().split()]
team2 = [int(e) for e in input().split()]

def totaled_lis(lis):
    for a in range(1, len(lis)):
        lis[a] += lis[a-1]
    return [0] + lis

tot1 = totaled_lis(team1)
tot2 = totaled_lis(team2)

for a in range (num_games, -1, -1):
    if tot1[a] == tot2[a]:
        break
print(a)
