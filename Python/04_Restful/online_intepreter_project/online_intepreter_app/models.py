from django.db import models

# Create your models here.

class CodeModel(models.Model):
    name = models.CharField(max_length=50) 
    code = models.TextField()
    
    def __str__(self):
        return 'Code(name={},id={})'.format(self.name,self.id)