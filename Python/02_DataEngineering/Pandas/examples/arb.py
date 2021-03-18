# encoding: UTF-8

import pandas as pd
pd.set_option('display.width', None) # auto detect screen width to avoid wrap lines

import common.dataEngine as de


def getMaxDate(ticker):
    sql="select max(tradeDate) from MktFutd where ticker='{}'".format(ticker)
    return de.getOneValue(sql, de.engine_turtle)


def populateDayK(ticker_list):
    for ticker in ticker_list:
        cdf=datayesClient.downloadDataDF('api/market/getMktFutd.json', {'ticker':ticker})
        maxDate=getMaxDate(ticker)
        if not maxDate:
            (rowCount,colCount)=cdf.shape
            logging.warn('insert %s rows for %s' % (rowCount, ticker))
            cdf.to_sql('MktFutd', engine, if_exists='append', index=False)
        else:
            # 只更新新的数据
            updateCdf=cdf[cdf['tradeDate']>maxDate]
            (rowCount,colCount)=updateCdf.shape
            logging.warn('append %s rows for %s' % (rowCount, ticker))
            updateCdf.to_sql('MktFutd', engine, if_exists='append', index=False)


def get_ticker_data(ticker, date):
    sql="select concat(ActionDay,' ',UpdateTime,'.',UpdateMillisec) as DateTime,InstrumentID,LastPrice,BidPrice1,AskPrice1 \
        from tick{} where InstrumentID='{}'".format(date,ticker)
    df=pd.read_sql_query(sql, engine)
    return df

def get_merged_data(date):
    ihdf=get_ticker_data('IH1607', date)
    ihdf.rename(columns={'LastPrice':'priceIH'}, inplace=True)
    ifdf=get_ticker_data('IF1607', date)
    ifdf.rename(columns={'LastPrice':'priceIF'}, inplace=True)
    icdf=get_ticker_data('IC1607', date)
    icdf.rename(columns={'LastPrice':'priceIC'}, inplace=True)
    mdf=ihdf.merge(ifdf, on='DateTime', how='inner')
    mdf=mdf.merge(icdf, on='DateTime', how='inner')
    # print(mdf)
    return mdf



def arb(date):
    df=get_merged_data(date)
    df['priceDiff']=3*df['priceIH']+2*df['priceIC']-2*3*df['priceIF']
    # return df
    df.to_sql('arb'+date, engine, if_exists='replace', index=False)

def get_dayk(ticker):
    sql="select tradeDate,ticker,closePrice from MktFutd where ticker=%s"
    df=pd.read_sql_query(sql, engine, params=(ticker,))
    return df

def arb_dayk():
    ihdf=get_dayk('IH1607')
    ihdf.rename(columns={'closePrice':'priceIH'}, inplace=True)
    ifdf=get_dayk('IF1607')
    ifdf.rename(columns={'closePrice':'priceIF'}, inplace=True)
    icdf=get_dayk('IC1607')
    icdf.rename(columns={'closePrice':'priceIC'}, inplace=True)
    df=ihdf.merge(ifdf, on='tradeDate', how='inner')
    df=df.merge(icdf, on='tradeDate', how='inner')
    df['priceDiff']=3*df['priceIH']+2*df['priceIC']-2*3*df['priceIF']
    df.to_sql('arb1607', engine, if_exists='replace', index=False)

if __name__ == '__main__':
    import sys
    arb(sys.argv[1])
    # populateDayK(['IF1607','IH1607','IC1607'])
    # arb_dayk()

