from django.urls import path

from . import views

urlpatterns = [
    path('search/<str:query>', views.search)
    path('', views.index, name='index'),
]