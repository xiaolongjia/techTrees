# Generated by Django 3.0 on 2021-02-24 16:12

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='users',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('userID', models.IntegerField()),
                ('userFirstName', models.CharField(max_length=100)),
                ('userLastName', models.CharField(max_length=100)),
                ('email', models.CharField(max_length=100)),
                ('registerDate', models.DateField(null=True)),
            ],
        ),
    ]
