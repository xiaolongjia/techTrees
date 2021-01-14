import sys
input = sys.stdin.readline

Nstops, Nspecials = [int(e) for e in input().split()]
specials = set()
for special in input().split():
    specials.add(int(special))
paths = [[-1, int(special)]]

connections = [[] for i in range(Nstops)]
for road in range (Nstops-1):
    st,end = [int(e) for e in input().split()]
    connections[st].append(end)
    connections[end].append(st)

#Removing connections that are not needed
strays = 0

def check(num):
    global strays
    if not num in specials and len(connections[num]) == 1:
        only_connection = connections[num][0]
        connections[only_connection].remove(num) #Making the only connection not connected
        connections[num] = []
        check(only_connection)
        strays += 1
            
for stop in range(Nstops):
    check(stop)
        

#Using double BFS to find the longest path
for a in range(2):
    path_length = -1
    while paths:
        new_paths = []
        for path in paths:
            possible_paths = connections[path[-1]]
            for next_stop in possible_paths:
                if next_stop != path[-2]:  #Don't go backwards
                    new_path = path + [next_stop]
                    new_paths.append(new_path)
                             
        path_length += 1
        paths = new_paths
    paths = [[-1, new_path[-1]]]
    
# Longest path + 2 per non included node
print(path_length + 2*(Nstops-strays-len(new_path) + 1))
