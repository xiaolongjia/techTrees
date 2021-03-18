# encoding: UTF-8

import pandas as pd
import numpy as np


# 计算ER efficiency ratio，window窗口内每一次价格变化的绝对值除以价格的总变化
# 输入：df，priceField 价格column， window 滑动窗口数
# 输出：df中er字段
def er(df, priceField, window):
	prevClose=df[priceField].shift(1)
	priceChg=np.abs(df[priceField]-prevClose).fillna(0)
	priceChgSum30=priceChg.rolling(window=window).sum()

	prevClose30=df['close'].shift(window)
	priceChg30=df['close']-prevClose30
	df['er']=(priceChg30/priceChgSum30).fillna(0)
	return df

# ser is nv, not daily return
def drawdown(ser):
	# max2here = pd.expanding_max(ser)
	max2here = ser.expanding(min_periods=1).max()
	dd2here_pct = (ser - max2here)/max2here
	return dd2here_pct

def max_dd(ser):
	return drawdown(ser).min()


def annualised_sharpe(returns, N=252):
	"""
	Calculate the annualised Sharpe ratio of a returns stream 
	based on a number of trading periods, N. N defaults to 252,
	which then assumes a stream of daily returns.

	The function assumes that the returns are the excess of 
	those compared to a benchmark.
	"""
	returns_sub_risk_free_ratio = returns-0.035/360
	return np.sqrt(N) * returns_sub_risk_free_ratio.mean() / returns_sub_risk_free_ratio.std()

def annualised_return(df, N=360):
	# 年化以360天为准, df包含date index和nv
	start_d=datetime.datetime.strptime(df.index.min(), '%Y-%m-%d')
	end_d=datetime.datetime.strptime(df.index.max(), '%Y-%m-%d')
	days=(end_d-start_d).days+1
	rtn=df.tail(1)['nv'][0]-1
	ann_rtn = rtn * N / days
	return myutils.get_percent_str(ann_rtn)

# x has high,low,close
def max_price_range(x):
	pr1 = x['high']-x['low']
	pr2 = x['high']-x['last_close']
	pr3 = x['last_close']-x['low']
	return max([pr1,pr2,pr3])

# x has high,low,close
def add_atr(df):
	df['last_close'] = df['close'].shift(1)
	df['tr']=df.apply(max_price_range, axis=1)
	df['atr20']=df['tr'].rolling(window=20).mean().shift(1)
