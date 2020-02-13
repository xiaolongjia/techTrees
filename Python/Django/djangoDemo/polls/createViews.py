from django.views.generic.edit import CreateView
from .models import Question, Choice

class ChoiceCreateView(CreateView):
    model = Choice
    fields = ['question', 'choice_text', 'votes']

