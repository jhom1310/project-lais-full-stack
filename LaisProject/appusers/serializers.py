import rest_auth
from django.db import transaction
from rest_auth.models import TokenModel
from rest_auth.registration.serializers import RegisterSerializer
from rest_auth.serializers import LoginSerializer
from rest_framework.reverse import reverse
from .models import CustomUser
from rest_framework import serializers


class UserSerializer(serializers.ModelSerializer):

    class Meta:
        model = CustomUser
        fields = ['id', 'email', 'name', 'date_of_birth']

class CustomRegisterSerializer(RegisterSerializer):
    username = None
    name = serializers.CharField(max_length=300)
    date_of_birth = serializers.DateField(input_formats=["%d/%m/%Y", "%Y-%m-%d"])


    # Define transaction.atomic to rollback the save operation in case of error
    @transaction.atomic
    def save(self, request):
        user = super().save(request)
        user.sex = self.data.get('sex')
        user.date_of_birth = self.data.get('date_of_birth')
        user.institution = self.data.get('institution')
        user.name = self.data.get('name')

        user.save()
        return user

class CustomLoginSerializer(LoginSerializer):
    email = serializers.EmailField(required=True, allow_blank=True)
    username = None

class CustomTokenSerializer(serializers.ModelSerializer):
    user = UserSerializer()
    class Meta:
        model = TokenModel
        fields = ['key', 'user']
