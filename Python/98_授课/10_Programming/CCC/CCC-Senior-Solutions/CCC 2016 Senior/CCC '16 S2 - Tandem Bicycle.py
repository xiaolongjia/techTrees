question = int(input())
num_racers = int(input())
team_1 = sorted([int(e) for e in input().split()])
team_2 = sorted([int(e) for e in input().split()])

magic_num = 0
for i in range(num_racers):
    if question == 1:
        magic_num += max(team_1[i], team_2[i])
    else:
        magic_num += max(team_1[num_racers-i-1], team_2[i])

print(magic_num)
