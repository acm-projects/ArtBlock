"""testing URL Configuration

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
from django.contrib import admin
from django.urls import path, re_path

from quickstart import views
from quickstart.views import GetColors, GetQueries, GetColorsReverseImage, GetCurated

urlpatterns = [
    path('admin', admin.site.urls),
    re_path(r'^color/(?P<color>[A-Za-z]{3,})(&(?P<query>[A-Za-z]+))?$', GetColors.as_view(), name='Color View'),
    # name of color, with optional query. is this function necessary?
    # probably don't bother using this function actually, might not work with certain colors
    re_path(r'^color/hex/(?P<color>[A-Za-z0-9]{6})(&(?P<query>[A-Za-z]+))?$', GetColors.as_view(), name='Color View by Hex'),
    # color hex code, all lowercase, with optional query, no #
    # example: color/hex/f0f0f0. example with query: color/hex/f0f0f0&frog
    re_path(r'^query/(?P<query>[A-Za-z&:]+)$', GetQueries.as_view(), name='Query View'), # ex: query/frog
    re_path(r'^image/(?P<path>.+)$', GetColorsReverseImage.as_view(), name='Reverse Image View'), # pass in file path
    path('curated', GetCurated.as_view(), name='Curated View'), # no parameters, returns 15 curated images
    re_path(r'^$', views.index, name="index"),
]
