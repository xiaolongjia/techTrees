#Setting up functions

def check_valid(rows): #Returns True/False if the new formation works
    for row in range(len(rows)):
        for item in range (len(rows[row])):
            if (item > 0 and rows[row][item] < rows[row][item-1]) or  (row > 0 and rows[row][item] < rows[row-1][item]):
                return False
    return True

def rotate(rows): #Rotates the list given by 90 degrees and returns new list
    rotates_lis = []
    for item in range (len(rows[0])-1, -1, -1):
        next_row = []
        for row in range(len(rows)):
            next_row.append(rows[row][item])
        rotates_lis.append(next_row)
    return rotates_lis

def figure_out(rows): #Return the first correct version of the rows
    if check_valid(rows):
        return rows
    for a in range(3):
        rows = rotate(rows)
        if check_valid(rows):
            return rows
#Gather data
rows = [[int(e) for e in input().split()] for a in range(int(input()))] 

#Get and print answer
correct = figure_out(rows) 
for row in correct:
    print(" ".join([str(e) for e in row]))
