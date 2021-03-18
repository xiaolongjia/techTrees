# encoding: UTF-8

from sys import argv
from datetime import datetime
import numpy as np

import pymongo

client = pymongo.MongoClient('mongodb://localhost:27017/')

# get the price ratio between ticker1 and ticker2, 
# for example j1805 and jm1805
def getPriceDiffRatio(ticker1, ticker2, beginDate):
        cursor = client.options.MktFutd.find({'tradeDate':{'$gte':beginDate}, 'ticker':ticker1},
            {'openPrice':1, 'closePrice':1})
        closePrice1 = np.array( [c['closePrice'] for c in cursor] )
        cursor = client.options.MktFutd.find({'tradeDate':{'$gte':beginDate}, 'ticker':ticker2},
            {'openPrice':1, 'closePrice':1})
        closePrice2 = np.array( [c['closePrice'] for c in cursor] )
        # priceRatio = closePrice1 / closePrice2
        priceRatio = closePrice1 - closePrice2*1.5
#         print(closePrice1, closePrice2, priceRatio)
        print(priceRatio)
        return priceRatio
        
        
if __name__ == '__main__':
    getPriceDiffRatio('j1805', 'jm1805', '2017-01-01')
