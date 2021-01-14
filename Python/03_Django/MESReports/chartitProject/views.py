from django.shortcuts import render, render_to_response
from django.http import HttpResponse, JsonResponse
from django.db.models import Sum
from .models import SalesReport
from chartit import DataPool, Chart

# Create your views here.

def sales(request):
    #Step 1: Create a DataPool with the data we want to retrieve.
    sales = \
        DataPool(
           series=
            [{'options': {
               'source': SalesReport.objects.all()},
              'terms': [
                'month',
                'sales']}
             ])

    #Step 2: Create the Chart object
    cht = Chart(
            datasource = sales,
            series_options =
              [{'options':{
                  'type': 'column',  #line, column 
                  'stacking': False},
                'terms':{
                  'month': [
                    'sales']
                  }}],
            chart_options =
              {'title': {
                   'text': 'Sales pricing for month'},
               'xAxis': {
                    'title': {
                       'text': 'Month number'}}})

    #Step 3: Send the chart object to the template.
    return render(request, 'sales.html', {'char_list': cht})
