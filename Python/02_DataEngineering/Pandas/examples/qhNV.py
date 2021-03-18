# encoding: UTF-8

import numpy as np
import pandas as pd
pd.set_option('display.width', None)

import sys
sys.path.append('..')

import common.futuData as fu
import common.util as util
import common.dataEngine as de

# 计算期货账户净值，通过保证金中心记录
# initPosition是dict，key为ticker，value为数量，多单为正，空单为负，比如 {'au1612': 2}, {'ag1612': -1} 
# allTrans是dict，key为date，value为当天交易记录，结构如下
# transArray为array, value也是array,比如 ['au1612','long',1,288], 第二个为op，分long和short
# 第三个为volume，第四个为价格
# 四种操作 buy, sell, short, cover
def getNVHist(startDate, endDate, initPosition, initCash, allTrans):
	nvArray = [[startDate, initCash, 1, 0]]
	position = initPosition
	cash = initCash
	nv = 1
	for date in util.getTradingDates(startDate):
		if date>endDate:
			break
		dayChg = getDayChg(date, position, allTrans.get(date, []))
		pchg = (cash+dayChg) / float(cash) - 1
		cash += dayChg
		nv = nv * (pchg + 1)
		nvArray.append([date, cash, nv, pchg])
	df = pd.DataFrame(nvArray, columns=['date','cash','nv','pchg'])
	return df

def printDict(d):
	for k in d.keys():
		print('%s %s' % (k, d[k]))

# 统一使用每日结算价
# position: 输入初始仓位，会被修改成经过transactions修改的最终仓位
def getDayChg(date, position, transArray):
	# printDict(position)
	avgPrice = {} # 成本价，默认为昨结算，如果当日有操作，会反映进去
	dayChg = 0
	for t in transArray:
		ticker = t[0]
		op = t[1]
		volume = t[2]
		price = t[3]
		commision = t[4]
		dayChg -= commision
		pos = position.get(ticker, 0)
		settlePrice = fu.getDaySettlePrice(ticker, date)
		preSettlePrice = fu.getPreSettlePrice(ticker, date)
		contMult = fu.getContMult(ticker)
		old_avg_price = avgPrice.get(ticker, preSettlePrice)
		# print(ticker, op, volume, price, commision, dayChg, pos, settlePrice, preSettlePrice, contMult, old_avg_price)
		if op == 'long':
			position[ticker] = pos+volume
			if pos+volume == 0: # 全部平仓
				dayChg -= (pos*old_avg_price + volume*price) * contMult
			else:
				avgPrice[ticker] = (pos*old_avg_price + volume*price) / float(pos+volume)
		elif op == 'short':
			position[ticker] = pos-volume
			if pos-volume == 0: # 全部平仓
				dayChg -= (pos*old_avg_price - volume*price) * contMult
			else:
				avgPrice[ticker] = (pos*old_avg_price - volume*price) / float(pos-volume)
		# print(ticker, position[ticker], dayChg, avgPrice[ticker])
	# return
	for ticker in position.keys():
		pos = position[ticker] # pos could be + or -
		if pos == 0:
			continue
		settlePrice = fu.getDaySettlePrice(ticker, date)
		preSettlePrice = fu.getPreSettlePrice(ticker, date)
		contMult = fu.getContMult(ticker)
		price = avgPrice.get(ticker, preSettlePrice)
		dayChg += (settlePrice-price) * pos * contMult
	return dayChg


def getInitPosition():
	rtn = {}
	df = de.readExcel('initPosition')
	for i,row in df.iterrows():
		rtn[row['ticker']] = row['pos']
	return rtn

def generateAllTrans():
	dfAll = pd.DataFrame()
	for i in range(1,9):
		month = '2016-0{}'.format(i)
		df=pd.read_excel('C:/Users/jiang/OneDrive/Documents/qh/dongxing qh.xlsx', month)
		df.columns=['date','ticker','op',3,'price','volume',6,7,'commision','pnl',10,11,12]
		startIndex = df[df['date']==u'交易日期'].index[0] + 1
		endIndex = df[df['date']==u'\xa0 \u5408\u8ba1'].index[2] - 1
		dfAll = pd.concat([dfAll, df.loc[startIndex:endIndex]])
	dfAll.date = dfAll.date.apply(lambda x: x.strftime('%Y-%m-%d'))
	df.op = df.op.str.strip()
	dfAll.price = dfAll.price.str.rstrip()
	dfAll.commision = dfAll.commision.str.rstrip()
	return dfAll

def test():
	df = generateAllTrans()
	de.writeExcel(df, 'allTrans')

def getAllTrans():
	rtn = {}
	df = de.readExcel('allTrans')
	df.reset_index(inplace=True)
	for i,row in df.iterrows():
		if row.op == u'\xa0 \xa0 \u5356':
			op = 'short'
		elif row.op == u'\xa0 \u4e70':
			op = 'long'
		else:
			print('error op: %s' % row.op)
		a = rtn.get(row.date, None)
		if not a:
			rtn[row.date] = []
		rtn[row.date].append([row.ticker, op, row.volume, row.price, row.commision])
	return rtn

def calculate():
	df = getNVHist('2016-01-01','2016-08-31', getInitPosition(), 1000000, getAllTrans())
	de.writeExcel(df, 'qhnv')

def getqhNV():
	df = de.readExcel('qhnv')
	return df

def getAllTransDf():
	df = de.readExcel('allTrans').reset_index(drop=True)

	# print(df)
	# print('[%s]' % df.loc[47,'pnl'])
	# print(df[df['pnl']==u'--  '])
	df.loc[df['pnl']==u'--  ','pnl'] = np.nan
	df['pnl'] = df['pnl'].astype(float)
	# print(df['pnl'])
	# print(df['price'])
	serp = df[df['pnl']>0]['pnl']
	serl = df[df['pnl']<0]['pnl']
	print(serp.count(),serp.sum(),serp.max(),serp.min(),serp.mean())
	print(serl.count(),serl.sum(),serl.max(),serl.min(),serl.mean())
	
if __name__ == '__main__':
	getAllTransDf()
