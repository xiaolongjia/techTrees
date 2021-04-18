"""online_intepreter_project URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.1/topics/http/urls/
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

# from django.contrib import admin
# from django.urls import path
from django.conf.urls import url, include

from online_intepreter_app.views import APICodeView, APIRunCodeView, login, signup, home, js, css # import view function
from django.views.decorators.csrf import csrf_exempt # get rid of csrf function since we have restful framework, would use JWT token in the future

# general set operation API
generic_code_view = csrf_exempt(APICodeView.as_view(method_map={'get': 'list',
                                                                'post': 'create'}))  # pass in self-defined method_map param
                                                                
# certain instance operation API
detail_code_view = csrf_exempt(APICodeView.as_view(method_map={'get': 'detail',
                                                               'put': 'update',
                                                               'delete': 'remove'}))
# run code operation API
run_code_view = csrf_exempt(APIRunCodeView.as_view())
# Code application API configure
code_api = [
    url(r'^$', generic_code_view, name='generic_code'),  # set operation
    url(r'^(?P<pk>\d*)/$', detail_code_view, name='detail_code'),  # visit certain instance
    url(r'^run/$', run_code_view, name='run_code'),  # run code
    url(r'^run/(?P<pk>\d*)/$', run_code_view, name='run_specific_code')  # run specific specific code
]
api_v1 = [url('^codes/', include(code_api))]  # API v1
api_versions = [url(r'^v1/', include(api_v1))]  # API version control entry URL
urlpatterns = [
    url(r'^api/', include(api_versions)),  # API visit URL
    url(r'^$', login, name='login'),  # login
	url(r'home/', home, name='index'),  # home
	url(r'signup/', signup, name='signup'),  # signup
    url(r'^js/(?P<filename>.*\.js)$', js, name='js'),  # visit js file
    url(r'^css/(?P<filename>.*\.css)$', css, name='css')  # visit css file
]


