#!C:\Python\Python

myFile = '.\myFile.txt'
#myFile = r'..\test.py'
with open(myFile, 'r+t') as myFO:
    for data in myFO:
        print(data)

    '''
    for data in myFO.readlines():
        print(data)

    print(myFO.fileno())
    print(myFO.read())

    print(myFO.read(50))
    print(myFO.readline())
    print(myFO.readlines())

    myFO.seek(0)
    print(myFO.tell())
    print(myFO.read(10))
    print(myFO.tell())

    myFO.seek(100)
    myFO.write('\n#this is a comment\n')
    print("#Comments too!", file=myFO)
    #myFO.writelines("#comments too\n")
    #myFO.truncate()
    '''
