from django.db import models

# Create your models here.

class CodeModel(models.Model):
    name = models.CharField(max_length=50) 
    code = models.TextField()
    
    def __str__(self):
        return 'Code(name={},id={})'.format(self.name,self.id)


class Users (models.Model):
	userID = models.CharField(max_length=255)
	password = models.CharField(max_length=255, default='')
	userFirstName = models.CharField(max_length=100)
	userLastName = models.CharField(max_length=100)
	email = models.CharField(max_length=100)
	registerDate = models.DateField(null=True)
	
	def __str__(self):
		return '{} + {}'.format(self.userFirstName, self.userLastName)

