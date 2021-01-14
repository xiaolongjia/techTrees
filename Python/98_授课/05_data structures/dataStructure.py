#!C:\Python\Python

#------------------------
# List Functions
#------------------------

mylist = [1,2,3,4,5]
mytuple= ("mon", "tue", "wed", "thurs", "fri")
mydict = {"1":"mon", "2":"wed"}

mylist.append(mytuple)
mylist.extend(mydict)
mylist.insert(1, mydict)
print(mylist)
mylist.remove(mytuple)
print(mylist)

lastmember = mylist.pop()
print(lastmember)
thismember = mylist.pop(3)
print(thismember)
print(mylist)

#mylist.clear()

elementIndex = mylist.index(mydict)
print(elementIndex)

newlist = [1,2,3,4,5,3,2,1,2,3,4,2,3,2]
print(newlist.count(2))
newlist.sort()
print(newlist)
newlist.reverse()
print(newlist)
exit()


# shallow copy

newlist2 = newlist.copy()
print(id(newlist2), "---", id(newlist))
print(newlist is newlist2)

newlist2 = newlist
newlist2.append("new")
print(newlist is newlist2)
print(newlist)

newlist2 = newlist[:]
print(newlist is newlist2)
newlist2.append("new")
print(newlist2)

print(list("hello! good morning!"))

#----------------------------
# List Comprehensions
#----------------------------

normalList = []
for x in range(10):
    normalList.append(x**2)

print(normalList)

listCompre = [x**2 for x in range(10)]
print(listCompre)

#-----------------------------------
# String Functions
#-----------------------------------
str = "jiaxil"
print(str.capitalize())
print(str.center(20, "*"))
print(str.count('i', 0, len(str)))
print(str.find('0', 0, len(str)))  # if not found, return -1
#print(str.index('0', 0, len(str))) # if not found, return an exception
print(len(str)) # return the length of the string

split = "-"
strings = (str, "teacher", "computer")
print(split.join(strings))

print(str.replace("j", "K"))
print(str)

print(str.split("i"))
print(str.split("i", 1))
print(str)

#--------------------------------------------------
# Dictionary Functions
#--------------------------------------------------
newdict = {}
newdict = newdict.fromkeys((1,2,3,4), "placeholder")
newdict = dict([('sape', 4139), ('guido', 4127), ('jack', 4098)])
newdict = dict(sape=4139, guido=4127, jack=4098)

data = newdict.get("5")
print(data)

if "1" in newdict:
    print("it has key 1")
else:
    print("it does not have key 1")

print(newdict.items())
print(newdict.keys())
print(newdict.values())
print(list(newdict.items())[0][1])
print(list(newdict.keys())[0])

print(newdict)
newdict.pop("sape")
print(newdict)
newdict.popitem()
print(newdict)

#-------------------------------
# Using Lists as Stacks
#-------------------------------

# empty()
myStack = []
if not myStack:
    print("stack is null")

# size()
myStack = ["first", "second", "third"]
print(len(myStack))

#top()
print(myStack[-1])

#push(g)
myStack.append("Fourth")
myStack.append("Fivth")
print(myStack)

#pop()
myStack.pop()
myStack.pop()
print(myStack)

#-------------------------------
# Using Lists as Queues
#-------------------------------
myQueueSize = 10
myQueue = myStack.copy()
print(myQueue)

#Enqueue
if (len(myQueue) < myQueueSize):
    myQueue.append("new Queue member")
else:
    print("queue is full")

#Dequeue
theFirstone = myQueue.pop(0)

#Front:
print(myQueue[0])

#Rear:
print(myQueue[-1])

#-------------------------------
# Using Lists as Deques
#-------------------------------
myDeque = myQueue.copy()
print(myDeque)

#insertFront
myDeque.insert(0, "the first one")
print(myDeque)

#insertLast
myDeque.append("the last one")
print(myDeque)

#deleteFront
myDeque.pop(0)
print(myDeque)

#deleteLast
myDeque.pop()
print(myDeque)

#-------------------------------
# collections.deque
#-------------------------------

print("deque" + "*"*20)
import collections

myDeque = collections.deque(myDeque)
print(myDeque)

#insertFront
myDeque.appendleft("the first one")
print(myDeque)

#insertLast
myDeque.append("the last one")
print(myDeque)

#deleteFront
myDeque.popleft()
print(myDeque)

#deleteLast
myDeque.pop()
print(myDeque)

