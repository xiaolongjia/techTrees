"""djangoDemo URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
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
from django.urls import path, re_path
from . import views, createViews

urlpatterns = [
    path('', views.index, name='index'),
    path('mregister/', views.muserRegister, name='mregister'),
    path('register/', views.register, name='register'),
    path('register/index/', views.register_index, name='registerIndex'),
    path('index/', views.IndexView.as_view()),
    path('create/', createViews.ChoiceCreateView.as_view()),
    #path('question/<int:questionid>', views.question),
    re_path(r'^question/(?P<questionid>\d+)/$', views.question, name='question'),
]
