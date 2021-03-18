# encoding: UTF-8

import os
import pandas as pd

import indicators

DATA_PATH = 'D:/dropbox/Dropbox/turtlebt/'
DATA_PATH_NO4 = u'D:/dropbox/Dropbox/伏流4期/'

def readDfFromFile(filepath):
    df=pd.read_table(filepath, encoding='gbk', skiprows=1, skipfooter=1, usecols=[0,1,2,3,4,5], engine='python')
    df.columns=['date','open','high','low','close','volume']
    df['date']=df['date'].str.replace('/','-')
    baseName=os.path.basename(filepath)
    df['ticker']=baseName[:baseName.rfind('.')]
    df['pchg']=df['close'].pct_change().fillna(0)
    for i in ['20high','20low','10high','10low']:
        window = int(i[0:2])
        highLow = i[2:]
        if highLow=='high':
            df[i] = df['close'].rolling(window=window).max().shift(1)
        else:
            df[i] = df['close'].rolling(window=window).min().shift(1)
    df['pos'] = 0
    # df[df['close']>df['20high']]['pos'] = 1
    # df[df['close']<df['20low']]['pos'] = -1
    pos = 0
    for i,row in df.iterrows():
        if pos == 0:
            if row['close'] > row['20high']:
                pos = 1
            elif row['close'] < row['20low']:
                pos = -1
            else:
                pass
        if (pos == 1 and row['close'] < row['10low']) or \
            (pos == -1 and row['close'] > row['10high']):
            pos = 0
        df.loc[i,'pos'] = pos
    df['pos'] = df['pos'].shift(1) # 实际进场出场都要晚一天，如果当天进场，当天的利润会计算在内，相当于未来函数，盈利肯定偏高
    df['pospchg'] = df['pos'] * df['pchg'] * 2
    df['pnl'] = (1+df['pospchg']).cumprod()
    return df


def bt(dataDir, fromDate='2013-01-01'):
    # skipContractObjects = ['AP','BU','CS','HC','IC','IH','I','JD','JM','MA','NI','PP','SF','SM','SN','TF','T','ZC']
    skipContractObjects = []
    count = 0
    dfm = pd.DataFrame()
    for subdir, dirs, files in os.walk(dataDir):
        for file in files:
            if file.endswith('L9.txt'):
                contractObject = file[:file.rindex('L9')]
                if contractObject in skipContractObjects:
                    continue
                df = getHistPriceDf(dataDir+file)
                count+=1
                print(file, df.loc[0,'date'], df.loc[df.shape[0]-1,'pnl']-1)
                
                dfg2014 = df[df['date'].str.strip()>fromDate][['date','pospchg']]
                if count == 1:
                    dfm = dfg2014.copy()
                    dfm['sumpchg'] = dfm['pospchg']
                else:
                    dfm = dfm.merge(dfg2014, on='date', how='left').fillna(0)
                    dfm['sumpchg'] += dfm['pospchg']
                dfm.rename(columns={'pospchg': contractObject}, inplace=True)
                # if count==4:
                #     break
                # df.to_excel(dataDir+'excel/'+file+'.xls')
    dfm['avgpchg'] = dfm['sumpchg']/count
    dfm['avgpnl'] = (1+dfm['avgpchg']).cumprod()
    dfm.to_excel(dataDir+'excel/merged_double_position.xls')

def getHistPriceDf(filePath):
    df = readDfFromFile(filePath)
    return df

def getATR(contract):
    df = getHistPriceDf(DATA_PATH+contract+'.txt')
    indicators.add_atr(df)
    df.to_excel(DATA_PATH+contract+'_ATR.xls')


if __name__ == '__main__':
    # bt(DATA_PATH)
    getATR('j1901')
