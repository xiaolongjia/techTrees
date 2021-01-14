num_people = int(input())
lis1 = input().split()
lis2 = input().split()

order = {}
works = True

for i in range(num_people):
    p1, p2 = lis1[i], lis2[i]
    if p1 == p2: #Same person
        works = False
        break
    elif p1 in order and order[p1] != p2 or p2 in order and order[p2] != p1: #Wrong person
        works = False
        break
    elif not p1 in order: #Not already assigned
        order[p1] = p2
        order[p2] = p1
print(works and "good" or "bad")
    
