from django.http import HttpResponse, JsonResponse
from django.views.generic import ListView
from django.shortcuts import render
from .services import get_colors, get_queries, reverse_image, curated_images


def index(request):
    return HttpResponse("loaded")


class GetColors(ListView):
    def get(self, *args, **kwargs):
        if 'query' in kwargs:
            context = JsonResponse(get_colors(kwargs['color'], kwargs['query']), safe=False)
        else:
            context = JsonResponse(get_colors(kwargs['color']), safe=False)
        return context


class GetQueries(ListView):
    def get(self, *args, **kwargs):
        context = JsonResponse(get_queries(kwargs['query']), safe=False)
        return context


class GetColorsReverseImage(ListView):
    def get(self, *args, **kwargs):
        context = JsonResponse(reverse_image(kwargs['path']), safe=False)
        return context


class GetCurated(ListView):
    def get(self, *args, **kwargs):
        context = JsonResponse(curated_images(), safe=False)
        return context