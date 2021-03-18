# encoding: UTF-8

import pandas as pd
pd.set_option('display.width', None)

import sys
sys.path.append('..')


import common.futuData as fu
import common.indicators as indicators
import common.dataEngine as de
import performanceMetric as pm

def getLongestPeriod(ticker, date):
	df=fu.readTickDataOneDay(tick, date)
	periodWindow=[120*5, 120*10, 120*15]

def getLowVolatilePeriod(ticker, startDate):
	df=fu.readBarData(ticker, startDate, '1min')
	df['pchg'] = df['close']/df['open']-1
	

def getMax():
	pass



if __name__ == '__main__':
