numbers = []
cur_sum = 0
for i in range(int(input())):
    next_num = int(input())
    
    if next_num == 0:
        cur_sum -= numbers[-1]
        del numbers[-1]
    else:
        numbers.append(next_num)
        cur_sum += next_num

print(cur_sum)
