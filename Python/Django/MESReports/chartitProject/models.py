import datetime
from django.db import models
from django.utils import timezone

class SalesReport(models.Model):
    month  = models.IntegerField()
    sales  = models.IntegerField()
    product  = models.CharField(max_length=25)

#insert into chartitProject_salesreport ([month] , sales , product ) values (1, 23123, 'Apple')
#insert into chartitProject_salesreport ([month] , sales , product ) values (2, 83457, 'Apple')
#insert into chartitProject_salesreport ([month] , sales , product ) values (3, 65382, 'Apple')
#insert into chartitProject_salesreport ([month] , sales , product ) values (4, 98756, 'Apple')
#insert into chartitProject_salesreport ([month] , sales , product ) values (5, 87265, 'Apple')
#insert into chartitProject_salesreport ([month] , sales , product ) values (6, 34560, 'Apple')
#insert into chartitProject_salesreport ([month] , sales , product ) values (7, 65423, 'Apple')
#insert into chartitProject_salesreport ([month] , sales , product ) values (8, 23123, 'Apple')
#insert into chartitProject_salesreport ([month] , sales , product ) values (9, 76532, 'Apple')
#insert into chartitProject_salesreport ([month] , sales , product ) values (10, 53221, 'Apple')

