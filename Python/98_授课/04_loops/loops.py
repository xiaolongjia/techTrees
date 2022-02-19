#!C:\Python38\Python

#------------------------------------------
# if ... elif ... else
#------------------------------------------
x = int(input("please enter an integer:\n"))

if x < 0:
    print("<0")
elif x > 0:
    print(">0")
else :
    print("=0")

#------------------------------------------
# for ... in ...
#------------------------------------------
list = [1,2,3,4,5,5,6,7,6]
print(list) 
for i in range(len(list)):
    list[i] *= 2
print(list)
exit()


myDict = {1:"Jan", 2:"Feb", 3:"Mar"}
for myKey in myDict.keys():
    print(myKey, "--> " + myDict[myKey])
exit()

for myKey, myVal in myDict.items():
    print(myKey, "--> ", myVal)

myList = ['Google', 'Baidu', 'Runoob', 'Taobao', 'QQ']

for listdata in myList:
    print(listdata)

#------------------------------------------
# range()
#------------------------------------------
for i in range(1, 5):
    print(i)

for i in range(0, 10, 2):
    print(i)

for i in range(-10, -50, -30):
    print(i)

#------------------------------------------
# while
#------------------------------------------
a = 1
while a < 10:
    print(a)
    a += 2
else:
    print("a > 10:", end='')
    print(a)


#------------------------------------------
# break continue  (else pass)
#------------------------------------------
n = 5
while n > 0:
    n -= 1
    if n == 2:
        break # break the loop
    print(n)
print('end')

n = 5
while n > 0:
    n -= 1
    if n == 2:
        continue
    print(n)
print('end')

#------------------------------------------
#  defining functions
#------------------------------------------
def numbersum (a, b):
    return (a+b)

x = numbersum(3,4)
print(x)

y = numbersum
print(y(4,5))

def numberHist (a, hlist=[]): #default value for mutable object
    hlist.append(a)
    return hlist

numberHist(2)
numberHist(2)
numberHist(5)
print(numberHist(6))

# default arguments

def ask_ok(prompt, retries=4, reminder='Please try again!'):
    while True:
        ok = input(prompt)
        if ok in ('y', 'ye', 'yes'):
            return "true"
        if ok in ('n', 'no', 'nop', 'nope'):
            return False
        retries = retries - 1
        if retries < 0:
            raise ValueError('invalid user response')
        print(reminder)

x = (ask_ok('Do you really want to quit?') == 'true')
ask_ok('OK to overwrite the file?', retries=2)
ask_ok('OK to overwrite the file?', reminder='Come on, only yes or no!', retries=2) # **

# The default values are evaluated at the point of function definition in the defining scope. 

stuName = "Jack"

def stuInfor(name=stuName):
    print(name)

stuInfor()
stuName = "Chris"
stuInfor()

# Important warning: The default value is evaluated only once. 
# This makes a difference when the default is a mutable object such as a list, dictionary, or instances of most classes.

def initMyList(firstData="name", myList=[]):
    myList.append(firstData)
    return myList

print(initMyList())
print(initMyList())
print(initMyList())

# Keyword arguments
def allStudents(total, grade, school='lakeridge', year='2019'):
    print("total is : ", total)
    print("grade is : ", grade)
    print("school is: ", school)
    print("year is :  ", year)

allStudents(grade=30, total=2, year="2021", school="lakeview")
allStudents(30, 2, school="lakeview", year="2020")

# Special arguments
def spcArgu(name, age, grade, *, year, month, day):
    print(name, age, grade, year, month, day)

spcArgu("Jack", 7, "2", year="2019", day="30", month="10")


def spcArgu2(name, age, grade, *time):
    print(name, age, grade, time)

spcArgu2("Chris", "8", "2", 2019, 10, 30, "15:00")

def spcArgu3(name, age, grade, **time):
    print(name, age, grade, time)

spcArgu3("Chris", "8", "2", year=2019, month=10, hour="15:00", day="30")


# Lambda expressions

def my_sum (x, y):
    return(x+y)

print(my_sum(3,4))

my_sum2 = lambda arg1, arg2: arg1+arg2
print(my_sum2(3,4))


# def fib

print("--"*20)
def fib(n):
    a, b = 0, 1
    while a < n:
        print(a)
        a, b = b, a+b

fib(100)

