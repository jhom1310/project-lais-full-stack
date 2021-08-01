from rest_framework import serializers
from django.utils.dateparse import parse_datetime
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
    status = serializers.SerializerMethodField()
    local = serializers.StringRelatedField()
    user = serializers.StringRelatedField()
    groups = serializers.StringRelatedField()
    class Meta:
        model = Scheduling
        fields = ['local', 'user','status', 'groups', 'datatime', 'age']

    def get_status(self, obj):
        return obj.get_status_display()