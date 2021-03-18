# encoding: UTF-8

import pandas as pd
pd.set_option('display.width', None)

import sys
sys.path.append('..')


import common.futuData as fu
import common.dataEngine as de
from datetime import date
from dateutil.relativedelta import relativedelta


# 计算股指期货和指数间贴水
def calDiscount(tickerObject, indexCode):
	sql1 = "select tradeDate as date,closePrice as close,turnoverVol as volume from MktFutd where ticker='{}'"
	sql2 = "select date,close,volume from idayk where code='{}'".format(indexCode)
	dfIndex = pd.read_sql_query(sql2, de.engine_stockdata)
	today = date.today()
	mdf = pd.DataFrame()
	for i in range(12):
		month = (today + relativedelta(months=-i)).strftime('%y%m')
		qhDf = pd.read_sql_query(sql1.format(tickerObject+month), de.engine_turtle)
		mdf = dfIndex.merge(qhDf, how='left', on='date')


# 获得连续的主力合约，根据成交量切换
# monthDelta: 往回推多少个月
def getContinuousContract(tickerObject, monthDelta=12):
	sql1 = "select ticker,tradeDate as date,closePrice as close,turnoverVol as volume from MktFutd where ticker='{}'"
	today = date.today()
	mdf = pd.DataFrame()
	for i in range(monthDelta):
		month = (today + relativedelta(months=-i)).strftime('%y%m')
		qhDf = pd.read_sql_query(sql1.format(tickerObject+month), de.engine_turtle)
		if i == 0:
			mdf = qhDf
		else:
			mdf = mdf.merge(qhDf, how='outer', on='date')

	print(mdf)

if __name__ == '__main__':
	getContinuousContract('IH', monthDelta=2)




