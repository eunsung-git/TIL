from django.db import models

# Create your models here.
class Member(models.Model):
    #  = models.CharField(max_length=15)
    password = models.CharField(max_length=15)
    gender = models.BinaryField()
    # region = models.....
    clothes = models.FileField()
    
