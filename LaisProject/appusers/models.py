from datetime import datetime

from django.db import models
from django.contrib.auth.models import AbstractUser
from django.utils import timezone
from django.utils.translation import ugettext_lazy as _

from core import settings
from .managers import CustomUserManager


class CustomUser(AbstractUser):
    username = None
    first_name = None
    last_name = None
    email = models.EmailField(_('email address'), unique=True)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    objects = CustomUserManager()


    name = models.CharField(blank=True, max_length=300)
    date_of_birth = models.DateField(blank=True, null=True)


    def __str__(self):
        return self.email
