from django.shortcuts import render
from rest_framework import viewsets

from vacinas.models import *
from vacinas.serializers import *


class LocalViewSet(viewsets.ModelViewSet):
    queryset = Local.objects.all()
    serializer_class = LocalSerializer

    def get_queryset(self):
        queryset = Local.objects.all()

        dsc_cidade = self.request.query_params.get('cidade')
        if dsc_cidade is not None:
            queryset = queryset.filter(dsc_cidade=dsc_cidade)
        return queryset

class GroupsViewSet(viewsets.ModelViewSet):
    queryset = Groups.objects.all()
    serializer_class = GroupsSerializer

class SchedulingViewSet(viewsets.ModelViewSet):
    queryset = Scheduling.objects.all()
    serializer_class = SchedulingSerializer