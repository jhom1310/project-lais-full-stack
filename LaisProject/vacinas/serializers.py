from rest_framework import serializers
from django.utils.dateparse import parse_datetime

from appusers.models import CustomUser
from core import settings
from vacinas.models import Local, Groups, Scheduling


class LocalSerializer(serializers.ModelSerializer):
    class Meta:
        model = Local
        exclude = []

class GroupsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Groups
        exclude = []

class SchedulingSerializer(serializers.ModelSerializer):
    local = serializers.SlugRelatedField(
        slug_field='nom_estab',
        queryset=Local.objects.all()
     )
    groups = serializers.SlugRelatedField(
        slug_field='name',
        queryset=Groups.objects.all()
     )
    class Meta:
        model = Scheduling
        fields = ['local', 'user','status', 'groups', 'datatime', 'age']
