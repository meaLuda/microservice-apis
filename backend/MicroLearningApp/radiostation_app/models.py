from django.db import models

# Create your models here.

class RadioStationCategory(models.Model):
    name = models.CharField(max_length=100)
    banner_img_link = models.CharField(max_length=500)

    def __str__(self):
        return self.name

    class Meta:
        db_table = 'radiostation_category_table'  # Custom table name for Category model

class RadioStation(models.Model):
    name = models.CharField(max_length=200)
    about = models.TextField(null=True)
    img_link = models.CharField(max_length=300)
    stream_url = models.CharField(max_length=500)
    category = models.ForeignKey(RadioStationCategory, on_delete=models.CASCADE, null=True)  # Making category field nullable

    def __str__(self):
        return self.name

    class Meta:
        db_table = 'radio_station_table'  # Custom table name for RadioStation model