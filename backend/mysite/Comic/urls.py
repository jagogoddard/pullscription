from django.urls import path

from . import views

urlpatterns = [
    path('search/<str:query>', views.search),
    path('browse', views.browse)
    #path('', views.index, name='index')
]