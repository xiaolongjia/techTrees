#encoding: UTF-8

import pandas as pd

import sys
sys.path.append('..')

import common.dataEngine as de
import performanceMetric as pm

def test1():
	sz000001rtn = de.getAllAsListOfValue(
		"select pchg_r from dayk where code='sz000001' and date>'2016-01-01'",
		de.engine_stockdata
		)
	sh000300rtn = de.getAllAsListOfValue(
		"select pchg from idayk where code='sh000300' and date>'2016-01-01'",
		de.engine_stockdata
		)
	# print(sz000001rtn)
	print (pm.beta(map(float,sz000001rtn), map(float,sh000300rtn)))

def getReturnPair(stockCode, indexCode, startDate):
	stockDf = pd.read_sql_query(
		"select date,pchg_r as stockPchg from dayk where code=%s and date>%s order by date desc",
		de.engine_stockdata,
		params=(stockCode,startDate))
	indexDf = pd.read_sql_query(
		"select date,pchg as indexPchg from idayk where code=%s and date>%s order by date desc",
		de.engine_stockdata,
		params=(indexCode,startDate))
	mdf = stockDf.merge(indexDf, on='date', how='right').fillna(0)
	# print(mdf)
	# mdf.to_csv('/home/share/tmp/'+stockCode+indexCode+'.csv')
	return mdf

def getBeta(stockCode, indexCode, startDate):
	df = getReturnPair(stockCode, indexCode, startDate)
	return pm.beta(df['stockPchg'], df['indexPchg'])

def test2():
	df = getReturnPair('sz000001', 'sh000300', '2016-01-01')
	print(pm.beta(df['stockPchg'], df['indexPchg']))
	df = getReturnPair('sz300059', 'sz399006', '2016-01-01')
	print(pm.beta(df['stockPchg'], df['indexPchg']))


if __name__ == '__main__':
	test2()
	# getReturnPair('sz300059', 'sh000300', '2016-01-01')