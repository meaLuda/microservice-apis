# Generated by Django 4.2.3 on 2023-08-15 06:59

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('college', '0005_remove_submodule_image_coursecontent_diploma_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='coursecontent',
            name='sub_module',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='CourseContent_submodule', to='college.submodule'),
        ),
    ]
