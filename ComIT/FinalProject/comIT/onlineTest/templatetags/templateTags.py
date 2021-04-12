
from django import template
from ..models import FundRate, Users

register = template.Library()


@register.simple_tag
def get_top10_rates(num=10):
    return FundRate.objects.all().order_by('-FundID')[:num]

