# encoding: UTF-8

import pandas as pd
pd.set_option('display.width', None)

import sys
sys.path.append('..')


import common.futuData as fu
import common.indicators as indicators
import common.dataEngine as de
import performanceMetric as pm


# 每隔checkInterval检查一次，过去lookbackWindow的波动范围，如果超出，开仓，5分钟后平
def test1(ticker, startDate, checkInterval, lookbackWindow, positionTime, volaTickRange):
	sql = "select ticker, date, time, close from MinuteBar where ticker=%s and bartype='1min' and date>=%s"
	df = pd.read_sql_query(sql, de.engine_futu1mk, params=(ticker, startDate))
	timeFilter = (df.time<'21:00') | (df.time>'22:00')
	checkIntervalFilter = df.index % checkInterval == 0
	df['high'] = df['close'].rolling(window=lookbackWindow).max().shift()
	df['low'] = df['close'].rolling(window=lookbackWindow).min().shift()
	df['signal'] = 0
	upFilter = df['close'] > df['high']
	downFilter = df['close'] < df['low']
	minTickChg = fu.getMinTickChg(ticker)
	volaFilter = df.high - df.low < volaTickRange*minTickChg
	df.loc[timeFilter & checkIntervalFilter & volaFilter & upFilter, 'signal'] = -1
	df.loc[timeFilter & checkIntervalFilter & volaFilter & downFilter, 'signal'] = 1
	df['pnl'] = 0
	df.loc[df.signal == -1, 'pnl'] = df['close'].shift(-positionTime) - df['close']
	df.loc[df.signal == 1, 'pnl'] = df['close'] - df['close'].shift(-positionTime)
	return df
	# de.generateExcel(df, 'au1612_volatility_test1')


if __name__ == '__main__':
	test1('au1612', '2016-05-01', 5, 60, 5)