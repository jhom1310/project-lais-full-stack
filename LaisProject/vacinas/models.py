from django.db import models

# Create your models here.
from core import settings


class Local(models.Model):
    vlr_latitude = models.CharField(max_length=200)
    vlr_longitude = models.CharField(max_length=200)
    nom_estab = models.CharField(max_length=200)
    dsc_endereco = models.CharField(max_length=200)
    dsc_bairro = models.CharField(max_length=200)
    dsc_cidade = models.CharField(max_length=200)

    def __str__(self):
        return self.nom_estab

class Groups(models.Model):
    name = models.CharField(max_length=200)
    min_age = models.PositiveIntegerField()

    def __str__(self):
        return str(self.name) + " - " + str(self.min_age)

class Scheduling(models.Model):
    STATUS_CHOICES = (
        (1, 'Agendado'),
        (2, 'Cancelado'),
        (3, 'Vacinado')
    )
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    datatime = models.DateTimeField()
    local = models.ForeignKey(Local, on_delete=models.CASCADE)
    groups = models.ForeignKey(Groups, on_delete=models.CASCADE)
    age = models.PositiveIntegerField()
    status = models.IntegerField(choices=STATUS_CHOICES, blank=True, default=1)

