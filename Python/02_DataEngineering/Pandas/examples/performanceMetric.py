# encoding: UTF-8

import numpy as np
import pandas as pd

def describePnL(ser):
	print('sum %s' % ser.sum())
	print(ser.describe())
	print(ser.value_counts().sort_index())
	# print('win count %s lose count %s even count %s' % (ser.gt(0), ser.lt(0), ser.eq(0)) )


def max_dd(ser):
    max2here = pd.expanding_max(ser)
    #max2here.plot()
    dd2here_pct = (ser - max2here)/max2here
    #dd2here.plot()
    return dd2here_pct.min()


def sharpe(returns, N=252):
	"""
    Calculate the annualised Sharpe ratio of a returns stream 
    based on a number of trading periods, N. N defaults to 252,
    which then assumes a stream of daily returns.

    The function assumes that the returns are the excess of 
    those compared to a benchmark.
    """
	return np.sqrt(N) * returns.mean() / returns.std()

# equityRtn是股票或期货的每日波动，indexRtn是指数的每日波动
def beta(equityRtn, indexRtn):
    v = np.cov(np.vstack([equityRtn, indexRtn]))
    return v[0][1] / v[1][1]



def alpha():
    return

