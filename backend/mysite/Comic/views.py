import csv,io,os,datetime
from django.http import HttpResponse
from .models import Comic
from authentication.models import User
from . import views
from django.core.exceptions import ObjectDoesNotExist

def search(request, query):
    words = query.split("-")
    comics = Comic.objects.filter(full_title__contains=words[0])
    for word in words:
        comics = comics.filter(full_title__contains=word)
    json = '[  '
    for comic in comics:
        json += str(comic)
        json += ","
    json = json[:-1]
    json += "]"
    return HttpResponse(json)

def browse(request):
    today = datetime.date.today()
    weekdayOffset = (2-today.weekday()) % 7
    delta = datetime.timedelta(days = weekdayOffset+28)
    nextRelease = today + delta
    dateString = str(nextRelease.month)+'/'+str(nextRelease.day)+'/'+str(nextRelease.year) # Because the sqlite database got a bit screwed
    #dateString = nextRelease.strftime("%Y-%m-%d")
    comics = Comic.objects.filter(ship_date=dateString).exclude(oa='Y')#.exclude(mature='Y')
    json = '[  '
    for comic in comics:
        json += str(comic)
        json += ","
    json = json[:-1]
    json += "]"
    return HttpResponse(json)

def get(request, query):
    words = query.split("-")
    json = '[  '
    for word in words:
        try:
            comic = Comic.objects.get(stock_no=word)
            json += str(comic)
            json += ","
        except ObjectDoesNotExist:
            continue
    json = json[:-1]
    json += "]"
    return HttpResponse(json)

def add(request, person, query):
    try:
        user = User.objects.get(username = person)
    except ObjectDoesNotExist:
        return HttpResponse("User does not exist!")
    words = query.split("-")
    for word in words:
        if user.pull_list == "":
            user.pull_list += word
        else:
            user.pull_list += ("-" + word)
    user.save()
    return HttpResponse("Pull list successfully updated to: " + user.pull_list)

def remove(request, person, query):
    try:
        user = User.objects.get(username = person)
    except ObjectDoesNotExist:
        return HttpResponse("User does not exist!")
    words = query.split("-")
    for word in words:
        user.pull_list = user.pull_list.replace('-'+word, '')
        user.pull_list = user.pull_list.replace(word+'-', '')
        user.pull_list = user.pull_list.replace(word, '')
    user.save()
    return HttpResponse("Pull list successfully updated to: " + user.pull_list)

def pulls(request, person):
    try:
        user = User.objects.get(username = person)
    except ObjectDoesNotExist:
        return HttpResponse("User does not exist!")
    return get(request, user.pull_list)