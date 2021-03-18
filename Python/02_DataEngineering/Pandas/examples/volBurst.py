# encoding: UTF-8

import pandas as pd
pd.set_option('display.width', None)

import sys
sys.path.append('..')


import common.futuData as fu
import common.indicators as indicators
import common.dataEngine as de
import performanceMetric as pm

def backtestMinuteBarAll(ticker, startDate, barType):
	resultDf = pd.DataFrame()
	dates = fu.readAllDates(ticker, startDate, barType)
	for date in dates:
		dfData = fu.readBarDataOneDay(ticker, date, barType)
		df = backtest2(dfData)
		if not df.empty:
			resultDf = pd.concat([resultDf, df])
	print(resultDf)
	# print(resultDf.describe())
	pm.describePnL(resultDf['closeChg5'])
	de.generateExcel(resultDf, ticker+startDate+barType+'_volBurst1')
		
def backtestTickAll(ticker, startDate, backtestFunc):
	resultDf = pd.DataFrame()
	dates = fu.readAllTickDates(startDate)
	for date in dates:
		dfData = fu.readTickDataOneDay(ticker, date)
		df = backtestFunc(dfData)
		if not df.empty:
			resultDf = pd.concat([resultDf, df])
	print(resultDf)
	# print(resultDf.describe())
	pm.describePnL(resultDf['PnL'])
	de.generateExcel(resultDf, ticker+startDate+'_tick_volBurst_'+backtestFunc.__name__)


def backtest(df):
	backWindow    = 30
	volPercentile = 0.998
	erPercentile  = 0.998

	df = indicators.er(df, 'close', backWindow)
	volFilter = df['volume'] > df['volume'].quantile(volPercentile)
	erFilter = df['er'] > df['er'].quantile(erPercentile)
	return df[volFilter & erFilter]


def backtest1(df):
	backWindow = 15
	volMultiplier = 5
	volMean = df['volume'].rolling(window=backWindow).mean()
	volFilter = df['volume'].shift() > volMultiplier * volMean.shift(2)
	volFilter1 = df['volume'] < df['volume'].shift()/2
	closeStatus = (df['close'] - df['close'].shift()) * (df['close'].shift() - df['close'].shift(2))
	closeFilter = closeStatus < 0
	df['closeChg5'] = df['close']-df['close'].shift(-5)
	closeUp = df['close'] > df['close'].shift()
	df.loc[closeUp, 'closeChg5'] = df['close'].shift(-5) - df['close']
	return df[volFilter & volFilter1 & closeFilter].fillna(0)

def backtest2(df):
	volMultiplier = 5
	volFilter = df['volume'].shift() > df['volume'].shift(2) * volMultiplier
	volFilter1 = df['volume'] < df['volume'].shift() / volMultiplier
	closeStatus = (df['close'] - df['close'].shift()) * (df['close'].shift() - df['close'].shift(2))
	closeFilter = closeStatus < 0
	df['closeChg5'] = df['close']-df['close'].shift(-5)
	closeUp = df['close'] > df['close'].shift()
	df.loc[closeUp, 'closeChg5'] = df['close'].shift(-5) - df['close']
	return df[volFilter & volFilter1 & closeFilter].fillna(0)

def backtest3(df):
	volLimit = 1000
	backWindow = 15
	interval  = 120
	volFilter = df['volume'].shift() > volLimit
	pchg120x15 = (df['close']-df['close'].shift(120*15)).fillna(0)

def backtest4(df):
	backWindow = 5
	interval = 60
	priceMultiplier = 3
	rollingHigh = df['close'].rolling(window=interval).max()
	rollingLow = df['close'].rolling(window=interval).min()
	rollingRange = (rollingHigh - rollingLow).fillna(0)
	




def test():
	backtestTickAll('a1701','20160801', backtest1)
	# print( backtest('rb1610','2016-01-01','1min') )

if __name__ == '__main__':
	test()