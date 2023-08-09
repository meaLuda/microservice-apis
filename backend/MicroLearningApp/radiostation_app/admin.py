from django.contrib import admin
from .models import RadioStation,RadioStationCategory
# Register your models here.
admin.site.register(RadioStationCategory)
admin.site.register(RadioStation)