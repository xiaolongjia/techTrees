#!C:\Python\Python

inputs = input()
distances = inputs.split(" ")
distances = list(map(int, distances))

output = list()

for i in range(len(distances)+1):
    tmpData = distances.copy()
    tmpData.insert(i, 0)

    leftData = tmpData[:i+1]
    rightData = tmpData[i+1:]

    for index in range(len(leftData)):
        tmpData[index] = sum(leftData[index:])

    for index in range(len(rightData)):
        tmpData[len(leftData)+index] = sum(rightData[:index+1])

    print(tmpData)
    output.append(tmpData)
print(output)


