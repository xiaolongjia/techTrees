from django.shortcuts import render, get_object_or_404
from .models import Question, Choice, User
from .forms import RegistrationForm, mRegistrationForm
from django.http import HttpResponse, HttpResponseRedirect
from django.utils import timezone

def index(request):
    latest_questions = Question.objects.all().order_by('-pub_date')
    return render(request, 'questions.html', {"latest_questions": latest_questions})


def question(request, questionid):
    currQuestion = get_object_or_404(Question, pk=questionid)
    return render(request, 'questionDetail.html', {"question": currQuestion})

def muserRegister(request):
    if request.method == 'POST':
        formset = mRegistrationForm(request.POST, request.FILES)
        if formset.is_valid():
            pass
    else:
        formset = mRegistrationForm()
    return render(request, 'manage_users.html', {'formset':formset})

def register(request):
    if request.method == 'POST':
        form = RegistrationForm(request.POST)
        if form.is_valid():
            username = form.cleaned_data['username']
            email = form.cleaned_data['email']
            password = form.cleaned_data['password2']
            user = User.objects.create(username=username, password=password, email=email)
            return HttpResponseRedirect("index/")
    else:
        form = RegistrationForm()

    return render(request, 'registration.html', {'form': form})

def register_index(request):
    allusers = User.objects.all()
    return render(request, 'users.html', {"allusers": allusers})

from django.views.generic import ListView

class IndexView(ListView):
    model = Choice
    template_name = 'polls/choice_list.xml'
    context_object_name = 'choice_list'

    def get_queryset(self):
        return Choice.objects.all()

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['now'] = timezone.now()
        return context

