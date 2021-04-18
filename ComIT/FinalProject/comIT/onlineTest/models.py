#coding=utf-8

from django.db import models


class Users (models.Model):
	userID = models.CharField(max_length=255)
	password = models.CharField(max_length=255, default='')
	userFirstName = models.CharField(max_length=100)
	userLastName = models.CharField(max_length=100)
	email = models.CharField(max_length=100)
	registerDate = models.DateField(null=True)
	
	def __str__(self):
		return '{} + {}'.format(self.userFirstName, self.userLastName)


class FundRate(models.Model):
	rate = models.IntegerField()
	FundID = models.IntegerField()
	FundName = models.CharField(max_length=255, default='')
	avgIncrease = models.DecimalField( max_digits=30, decimal_places=28)
	increaseRate = models.DecimalField( max_digits=30, decimal_places=28)

