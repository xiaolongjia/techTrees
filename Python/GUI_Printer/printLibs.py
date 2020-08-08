
import os
import sys
import pymssql
import datetime
import time

class libs (object):

    def setup(self):
        self.logtimeFormat = '%Y-%m-%d %H:%M:%S'
        self.logDir = "./logs/"
        self.templateDir = "./templates/"
        self.cfgFile = "./setup.ini"
        self.cfgData = dict()
        self.cfgData['mesdbserver'] = dict()
        self.cfgData['u9dbserver']  = dict()
        self.cfgData['Equipment']   = list()
        self.readConfig()

    def log(self, message):
        logfileName = self.logDir + str(datetime.datetime.now().strftime('%Y%m%d')) +".txt"
        logfileHandler = open(logfileName,'a')
        timeStamp = datetime.datetime.now().strftime(self.logtimeFormat)
        print(timeStamp+": "+message)
        logfileHandler.write(timeStamp+": "+message+"\n")
        logfileHandler.close()

    def readConfig(self):
        if (not (os.path.exists(self.cfgFile))):
            self.log("Error: config file: " + self.cfgFile + " not existed")
            exit()

        with open(self.cfgFile, 'r+t') as myFR:
            for dataline in myFR.readlines():
                dataline = dataline.replace('\n', '').replace('\r', '').replace(' ', '')
                datas = dataline.split("->")
                if len(datas) > 1:
                    if datas[0] == 'mesdbserver':
                        self.cfgData['mesdbserver'][datas[1]] = datas[2]
                    elif datas[0] == 'u9dbserver':
                        self.cfgData['u9dbserver'][datas[1]] = datas[2]
                    elif datas[0] == 'Equipment':
                        self.cfgData['Equipment'].append(datas[1])
                    else:
                        self.log("Warning: " + self.cfgFile + " has unknown tag " + str(datas[0]))
                        exit()

        if ('server' not in self.cfgData['mesdbserver'].keys() 
            or 'database' not in self.cfgData['mesdbserver'].keys() 
            or 'user'     not in self.cfgData['mesdbserver'].keys() 
            or 'password' not in self.cfgData['mesdbserver'].keys()):
            self.log("Error: config file: " + self.cfgFile + " mesdbserver connection information wrong!")
            exit()

        if ('server' not in self.cfgData['u9dbserver'].keys() 
            or 'database' not in self.cfgData['u9dbserver'].keys() 
            or 'user'     not in self.cfgData['u9dbserver'].keys() 
            or 'password' not in self.cfgData['u9dbserver'].keys()):
            self.log("Error: config file: " + self.cfgFile + " u9dbserver connection information wrong!")
            exit()    

    def getSNs(self, number):
        snList = list()
        server   = self.cfgData['mesdbserver']['server']
        database = self.cfgData['mesdbserver']['database']
        user     = self.cfgData['mesdbserver']['user']
        password = self.cfgData['mesdbserver']['password']
        sql = f"""
            select max(id) from MXIMM.dbo.labelSerialID
        """
        conn = pymssql.connect(server, user, password, database)
        cursor = conn.cursor()
        cursor.execute(sql)
        SNs =  cursor.fetchall()
        if len(SNs) > 0: 
            currSN = SNs[0][0]
            for i in range(number):
                currSN = int(currSN) + 1
                # SN is 9 digits, for example, 000163958
                if len(str(currSN)) < 8 :
                    for j in range(8-len(str(currSN))):
                        currSN = '0' + str(currSN)
                    snList.append('1' +  str(currSN))
            
            updateSQL = f"""
                update MXIMM.dbo.labelSerialID set id = '99999'
            """
            updateSQL = updateSQL.replace('99999', currSN)
            cursor.execute(updateSQL)
            conn.commit()
            return snList
        else :
            return False
