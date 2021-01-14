year = int(input()) + 1
while True:
    if len(set(str(year))) == len(str(year)):
        break
    year += 1


print(year)
