#encoding: UTF-8

from QuantLib import *

today = Date(7, March, 2014)
Settings.instance().evaluationDate = today

option = EuropeanOption(PlainVanillaPayoff(Option.Call, 100.0),
						EuropeanExercise(Date(7, June, 2014)))

u = SimpleQuote(100.0)
r = SimpleQuote(0.01)
sigma = SimpleQuote(0.20)

riskFreeCurve = FlatForward(0, TARGET(), QuoteHandle(r), Actual360())
volatility = BlackConstantVol(0, TARGET(), QuoteHandle(sigma), Actual360())

process = BlackScholesProcess(QuoteHandle(u),
							  YieldTermStructureHandle(riskFreeCurve),
							  BlackVolTermStructureHandle(volatility))

engine = AnalyticEuropeanEngine(process)

option.setPricingEngine(engine)

print("%s delta %s gamma %s vega %s" % (option.NPV(), option.delta(), option.gamma(), option.vega()))
