# Generated by Django 3.1.6 on 2021-07-30 02:31

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('vacinas', '0003_auto_20210729_2324'),
    ]

    operations = [
        migrations.AlterField(
            model_name='local',
            name='vlr_latitude',
            field=models.CharField(max_length=200),
        ),
        migrations.AlterField(
            model_name='local',
            name='vlr_longitude',
            field=models.CharField(max_length=200),
        ),
    ]