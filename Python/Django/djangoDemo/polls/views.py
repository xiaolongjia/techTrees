from django.shortcuts import render, get_object_or_404
from django.http import HttpResponse
from .models import Question, Choice

def index(request):
    latest_questions = Question.objects.all().order_by('-pub_date')
    return render(request, 'questions.html', {"latest_questions": latest_questions})


def question(request, questionid):
    currQuestion = get_object_or_404(Question, pk=questionid)
    return render(request, 'questionDetail.html', {"question": currQuestion})


from django.views.generic import ListView

class IndexView(ListView):
    model = Question

