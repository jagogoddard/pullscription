from django.urls import path

from . import views

urlpatterns = [
    path('search/<str:query>', views.search),
    path('browse', views.browse),
    path('get/<str:query>', views.get),
    path('add/<str:person>/<str:query>', views.add),
    path('remove/<str:person>/<str:query>', views.remove),
    path('pulls/<str:person>', views.pulls)
]