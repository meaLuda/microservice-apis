from django.contrib import admin
from django.contrib import admin
from .models import Depertment,Diploma,Module,CourseContent,Submodule
# Register your models here.
admin.site.register(Depertment)
admin.site.register(Diploma)
admin.site.register(Module)
admin.site.register(Submodule)
admin.site.register(CourseContent)
