import datetime
from django.db import models
from django.utils import timezone


# Create your models here.

class planKanban(models.Model):
    loop = models.CharField(max_length=10)
    startSkid = models.CharField(max_length=10)
    endSkid = models.CharField(max_length=10)
    skidQty = models.CharField(max_length=10)
    quantity = models.CharField(max_length=10)
    actualQty = models.CharField(max_length=10)
    bypassQty = models.CharField(max_length=10)
    mo = models.CharField(max_length=10)
    itemNo = models.CharField(max_length=100)
    description = models.CharField(max_length=255)
    color = models.CharField(max_length=100)
    prodType = models.CharField(max_length=20)
    
    def __str__(self):
        return '{} + {}'.format(self.startSkid, self.endSkid)

class Address(models.Model):
    AddressId = models.IntegerField()
    PersonId  = models.IntegerField()
    City      = models.CharField(max_length=255)
    State     = models.CharField(max_length=255)
    
    #pub_date = models.DateTimeField('date published')
    #comments = models.TextField(blank=True, default='')
    #add_date = models.DateField(null=True)
    
    def __str__(self):
        return '{} + {}'.format(self.AddressId, self.PersonId)
    
    def lasted_joined_person(self):
        return self.PersonId<3

class Logs(models.Model):
    anyId  = models.IntegerField()
    Num = models.IntegerField()
    
class Country(models.Model):
    name = models.CharField(max_length=30)

class City(models.Model):
    name = models.CharField(max_length=30)
    country = models.ForeignKey(Country, on_delete=models.CASCADE)
    population = models.PositiveIntegerField()

class SalesReport(models.Model):
    month  = models.IntegerField()
    sales  = models.IntegerField()
    product  = models.CharField(max_length=25)

#insert into PaintReports_salesreport ([month] , sales , product ) values (1, 23123, 'Apple')
#insert into PaintReports_salesreport ([month] , sales , product ) values (2, 83457, 'Apple')
#insert into PaintReports_salesreport ([month] , sales , product ) values (3, 65382, 'Apple')
#insert into PaintReports_salesreport ([month] , sales , product ) values (4, 98756, 'Apple')
#insert into PaintReports_salesreport ([month] , sales , product ) values (5, 87265, 'Apple')
#insert into PaintReports_salesreport ([month] , sales , product ) values (6, 34560, 'Apple')
#insert into PaintReports_salesreport ([month] , sales , product ) values (7, 65423, 'Apple')
#insert into PaintReports_salesreport ([month] , sales , product ) values (8, 23123, 'Apple')
#insert into PaintReports_salesreport ([month] , sales , product ) values (9, 76532, 'Apple')
#insert into PaintReports_salesreport ([month] , sales , product ) values (10, 53221, 'Apple')

