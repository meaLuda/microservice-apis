from django.db import models

# Create your models here.
from django.db import models

# Create your models here.
class Depertment(models.Model):
    title = models.CharField(max_length=100)

    def __str__(self):
        return self.title

    class Meta:
        db_table = 'CollegeDepertment'
    
class Diploma(models.Model):
    depertment = models.ForeignKey(Depertment, on_delete=models.CASCADE)
    title = models.CharField(max_length=100)

    def __str__(self):
        return self.title
    
    class Meta:
        db_table = 'CollegeDiploma'

class Module(models.Model):
    diploma = models.ForeignKey(Diploma, on_delete=models.CASCADE)
    title = models.CharField(max_length=100)
   
    def __str__(self):
        return self.title
    
    class Meta:
        db_table = 'CollegeDiploma_Module'


class Submodule(models.Model):
    diploma = models.ForeignKey(Diploma, on_delete=models.DO_NOTHING)
    module = models.ForeignKey(Module, on_delete=models.CASCADE)
    title = models.CharField(max_length=100)
    # image = models.ImageField(upload_to='submodule_banner_image/', blank=True, null=True)
   
    def __str__(self):
        return self.title
    
    class Meta:
        db_table = 'CollegeDiploma_Submodule'

class CourseContent(models.Model):
    diploma = models.ForeignKey(Diploma, on_delete=models.DO_NOTHING,related_name='CourseContent_diploma')
    module = models.ForeignKey(Module, on_delete=models.DO_NOTHING,related_name='CourseContent_module')
    sub_module = models.ForeignKey(Submodule, on_delete=models.CASCADE,related_name='CourseContent_submodule')
    title = models.CharField(max_length=100)
    image = models.ImageField(upload_to='submodule_content_images/', blank=True, null=True)
    exam_pdf = models.FileField(upload_to='submodule_content_exams/', blank=True, null=True)

    def __str__(self):
        return self.title
    
    class Meta:
        db_table = 'CollegeDiploma_SubmoduleContent'