from rest_framework import serializers
from .models import User
from django.contrib import auth
from rest_framework.exceptions import AuthenticationFailed
from rest_framework_simplejwt.tokens import RefreshToken,TokenError


class RegisterSerializer(serializers.ModelSerializer):
    username=serializers.CharField(max_length=60,min_length=3)
    password=serializers.CharField(max_length=60,min_length=6,write_only=True)
    #first_name=serializers.CharField(max_length=255,min_length=2,write_only=True)
    #last_name=serializers.CharField(max_length=255,min_length=2,write_only=True)

    class Meta:
        model = User
        fields =['email','username','password']

    def validate(self,attrs):
        username=attrs.get('username','')
        email=attrs.get('email','')

        if not username.isalnum():
            raise serializers.ValidationError(
                'The username should only have alphanumeric characters')

        if User.objects.filter(username=attrs['username']).exists():
            raise serializers.ValidationError(
                'The username has already been used')
        if User.objects.filter(email=attrs['email']).exists():
            raise serializers.ValidationError(
                'The email has already been used')
        return attrs
    
    def create(self,validated_data):
        return User.objects.create_user(**validated_data)
class LoginSerializer(serializers.ModelSerializer):
    password=serializers.CharField(max_length=255,min_length=6,write_only=True)
    email=serializers.EmailField(max_length=255,min_length=3,)
    tokens=serializers.CharField(max_length=255,min_length=6,read_only=True)
    username=serializers.CharField(max_length=255,min_length=3,read_only=True)

    class Meta:
        model=User
        fields=['email','password','username','tokens']

    def validate(self, attrs):
        email = attrs.get('email','')
        password = attrs.get('password','')

        user=auth.authenticate(email=email, password=password)
        
        if not user:
            raise AuthenticationFailed('Invalid credentials, try again!')
    
        return{
            'email':user.email,
            'username':user.username,
            'tokens':user.tokens(),
        }
        return super().validate(attrs)

class LogoutSerializer(serializers.Serializer):
    refresh = serializers.CharField()

    def validate(self, attrs):
        self.token = attrs['refresh']
        return attrs

    def save(self, **kwargs):

        try:
            RefreshToken(self.token).blacklist()

        except TokenError:
            raise serializers.ValidationError('Fail to logout, Token expired!')
            

