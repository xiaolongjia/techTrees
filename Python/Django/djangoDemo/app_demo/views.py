from django.shortcuts import render
from django.http import HttpResponse

# Create your views here.

def hello(request):
    return HttpResponse('Hello Django')

def msg(request, name, age):
    return HttpResponse('My name is ' + name + ' my age is ' + age)

