from django.shortcuts import render
from rest_framework import generics,permissions
from .serializers import RegisterSerializer,LoginSerializer,LogoutSerializer
from rest_framework.response import Response
from rest_framework import status
from .models import User
from django.conf import settings
from django.contrib import auth


class RegisterView(generics.GenericAPIView):
  
    serializer_class = RegisterSerializer

    def post(self,request):
        user =request.data
        serializer = self.serializer_class(data=user)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status= status.HTTP_201_CREATED)
        return Response(serializer.errors,status= status.HTTP_400_BAD_REQUEST)

class LoginView(generics.GenericAPIView):

    serializer_class=LoginSerializer

    def post(self,request):
        serializer = self.serializer_class(data=request.data)
        serializer.is_valid(raise_exception=True)
        
        return Response(serializer.data, status=status.HTTP_200_OK)

class LogoutView(generics.GenericAPIView):
    serializer_class = LogoutSerializer

    permission_classes = (permissions.IsAuthenticated,)

    def post(self, request):

        serializer = self.serializer_class(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()

        return Response(status=status.HTTP_204_NO_CONTENT)
#class Pull


    