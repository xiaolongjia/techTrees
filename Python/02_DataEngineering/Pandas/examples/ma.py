#encoding: UTF-8

from datetime import datetime, timedelta
import pandas as pd
import numpy as np

import sys
sys.path.append('..')

import common.dataEngine as de
import performanceMetric as pm
import common.stockUtil as su

# 获得某天均线多头排列的股票 ma5>ma10>ma20>ma55
def getMaDuoTouPaiLie(indexCode, onDate):
	maDf = getMA(indexCode, onDate)
	filter1 = maDf['ma5'] > maDf['ma10']
	filter2 = maDf['ma10'] > maDf['ma20']
	filter3 = maDf['ma20'] > maDf['ma60']
	maDuoTouDf = maDf[filter1 & filter2 & filter3]
	# print(maDuoTouDf)
	return maDuoTouDf['code'].values.tolist()

def getMaDuoTouPaiLieDf(df, onDate):
	maDf = df[df['date'] == onDate]
	filter1 = maDf['ma5'] > maDf['ma10']
	filter2 = maDf['ma10'] > maDf['ma20']
	filter3 = maDf['ma20'] > maDf['ma60']
	maDuoTouDf = maDf[filter1 & filter2 & filter3]
	codeList = maDuoTouDf['code'].values.tolist()
	codeListStr = "'" + "','".join(codeList) + "'"
	return codeListStr

# 获取从startDate开始所有指数成分股的日行情
def getIndexConsDayKDf(indexCode, startDate):
	sql = "select code,date,adjust_close from dayk where date>'{}' and code in ({})"
	codeListStr = su.getIndexConsStr(indexCode)
	df = pd.read_sql_query(sql.format(startDate, codeListStr), de.engine_stockdata)
	return df

def getMA(indexCode, onDate):
	startDate = '2016-01-01'
	# codeListStr = "'sz300059','sh600000','sh601318','sz300433'"
	df = getIndexConsDayKDf(indexCode, startDate)
	# print(df)
	# maxDate = df['date'].max()
	# print(maxDate)
	grouped = df.groupby('code')
	# print(grouped.agg([np.sum, np.mean, np.std]))
	# print(grouped.sum())
	dfm = pd.DataFrame()
	for w in [5,10,20,60]:
		dfg = grouped.rolling(w).mean()
		# print(dfg)
		dfg.rename(columns={'adjust_close': 'ma'+str(w)}, inplace=True)
		# print(dfg[dfg['date']==maxDate])
		df1 = dfg[dfg['date']==onDate]
		if dfm.empty:
			dfm = df1
		else:
			dfm = dfm.merge(df1, on=['code','date'])
	# print(dfm)
	return dfm

# 按code groupby后计算rolling MA 并合并
def getRollingMA(df):
	grouped = df.groupby('code')
	dfm = pd.DataFrame()
	for w in [5,10,20,60]:
		dfg = grouped.rolling(w).mean()
		dfg.rename(columns={'adjust_close': 'ma'+str(w)}, inplace=True)
		if dfm.empty:
			dfm = dfg
		else:
			dfm = dfm.merge(dfg, on=['code','date'])
	return dfm


# 获得股票列表某一周的涨跌幅, fridayDate为周五的日期
def getWeeklyPchg(codeList, fridayDate):
	startDate = datetime.strptime(fridayDate, '%Y-%m-%d') + timedelta(days=-6)
	startDateStr = startDate.strftime('%Y-%m-%d')
	sql = "select code,date,pchg_r+1 as ppchg from dayk where date>='{}' and date<='{}' and code in ({})"
	df = pd.read_sql_query(sql.format(startDateStr, fridayDate, codeList), de.engine_stockdata)
	grouped = df.groupby('code')
	dfg = grouped.agg(np.prod).sort_values(by='ppchg')
	return dfg


def getIndexWeeklyPchg(indexCode, startDate):
	sql = "select code,end_date,pchg from iweekk where code='{}' and end_date>'{}' order by end_date"
	df = pd.read_sql_query(sql.format(indexCode, startDate), de.engine_stockdata)
	return df

# 第一周均线多头排列
# 第二周跌幅最大
# 看第三周表现
# count 选取的股票个数
def backtest1(indexCode, week1Friady, stockCount=20):
	codes = getMaDuoTouPaiLie(indexCode, week1Friady)
	codeList = "'" + "','".join(codes) + "'"
	week1DateObj = datetime.strptime(week1Friady, '%Y-%m-%d')
	week2Friday = (week1DateObj + timedelta(days=7)).strftime('%Y-%m-%d')
	week3Friday = (week1DateObj + timedelta(days=14)).strftime('%Y-%m-%d')
	dfc = getWeeklyPchg(codeList, week2Friday)[:stockCount]
	print(dfc)
	codeList1 = "'" + "','".join(dfc.index.values.tolist()) + "'"
	dfr = getWeeklyPchg(codeList1, week3Friday)
	print(dfr)
	print((dfr['ppchg']-1).sum())

# 从startDate开始连续回测每个星期
def backtest2(indexCode, startDate, stockCount=20):
	consDf = getIndexConsDayKDf(indexCode, startDate)
	rollingMADf = getRollingMA(consDf)
	# print(rollingMADf)
	indexWeekKDf = getIndexWeeklyPchg(indexCode, startDate)
	print('week pchg indexPchg')
	arr = []
	for i,row in indexWeekKDf.iterrows():
		friday = row['end_date']
		codeListStr = getMaDuoTouPaiLieDf(rollingMADf, friday)
		# print(codeListStr)
		week1DateObj = datetime.strptime(friday, '%Y-%m-%d')
		week2Friday = (week1DateObj + timedelta(days=7)).strftime('%Y-%m-%d')
		week3Friday = (week1DateObj + timedelta(days=21)).strftime('%Y-%m-%d')
		dfc = getWeeklyPchg(codeListStr, week2Friday)[:stockCount]
		# print(dfc)
		codeList1 = "'" + "','".join(dfc.index.values.tolist()) + "'"
		dfr = getWeeklyPchg(codeList1, week3Friday)
		# print(dfr)
		print("%s %s %s" % (friday, (dfr['ppchg']-1).sum(), row['pchg']))
		arr.append([friday, (dfr['ppchg']-1).sum(), row['pchg']])

	df = pd.DataFrame(arr, columns=['week', 'pchg', 'indexPchg'])
	df['indexPchg'] = df['indexPchg'].shift(-3)
	hs300pchg = getIndexWeeklyPchg('sh000300', '2016-01-01')
	hs300pchg['pchg'] = hs300pchg['pchg'].shift(-3)
	dfm = df.merge(hs300pchg[['end_date','pchg']], left_on='week', right_on='end_date')
	dfm.rename(columns={'pchg_x':'pchg','pchg_y':'hs300'}, inplace=True)
	dfm['hs300'] = dfm['hs300']*100
	dfm['chaoe'] = dfm['pchg'] - dfm['hs300']
	print(dfm)
	dfm[['week','pchg','hs300','chaoe']].to_excel('/home/binj/tmp/000985.xls')

def test1():
	print su.getIndexConsStr('sh000906')


# 获得指数同时跌破ma20的交易日
def ma20OnSameDay():
	df1 = getFirstMa20('sh000001')
	df2 = getFirstMa20('sz399006')
	dfm = df1.merge(df2, on='date', how='inner')
	print(dfm)

def getFirstMa20(indexCode):
	sql = "select code,date,close,ma_20 from idayk where code='{}'"
	df1 = pd.read_sql_query(sql.format(indexCode), de.engine_stockdata)
	df1['last_close'] = df1['close'].shift(1)
	df1['last_ma_20'] = df1['ma_20'].shift(1)
	filter1 = df1['close'] < df1['ma_20']
	filter2 = df1['last_close'] >= df1['last_ma_20']
	dff = df1[filter1 & filter2].copy()
	return dff

if __name__ == '__main__':
	# getMaDuoTouPaiLie('sh000906', '2017-03-17')
	# getWeeklyPchg("'sz300059','sh600000','sh601318','sz300433'", '2017-03-24')
	# backtest1('sh000300', '2017-03-10', 50)
	# backtest2('sh000985', '2016-01-01', 50)
	ma20OnSameDay()
