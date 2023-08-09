# Generated by Django 4.2.3 on 2023-08-03 10:07

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Category',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('banner_img_link', models.CharField(max_length=500)),
            ],
            options={
                'db_table': 'radiostation_category_table',
            },
        ),
        migrations.CreateModel(
            name='RadioStation',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=200)),
                ('about', models.TextField(null=True)),
                ('img_link', models.CharField(max_length=300)),
                ('stream_url', models.CharField(max_length=500)),
                ('category', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='radiostation_app.category')),
            ],
            options={
                'db_table': 'radio_station_table',
            },
        ),
    ]
