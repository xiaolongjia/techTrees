from django.shortcuts import render, redirect
from django.http import HttpResponse
from .models import Users, FundRate
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
                request.session['is_login'] = True
                request.session['user'] = newUser.userID
                request.session.set_expiry(30)
                return redirect('/home/')
            else:
                error1 = "user has been registered"
                error2 = "please check User ID or Email Address"
                return render(request, 'form.html', {'form': form, 'error1': error1, 'error2': error2})

    else:  # 当正常访问时
        form = SignupForm()
    return render(request, 'form.html', {'form': form})


def home(request):
    if request.method == 'POST': # from login.html
        userID = request.POST.get('username')
        password = request.POST.get('password')
        if not Users.objects.filter(userID=userID).filter(password=password).first():
            return HttpResponse("userID and password incorrect!")
        request.session['is_login'] = True
        request.session['user'] = userID
        request.session.set_expiry(30)
    else:
        status = request.session.get('is_login')
        if not status:
            return redirect('login')
    userID = request.session.get('user')
    return render(request, 'fundrate.html')
