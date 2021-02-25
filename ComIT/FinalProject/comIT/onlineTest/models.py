import datetime
from django.db import models
from django.utils import timezone

# Create your models here.

class users(models.Model):
	userID = models.IntegerField()
	userFirstName = models.CharField(max_length=100)
	userLastName  = models.CharField(max_length=100)
	email         = models.CharField(max_length=100)
	registerDate  = models.DateField(null=True)
	
	def __str__(self):
		return '{} + {}'.format(self.userFirstName, self.userLastName)

