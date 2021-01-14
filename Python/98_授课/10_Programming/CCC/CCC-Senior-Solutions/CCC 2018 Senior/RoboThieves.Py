import sys
input = sys.stdin.readline

y_len, x_len = [int(e) for e in input().strip("\n").split()]

chart = [list(input().strip("\n")) for a in range(y_len)] #[y][x], [row][collum]

end_points = []
start_point = None
blocked = set()
changes = {}

def camera(chart, y, x, bonus_y, bonus_x): #For Cameras
    spot = [y, x]
    block = set()
    while chart[spot[0]][spot[1]] != "W":
        block.add("%i %i"%(spot[0],spot[1]))
        spot = [spot[i]+[bonus_y,bonus_x][i] for i in range(2)]
        
    return block
                         

for a in range (y_len):
    for b in range(x_len):
        item = chart[a][b]
        if item == "S":
            start_point = [a,b]
        elif item == ".":
            end_points.append([a,b])
        elif item == "C":
            blocked |= camera(chart, a, b, -1, 0)
            blocked |= camera(chart, a, b, 1, 0)
            blocked |= camera(chart, a, b, 0, 1)
            blocked |= camera(chart, a, b, 0, -1)
            
        elif item == "W":
            blocked.add("%i %i"%(a,b))
        else:
            directions = {"U":[-1,0], "D": [1,0], "R":[0,1], "L":[0,-1]}
            new_a,new_b = [directions[item][i] + [a,b][i] for i in range(2)]
            changes["%i %i"%(a,b)] = [new_a, new_b]

reaching_lis = {} #Given a vector, get the shortest way there

level = 0    
checked = set()
checking = [start_point]

if "%i %i"%(start_point[0],start_point[1]) in blocked: #Under camera from the start
    checking = []
    
while checking: #Figure our all the points we can get to, and shortest way to them
    level += 1
    new_connects = []
    for y,x in checking:
        cor_index = "%i %i"%(y,x)
        if not cor_index in checked:
            checked.add(cor_index)
            
            possible = [[-1,0], [1,0], [0,-1], [0,1]]
            for b_y,b_x in possible:
                new_y,new_x = y + b_y, x + b_x

                bad_path = False #Check for infinitely being stuck
                repeated_sf = set()
                
                while "%i %i"%(new_y,new_x) in changes: #On a convey
                    repeated_sf.add("%i %i"%(new_y,new_x))
                    new_y,new_x = changes["%i %i"%(new_y,new_x)]
                    
                    if "%i %i"%(new_y,new_x) in repeated_sf:
                        bad_path = True
                        break
                    
                if not "%i %i"%(new_y,new_x) in blocked and not bad_path:
                    new_connects.append([new_y,new_x])
                    if not "%i %i"%(new_y,new_x) in reaching_lis:
                        reaching_lis["%i %i"%(new_y,new_x)] = level       
    checking = new_connects
    
for new_y,new_x in end_points:
    if "%i %i"%(new_y,new_x) in reaching_lis:
        print(reaching_lis["%i %i"%(new_y,new_x)])
    else:
        print(-1)
        
