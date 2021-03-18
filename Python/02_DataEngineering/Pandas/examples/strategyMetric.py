# encoding: UTF-8

from datetime import datetime
import pandas as pd
import sys
sys.path.append('..')

import common.dataEngine as de
import common.util as util


def calculateProfit(strategyName='R-breaker', tradeDate='', dbTablePostfix=''):
    today=datetime.now()
    if tradeDate=='':
        tradeDate=today.strftime('%Y-%m-%d')
    startDate=util.prevTradeDate(tradeDate)
    endDate=tradeDate
    print(startDate)
    sql_contract="select ticker,contMultNum,closePrice from MktFutd where tradeDate='{}'".format(startDate)
    startDate+=' 21:00:00'
    endDate+=' 21:00:00'
    print(startDate, endDate)
    tradeLogTable='TradeLog'+dbTablePostfix
    sql="select * from {} where type='trade' and strategyName=%s and ts>%s and ts<%s".format(tradeLogTable)
    params=[strategyName, startDate, endDate]
    df=pd.read_sql_query(sql, de.engine_turtle, params=tuple(params))
    df.drop_duplicates(
        subset=['strategyName','vtSymbol','type','vtOrderID','vtTradeID','direction','offset','price','volume','tradeTime'],
        inplace=True)
    df.drop(['totalVolume','tradedVolume','orderTime','cancelTime','status'],axis=1,inplace=True)
    # print(df)
    df_contract=pd.read_sql_query(sql_contract, de.engine_turtle)
    # print(df_contract)
    dfm=df.merge(df_contract, left_on='vtSymbol',right_on='ticker')

    longTrade=dfm['direction']==u'多'
    dfm.loc[longTrade, 'price']*=-1
    dfm['cost']=dfm['price']*dfm['contMultNum']*dfm['volume']
    # 已平仓盈亏
    # closedTrade=dfm['offset'].str.startswith(u'平')
    # print(dfm)
    # print(dfm.groupby(['ticker']).sum())
    # print(dfm['cost'].sum())
    de.writeExcel(dfm, dbTablePostfix+strategyName+tradeDate)
