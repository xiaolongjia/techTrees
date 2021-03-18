# encoding: UTF-8

from sys import argv

import pandas as pd
pd.set_option('display.width', None)
import numpy as np

import sys
sys.path.append('..')


import common.futuData as fu


def oneDay(ticker, pchgLimit=2):
	df = fu.getDayK(ticker)
	# print(df)
	df['chg'] = df['close'] - df['open']
	df['chgon'] = df['close'] - df['close'].shift(1)
	df['pchg'] = (df['close'] / df['open'] - 1)*100
	print(df['pchg'].describe())
	print(np.histogram(df['pchg'], bins=[-5,-4,-3,-2,-1,0,1,2,3,4,5]))
	df['pchg1'] = df['pchg'].shift(-1)
	df['chg1'] = df['chg'].shift(-1)
	df['chgon1'] = df['chgon'].shift(-1)
	gt2 = df['pchg'] > pchgLimit
	lt_2 = df['pchg'] < -pchgLimit
	volgt5000 = df['volume'] > 5000
	df1 = df[(gt2 | lt_2) & volgt5000].copy()
	df1.loc[lt_2, 'pchg1'] *= -1
	df1.loc[lt_2, 'chg1'] *= -1
	df1.loc[lt_2, 'chgon1'] *= -1
	# df1['nv'] = (1+df['pchg1']/100).cumprod()
	print(df1)
	# print(df1['pchg1'].sum())
	# print(df1['chg1'].sum())
	# print(df1['chgon1'].sum())
	return (df1['pchg1'].sum(), df1['chg1'].sum(), df1['chgon1'].sum())

def oneDayAllTickers(pchgLimit=2):
	pnl = []
	for ticker in fu.getActiveTickers():
		p = [ticker]
		(pchg, chg, chgon) = oneDay(ticker, pchgLimit)
		pnl.append([ticker, pchg, chg, chgon])
		# print(ticker, oneDay(ticker))
	df = pd.DataFrame(pnl, columns=['ticker','pchg','chg','chgon'])
	print(df)
	print(df['pchg'].sum(), df['chg'].sum(), df['chgon'].sum())

if __name__ == '__main__':
	# oneDayAllTickers(float(argv[1]))
	print(oneDay(argv[1], float(argv[2])))