from django.shortcuts import render, render_to_response
from django.http import HttpResponse, JsonResponse
from django.db.models import Sum
from .models import PaintlinePlan, PaintlineUnload, SkidEfficiency
from chartit import DataPool, Chart

# Create your views here.

def planKanbanView(request):
    queryset = PaintlinePlan.objects.all()
    return render(request, 'planKanban.html', {"planKanban": queryset})

def unloadKanbanView(request):
    queryset = PaintlineUnload.objects.all()
    return render(request, 'planKanban.html', {"planKanban": queryset})

def SKIDEfficiency(request):
    return render(request, 'SKIDEfficiency.html')

def SKIDEfficiencyData(request):
    labels = []
    data   = []
    rate   = []
    color  = []
    baseline = []

    queryset = SkidEfficiency.objects.all()
    for entry in queryset:        
        labels.append(entry.hour)
        data.append(entry.number)
        rate.append(entry.rate)
        baseline.append(60*0.9)
        if (entry.number >= 54):
            color.append("green")
        elif (entry.number < 48):
            color.append("red")
        else: 
            color.append("yellow")
    #baseline.append(60*0.9)
    
    return JsonResponse(data={
        'labels': labels,
        'data': data,
        'color': color,
        'rate': rate,
        'baseline': baseline,
    })




#def sales(request):
#    #Step 1: Create a DataPool with the data we want to retrieve.
#    sales = \
#        DataPool(
#           series=
#            [{'options': {
#               'source': SalesReport.objects.all()},
#              'terms': [
#                'month',
#                'sales']}
#             ])
#
#    #Step 2: Create the Chart object
#    cht = Chart(
#            datasource = sales,
#            series_options =
#              [{'options':{
#                  'type': 'column',  #line, column 
#                  'stacking': False},
#                'terms':{
#                  'month': [
#                    'sales']
#                  }}],
#            chart_options =
#              {'title': {
#                   'text': 'Sales pricing for month'},
#               'xAxis': {
#                    'title': {
#                       'text': 'Month number'}}})
#
#    #Step 3: Send the chart object to the template.
#    return render(request, 'sales.html', {'char_list': cht})


