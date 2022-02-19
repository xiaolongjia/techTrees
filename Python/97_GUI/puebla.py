#!C:\Python38\Python

import tkinter as tk
from tkinter import messagebox

import sys
import pymssql
import re
import datetime
import time
import winsound

#----------------------------------
# Threshold bar: 30 (left, right matching)
# Bumper: 30= 5*6 (front, rear matching)
#----------------------------------

showNumbers  = 5 # the parts layout will be n*6 (row*column)
showSequence = 0 # 0: descending, 1: ascending
counter = 0

#--------------
# MES DB
#--------------
mes_dbserver    = "192.168.15.254"
mes_user        = "sa"
mes_password    = "Yizit@123"
mes_database    = "MXMes"

#-------------
# CallOff Data
#-------------
mesConn   = pymssql.connect(mes_dbserver, mes_user, mes_password, mes_database)
mesCursor = mesConn.cursor()

callOffSql = f"""
select 
    RUNNING_NUMBER 
from MXMes.dbo.M_PJ_BMW_JIS_CALLOFF_T 
where 1=1
and PARTS_FAMILY='STFKBR3'
order by RUNNING_NUMBER
"""

mesCursor.execute(callOffSql)
sqlData =  mesCursor.fetchall() 
callOffList = []
for data in sqlData:
    callOffList.append(data[0])

def warningBeep():
    duration = 1000  # millisecond
    freq = 440  # Hz
    winsound.Beep(freq, duration)

def getEntryData(event):
    entryData = entry.get()
    entry.delete(0, "end")
    checkEntryData(entryData)

def checkEntryData(data):
    global counter
    currLabelIndex = getCurrLabelIndex()
    currCallOffData = labelList[currLabelIndex].cget("text")
    print("-------- Start: " + str(currLabelIndex) + "Counter: " + str(counter) + " ----------")
    print("Entry data:  ", data)
    print("CallOffData: ", currCallOffData)
    if data == currCallOffData:
        rendCurrLabel(True)
        counter += 1
        if counter == len(labelList):
            #--------------
            # Finshed the verification to one batch of CallOff Files
            #--------------
            print("Done.")
    else:
        rendCurrLabel(False)

def getCurrLabelIndex():
    # get the current lable according to initPosition and counter
    if showSequence == 0:
        if counter < showNumbers:
            labelIndex = showNumbers - 1 - counter
            return labelIndex
        else:
            remainder = counter % showNumbers
            mod = int(counter/showNumbers) 
            if len(labelList) >=  (mod+1)*showNumbers:
                labelIndex = (mod+1)*showNumbers - 1 - remainder
            else:
                labelIndex = len(labelList) - 1 - remainder
            return labelIndex
    else:
        return counter

def rendCurrLabel(flag):
    currLabelIndex = getCurrLabelIndex()
    if flag == True:
        labelList[currLabelIndex].config(bg="green")
    else:
        labelList[currLabelIndex].config(bg="red")
        warningBeep()



#-------------------------
# Extracting data from CallOFf files
#-------------------------
callOffData = "022469     01 2122760036 7047 17-03-2020 10-12 2GJ 827 933 A  C9A   1"
callOffDataPattern = re.compile(r'(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)-(\d+)-(\d+)\s+(\d+)-(\d+)\s+(\w+\s+\w+\s+\w+\s+\w+\s+\w+)\s+(\d+)')
m = callOffDataPattern.match(callOffData)
callOffSupplierNumber = m.group(1)
callOffMountLine = m.group(2)
callOffPkn = m.group(3)
callOffSeqNumber = m.group(4)
callOffTime = m.group(7) + "-" + m.group(6) + "-" + m.group(5) + " " + m.group(8) + ":" + m.group(9) + ":00"
callOffPnVersion = m.group(10)
callOffQty = m.group(11)

callOffDatalist = list()
for i in range(20):
    newSeq = int(callOffSeqNumber) + i
    newData =  "*" + str(newSeq) + callOffPnVersion + "*"
    print(newData)
    callOffDatalist.append(newData)

#-------------------------
# Layout the menu
#-------------------------
top = tk.Tk()
w, h = top.maxsize()

top.geometry("{}x{}".format(w, h))
top.title('LES system')
#top.geometry("400x300")

label = tk.Label(master=top, text="Please scan the SIN:", font=('Arial', 18, 'bold'))
label.place(relx=0.2, rely=0.02)
# https://blog.csdn.net/aa1049372051/article/details/51887144

entry = tk.Entry(master=top, font=('Arial', 18, 'bold'))
entry.place(relx=0.4, rely=0.02, width=300)
entry.focus_set()
entry.bind('<Return>', getEntryData)
# https://blog.csdn.net/qq_41556318/article/details/85108328?depth_1-utm_source=distribute.pc_relevant.none-task&utm_source=distribute.pc_relevant.none-task
# https://www.python-course.eu/tkinter_events_binds.php  # Event binding.

#-------------------------
# Layout the callOffData
#-------------------------
layoutColumns = int(len(callOffDatalist)/showNumbers)
if len(callOffDatalist)%showNumbers > 0:
    layoutColumns += 1

labelList = list()
for index in range(len(callOffDatalist)):
    layoutXIndex = int(index/showNumbers)
    layoutX = (1/layoutColumns)*layoutXIndex
    layoutYIndex = int(index%showNumbers)
    if showSequence == 0:
        layoutYIndex = showNumbers - 1 - layoutYIndex
    layoutY = ((1-0.1)/showNumbers)*layoutYIndex+0.1
    #print("layoutX: ", layoutX)
    #print("layoutY: ", layoutY)
    currLabel = tk.Label(master=top, text= callOffDatalist[index], font=('Arial', 18, 'bold'), borderwidth=2, relief="groove")
    # relief could be "flat", "raised", "sunken", "ridge", "solid", and "groove".
    currLabel.place(relx=layoutX, rely=layoutY, x=10, y=10)
    labelList.append(currLabel)




#button = tkinter.Button(master=tk, text='Finish', command=hello, state=tkinter.DISABLED)
#button.config(state=tkinter.NORMAL)
#button.pack()
#time.sleep(2)

top.mainloop()
