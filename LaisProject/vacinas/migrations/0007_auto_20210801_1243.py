# Generated by Django 3.1.6 on 2021-08-01 15:43

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('vacinas', '0006_auto_20210801_1241'),
    ]

    operations = [
        migrations.AlterField(
            model_name='scheduling',
            name='status',
            field=models.IntegerField(blank=True, choices=[(1, 'Agendado'), (2, 'Cancelado'), (3, 'Vacinado')], default=1),
        ),
    ]