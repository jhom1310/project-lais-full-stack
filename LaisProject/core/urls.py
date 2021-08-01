"""core URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
import allauth
from django.contrib import admin
from django.urls import path, include, re_path
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)
from rest_framework import routers
from appusers.views import *
from django.conf.urls import url
from allauth.account.views import confirm_email

from vacinas.views import LocalViewSet, GroupsViewSet, SchedulingViewSet

router_vacinas = routers.DefaultRouter()
router_vacinas.register(r'locals', LocalViewSet)
router_vacinas.register(r'groups', GroupsViewSet)
router_vacinas.register(r'agendamentos', SchedulingViewSet)

router_user = routers.DefaultRouter()
router_user.register(r'users', UserViewSet)



urlpatterns = [


    url(r'^swagger(?P<format>\.json|\.yaml)$', schema_view.without_ui(cache_timeout=0), name='schema-json'),
    url(r'^swagger/$', schema_view.with_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),
    url(r'^redoc/$', schema_view.with_ui('redoc', cache_timeout=0), name='schema-redoc'),

    path('admin/', admin.site.urls),
    path('api/user/', include(router_user.urls)),
    path('api/vacinas/', include(router_vacinas.urls)),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    path('', Home.as_view(), name='home'), # new


    url(r'^logout/', Logout.as_view()),
    url(r'^rest-auth/', include('rest_auth.urls')),
    url(r'^rest-auth/registration/', include('rest_auth.registration.urls')),
    url(r'^accounts/', include('allauth.urls')),
    url(r'^accounts-rest/registration/account-confirm-email/(?P<key>.+)/$', confirm_email, name='account_confirm_email'),
    re_path(
        r"^accounts/password/reset/key/(?P<uidb64>[0-9A-Za-z]+)-(?P<token>.+)/$",
        allauth.account.views.password_reset_from_key,
        name="password_reset_confirm",
    ),
    path('api-token-auth/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api-token-refresh/', TokenRefreshView.as_view(), name='token_refresh'),


]
#http://localhost:8000/account/password/reset/key/a-aizgjx-e1c3868f8ffde4156e2a40f6683f458a/
#http://http://localhost:8000/password/reset/key/MTA-aizgio-7d930e4de5520127db99f5077ab16d74/

