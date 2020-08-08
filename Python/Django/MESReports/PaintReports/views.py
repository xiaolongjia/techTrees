from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.db.models import Sum
from .models import Address, Logs, planKanban, Country, City


# Create your views here.

def planKanbanView(request):
    queryset = planKanban.objects.all()
    return render(request, 'planKanban.html', {"planKanban": queryset})

# pie chart 

def pie_chart(request):
    labels = []
    data = []

    queryset = City.objects.order_by('-population')[:5]
    for city in queryset:
        labels.append(city.name)
        data.append(city.population)

    return render(request, 'pie_chart.html', {
        'labels': labels,
        'data': data,
    })

# bar chart 

def home(request):
    return render(request, 'home.html')

def population_chart(request):
    labels = []
    data = []

    queryset = City.objects.values('country__name').annotate(country_population=Sum('population')).order_by('-country_population')
    for entry in queryset:
        labels.append(entry['country__name'])
        data.append(entry['country_population'])
    
    return JsonResponse(data={
        'labels': labels,
        'data': data,
    })
