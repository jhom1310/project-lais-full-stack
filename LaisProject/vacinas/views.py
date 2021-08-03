from django.shortcuts import render

from rest_framework import viewsets, status
from rest_framework.permissions import IsAdminUser, IsAuthenticated
from rest_framework.response import Response
from vacinas.models import *
from vacinas.serializers import *


class LocalViewSet(viewsets.ModelViewSet):
    queryset = Local.objects.all()
    serializer_class = LocalSerializer
    #permission_classes = [IsAdminUser]

    def get_permissions(self):
        """Set custom permissions for each action."""
        if self.action in ['list']:
            self.permission_classes = [IsAuthenticated, ]
        elif self.action in ['create', 'update', 'partial_update', 'destroy', ]:
            self.permission_classes = [IsAdminUser, ]
        return super().get_permissions()



    def get_queryset(self):
        queryset = Local.objects.all()

        dsc_cidade = self.request.query_params.get('cidade')
        if dsc_cidade is not None:
            queryset = queryset.filter(dsc_cidade=dsc_cidade)
        return queryset

class GroupsViewSet(viewsets.ModelViewSet):
    queryset = Groups.objects.all()
    serializer_class = GroupsSerializer
    #permission_classes = [IsAdminUser]

    def get_permissions(self):
        """Set custom permissions for each action."""
        if self.action in ['list']:
            self.permission_classes = [IsAuthenticated, ]
        elif self.action in ['create','update', 'partial_update', 'destroy',]:
            self.permission_classes = [IsAdminUser, ]
        return super().get_permissions()

class SchedulingViewSet(viewsets.ModelViewSet):
    queryset = Scheduling.objects.all()
    serializer_class = SchedulingSerializer

    def get_queryset(self):
        queryset = Scheduling.objects.all().order_by('status')
        status = self.request.query_params.get('status')
        user_id = self.request.query_params.get('user')
        if user_id is not None:
            queryset = queryset.filter(user__email=user_id)
        elif status is not None:
            queryset = queryset.filter(status=status)
        return queryset

    def create(self, request):
        serializer = self.get_serializer(data=request.data)
        aux = Scheduling.objects.filter(user=request.data['user']).filter(status=1)
        if aux:
            headers =self.default_response_headers
            return Response('Ja existe um agendamento', status=status.HTTP_400_BAD_REQUEST, headers=headers)
        else:
            serializer.is_valid(raise_exception=True)
            self.perform_create(serializer)
            headers = self.get_success_headers(serializer.data)
            return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)
