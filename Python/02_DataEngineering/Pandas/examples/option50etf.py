#encoding: UTF-8

import pandas as pd
import numpy as np
import math
import sys
sys.path.append('..')
import common.dataEngine as de

def getHistoryVolatility(code):
	sql = "select * from etfdayk where code='%s' order by date" % code
	df = pd.read_sql_query(sql, de.engine_ylh_stockdata)
	# df['hv'] = 
	df['pchg'] = df.close.pct_change()
	df['log_ret'] = np.log(df.close) - np.log(df.close.shift(1))
	df['vol'] = pd.rolling_std(df.log_ret, window=20) * math.sqrt(252) 
	print(df)
	df.to_excel('/home/binj/tmp/sh510050vol.xls')

if __name__ == '__main__':
	getHistoryVolatility('sh510050')
