#!C:\Python38\Python

#--------------------------
# Question 1
#--------------------------
str = 'Life is short, you need Python'
print('str[3:3] is ', '|' + str[3:3] + '|')
print('str[:12] is ', str[:12])
print('str[7:] is ', str[7:])
print('str[-8:-4] is ', str[-8:-4])
print('str[-3:-9] is ', str[-3:-9])
print('str[:-5] is ', str[:-5])
print('str[-10:-7] is ', str[-10:-7])
print('str[10:1:-2] is ', str[-10:1:-2])
print('str[::2] is ', str[::2])
print('str[-2:-10] is ', str[-2:-10])
print('str[::-1] is ', str[::-1])
print('str[15:-12:-1] is ', str[15:-12:-1])

#--------------------------
# Question 2
#--------------------------
var = 279
print(bin(var))
print(oct(var))
print(hex(var))
exit()

#--------------------------
# Question 3
#--------------------------
#students = ("Tim", "Jack", "Sosanna")
#students[1] = "New Student"
#print(students)

#--------------------------
# Question 4
#--------------------------
date = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday']
t= date[0]
date[0] = date[-1]
date[-1] = t
print(date)

#--------------------------
# Question 5
#--------------------------
month = {1:"Jan", 2:"Feb", 3:"March"}
month["2"] = "February"
print(month)
print(month.keys())
print(month.values())

