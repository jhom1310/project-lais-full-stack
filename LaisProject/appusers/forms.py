from allauth.account.forms import SignupForm
from django import forms
from django.db import transaction
from django.forms.widgets import RadioSelect
from django.forms import SelectDateWidget

from appusers.models import CustomUser



class CustomSignupForm(SignupForm):

    def __init__(self, *args, **kwargs):
        super(CustomSignupForm, self).__init__(*args, **kwargs)
        self.fields['name'].widget = forms.TextInput(attrs={'placeholder': 'Informe o nome completo '})


    class Meta:
        model = CustomUser
        fields = ('name', 'date_of_birth', 'sex')

    #first_name = forms.CharField(max_length=30, label='Primeiro Nome')
    #last_name = forms.CharField(max_length=30, label='Ultimo Nome')
    name = forms.CharField(label='Nome Completo')
    date_of_birth = forms.DateField(widget=SelectDateWidget)

    @transaction.atomic
    def save(self, request):
        user = super().save(request)
        user.date_of_birth = self.data.get('date_of_birth')
        user.name = self.data.get('name')
        user.save()
        return user

