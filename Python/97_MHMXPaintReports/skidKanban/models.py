import datetime
from django.db import models
from django.utils import timezone

class PaintlinePlan((models.Model)):
    loop        = models.CharField(max_length=10, null=True)
    sequence    = models.CharField(max_length=10, null=True)
    startSkid   = models.CharField(max_length=10, null=True)
    endSkid     = models.CharField(max_length=10, null=True)
    skidQty     = models.CharField(max_length=10, null=True)
    quantity    = models.CharField(max_length=10, null=True)
    actualQty   = models.CharField(max_length=10, null=True)
    bypassQty   = models.CharField(max_length=10, null=True)
    mo          = models.CharField(max_length=30, null=True)
    itemNo      = models.CharField(max_length=100, null=True)
    description = models.CharField(max_length=255, null=True)
    color       = models.CharField(max_length=100, null=True)
    prodType    = models.CharField(max_length=20, null=True)
    seqId       = models.IntegerField(null=True)
    
    def __str__(self):
        return '{} + {}'.format(self.startSkid, self.endSkid)

class PaintlineUnload((models.Model)):
    loop        = models.CharField(max_length=10, null=True)
    sequence    = models.CharField(max_length=10, null=True)
    startSkid   = models.CharField(max_length=10, null=True)
    endSkid     = models.CharField(max_length=10, null=True)
    skidQty     = models.CharField(max_length=10, null=True)
    quantity    = models.CharField(max_length=10, null=True)
    actualQty   = models.CharField(max_length=10, null=True)
    bypassQty   = models.CharField(max_length=10, null=True)
    mo          = models.CharField(max_length=30, null=True)
    itemNo      = models.CharField(max_length=100, null=True)
    description = models.CharField(max_length=255, null=True)
    color       = models.CharField(max_length=100, null=True)
    prodType    = models.CharField(max_length=20, null=True)
    seqId       = models.IntegerField(null=True)
    
    def __str__(self):
        return '{} + {}'.format(self.startSkid, self.endSkid)

class SkidEfficiency(models.Model):
    hour   = models.CharField(max_length=30)
    number = models.IntegerField()
    rate   = models.CharField(max_length=10)

#insert into skidKanban_SkidEfficiency (hour , number , rate) values ('08AM', 43, '71.67%')
#insert into skidKanban_SkidEfficiency (hour , number , rate) values ('09AM', 56, '93.33%')
#insert into skidKanban_SkidEfficiency (hour , number , rate) values ('10AM', 49, '81.67%')
#insert into skidKanban_SkidEfficiency (hour , number , rate) values ('11AM', 51, '85%')
#insert into skidKanban_SkidEfficiency (hour , number , rate) values ('12PM', 53, '88.33%')
#insert into skidKanban_SkidEfficiency (hour , number , rate) values ('13PM', 50, '83.33%')
#insert into skidKanban_SkidEfficiency (hour , number , rate) values ('14PM', 42, '70%')
#insert into skidKanban_SkidEfficiency (hour , number , rate) values ('15PM', 38, '63.33%')
#insert into skidKanban_SkidEfficiency (hour , number , rate) values ('16PM', 56, '93.33%')
#insert into skidKanban_SkidEfficiency (hour , number , rate) values ('17PM', 47, '78.33%')
#insert into skidKanban_SkidEfficiency (hour , number , rate) values ('18PM', 53, '88.33%')
#insert into skidKanban_SkidEfficiency (hour , number , rate) values ('19PM', 54, '90%')
#insert into skidKanban_SkidEfficiency (hour , number , rate) values ('20PM', 48, '80%')
#insert into skidKanban_SkidEfficiency (hour , number , rate) values ('21PM', 47, '78.33%')
#insert into skidKanban_SkidEfficiency (hour , number , rate) values ('22PM', 59, '98.33%')
#insert into skidKanban_SkidEfficiency (hour , number , rate) values ('23PM', 32, '53.33%')
#insert into skidKanban_SkidEfficiency (hour , number , rate) values ('00AM', 42, '70%')
#insert into skidKanban_SkidEfficiency (hour , number , rate) values ('01AM', 53, '88.33%')
#insert into skidKanban_SkidEfficiency (hour , number , rate) values ('02AM', 60, '100%')
#insert into skidKanban_SkidEfficiency (hour , number , rate) values ('03AM', 60, '100%')
#insert into skidKanban_SkidEfficiency (hour , number , rate) values ('04AM', 58, '96.67%')
#insert into skidKanban_SkidEfficiency (hour , number , rate) values ('05AM', 45, '75%')
#insert into skidKanban_SkidEfficiency (hour , number , rate) values ('06AM', 46, '76.67%')
#insert into skidKanban_SkidEfficiency (hour , number , rate) values ('07AM', 52, '86.67%')
#insert into skidKanban_SkidEfficiency (hour , number , rate) values ('08AM', 58, '96.67%')

#class SalesReport(models.Model):
#    month  = models.IntegerField()
#    sales  = models.IntegerField()
#    product  = models.CharField(max_length=25)
#
#insert into skidKanban_salesreport ([month] , sales , product ) values (1, 23123, 'Apple')
#insert into skidKanban_salesreport ([month] , sales , product ) values (2, 83457, 'Apple')
#insert into skidKanban_salesreport ([month] , sales , product ) values (3, 65382, 'Apple')
#insert into skidKanban_salesreport ([month] , sales , product ) values (4, 98756, 'Apple')
#insert into skidKanban_salesreport ([month] , sales , product ) values (5, 87265, 'Apple')
#insert into skidKanban_salesreport ([month] , sales , product ) values (6, 34560, 'Apple')
#insert into skidKanban_salesreport ([month] , sales , product ) values (7, 65423, 'Apple')
#insert into skidKanban_salesreport ([month] , sales , product ) values (8, 23123, 'Apple')
#insert into skidKanban_salesreport ([month] , sales , product ) values (9, 76532, 'Apple')
#insert into skidKanban_salesreport ([month] , sales , product ) values (10, 53221, 'Apple')

