# Generated by Django 3.0 on 2021-03-16 19:22

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('onlineTest', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='users',
            name='userID',
            field=models.CharField(max_length=255),
        ),
    ]
