from django.http import HttpResponse
from django.views.generic import TemplateView
from django.shortcuts import render
from .services import get_colors, get_queries


def index(request):
    return HttpResponse("loaded")


class GetColors(TemplateView):
    template_name = 'colors.html'

    def get_context_data(self, *args, **kwargs):
        context = {
            'colors': get_colors(kwargs['color']),
        }
        return context


class GetQueries(TemplateView):
    template_name = 'colors.html'

    def get_context_data(self, *args, **kwargs):
        context = {
            'colors': get_queries(kwargs['query']),
        }
        return context
