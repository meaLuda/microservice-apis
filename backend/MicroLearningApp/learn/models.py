from django.db import models

class Course(models.Model):
    title = models.CharField(max_length=100)
    description = models.TextField()

    def __str__(self):
        return self.title

    class Meta:
        db_table = 'course_table'

class Lesson(models.Model):
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name='lessons')
    title = models.CharField(max_length=100)
    description = models.TextField()

    def __str__(self):
        return self.title

    class Meta:
        db_table = 'lesson_table'

class Content(models.Model):
    lesson = models.ForeignKey(Lesson, on_delete=models.CASCADE, related_name='contents')
    content_type = models.CharField(max_length=50)  # For example, 'text', 'video', etc.
    # add later on image and vedio links.
    content = models.TextField()


    def __str__(self):
        return f"{self.lesson.title} - {self.content_type}"

    class Meta:
        db_table = 'content_table'