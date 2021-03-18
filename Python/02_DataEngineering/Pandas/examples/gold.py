# encoding: UTF-8

import pandas as pd
pd.set_option('display.width', None)

import sys
sys.path.append('..')


import common.futuData as fu
import common.indicators as indicators
import common.dataEngine as de
import performanceMetric as pm


# 
# 每个交易日分三个交易时段，如果交易时段中涨跌幅超过pchgLimit，则收盘顺势做多或做空，下一个时段开盘平仓：
# 夜盘收盘 02：30 上午开盘09：01
# 上午收盘 11：30 下午开盘13：31
# 下午收盘 15：00 夜盘开盘21：01
def buyCloseSellOpen(ticker, startDate, pchgLimit=0.005):
	sql = "select ticker, date, time, close from MinuteBar where ticker=%s and bartype='1min' and date>=%s \
		and time in ('02:30', '09:01', '11:30', '13:31', '15:00', '21:01')"
	df = pd.read_sql_query(sql, de.engine_futu1mk, params=(ticker, startDate))
	df['pchg'] = (df['close']/df['close'].shift()-1).fillna(0)
	df['pdiff'] = (df['close']-df['close'].shift()).fillna(0)
	closeMinute = df['time'].isin(['02:30', '11:30', '15:00'])
	openMinute = df['time'].isin(['21:01', '09:01', '13:01'])
	df['pchg1'] = df['pchg'] 
	df.loc[openMinute, 'pchg1'] = 0
	df['pchg1'] = df['pchg1'].shift().fillna(0)
	
	upPeriods = df['pchg1'] > pchgLimit
	downPeriods = df['pchg1'] < -pchgLimit
	updf = df[upPeriods]
	downdf = df[downPeriods]

	return (df, updf, downdf)
	de.generateExcel(df, 'au1612_buyclosesellopen')

if __name__ == '__main__':
	buyCloseSellOpen('au1612', '2016-04-01')