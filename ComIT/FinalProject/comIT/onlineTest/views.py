from django.shortcuts import render, redirect
from django.http import HttpResponse
from .models import Users
from .forms import SignupForm, AddForm
import logging
import datetime

logger = logging.getLogger(__name__)


def login(request):
    return render(request, 'login.html')


def signup(request):

    if request.method == 'POST':  # 当提交表单时
        form = SignupForm(request.POST)  # form 包含提交的数据

        if form.is_valid():  # 如果提交的数据合法
            newUser = Users()
            newUser.userID = form.cleaned_data['userID']
            newUser.email = form.cleaned_data['email']
            newUser.userLastName = form.cleaned_data['lastName']
            newUser.userFirstName = form.cleaned_data['firstName']
            newUser.password = form.cleaned_data['password']

            if not Users.objects.filter(userID=newUser.userID).first() and \
                    not Users.objects.filter(email=newUser.email).first():
                newUser.registerDate = datetime.date.today().strftime('%Y-%m-%d')
                newUser.save()
                return redirect('/home/', username=newUser.userID, password=newUser.password)
            else:
                error1 = "user has been registered"
                error2 = "please check User ID or Email Address"
                return render(request, 'form.html', {'form': form, 'error1': error1, 'error2': error2})

    else:  # 当正常访问时
        form = SignupForm()
    return render(request, 'form.html', {'form': form})


def home(request):
    userID = request.GET['username']
    password = request.GET['password']
    if request.method == 'POST':
        userID = request.POST.get('username')
        password = request.POST.get('password')
        if not Users.objects.filter(userID=userID).filter(password=password).first():
            return HttpResponse("userID and password incorrect!")

    logger.info(userID)
    logger.info(password)
    # read from cookie
    # 1. use username in cookie
    # 2. redirect to login.html
    return HttpResponse("Home page.")


def index(request, index):
    logger.info("index is: {}".format(index))
    if request.method == 'POST':  # 当提交表单时
        logger.info(request.POST)
        form = AddForm(request.POST)  # form 包含提交的数据

        if form.is_valid():  # 如果提交的数据合法
            a = form.cleaned_data['a']
            b = form.cleaned_data['b']
            return HttpResponse(str(int(a) + int(b)))

    else:  # 当正常访问时
        form = AddForm()
    return render(request, 'form.html', {'form': form})
