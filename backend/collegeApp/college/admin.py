from django.contrib import admin
from django.contrib import admin
from .models import (
    Depertment, Diploma, Module, Submodule,
    NoteContent, QuizContent, VideoContent,
)
# Register your models here.
@admin.register(Depertment)
class DepertmentAdmin(admin.ModelAdmin):
    list_display = ('title',)
    search_fields = ('title',)

@admin.register(Diploma)
class DiplomaAdmin(admin.ModelAdmin):
    list_display = ('title', 'depertment')
    list_filter = ('depertment',)
    search_fields = ('title',)

@admin.register(Module)
class ModuleAdmin(admin.ModelAdmin):
    list_display = ('title', 'diploma')
    list_filter = ('diploma',)
    search_fields = ('title',)

@admin.register(Submodule)
class SubmoduleAdmin(admin.ModelAdmin):
    list_display = ('title', 'diploma', 'module')
    list_filter = ('diploma', 'module')
    search_fields = ('title',)

@admin.register(NoteContent)
class NoteContentAdmin(admin.ModelAdmin):
    list_display = ('title', 'diploma', 'module', 'sub_module')
    list_filter = ('diploma', 'module', 'sub_module')
    search_fields = ('title',)

@admin.register(QuizContent)
class QuizContentAdmin(admin.ModelAdmin):
    list_display = ('title', 'diploma', 'module', 'sub_module')
    list_filter = ('diploma', 'module', 'sub_module')
    search_fields = ('title',)

@admin.register(VideoContent)
class VideoContentAdmin(admin.ModelAdmin):
    list_display = ('title', 'diploma', 'module', 'sub_module')
    list_filter = ('diploma', 'module', 'sub_module')
    search_fields = ('title',)