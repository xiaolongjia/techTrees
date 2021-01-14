#!C:\Python\Python

grid = [1,2,3,4]

actions = input()

myList = list(actions)
hNumber = myList.count('H')
vNumber = myList.count('V')

if hNumber%2 == 1:
    grid = [grid[2], grid[3], grid[0], grid[1]]

if vNumber%2 == 1:
    grid = [grid[1], grid[0], grid[3], grid[2]]

print(grid[0], " ", grid[1])
print(grid[2], " ", grid[3])

