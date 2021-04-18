from django import forms

from django.core.exceptions import ValidationError
from django.utils.translation import ugettext_lazy as _
import datetime
import logging

logger = logging.getLogger(__name__)


class SignupForm(forms.Form):
    userID = forms.CharField(label="User ID")
    password = forms.CharField(label="Enter Password")
    rePassword = forms.CharField(label="Re-enter Password")
    firstName = forms.CharField(label="First Name")
    lastName = forms.CharField(label="Last Name")
    email = forms.CharField(label="Email Address")

    def clean_rePassword(self):
        passwd = self.cleaned_data['password']
        rePassword = self.cleaned_data['rePassword']
        if rePassword != passwd:
            raise ValidationError(_('Inconsistent password'))
        return rePassword


class AddForm(forms.Form):
    a = forms.IntegerField(label="User ID")
    b = forms.IntegerField(label="User Age")
    renewal_date = forms.DateField(label="Renewal Date", help_text="Enter a date between now and 4 weeks (default 3).")

    def clean_renewal_date(self):
        data = self.cleaned_data['renewal_date']

        # Check date is not in past.
        if data < datetime.date.today():
            raise ValidationError(_('Invalid date - renewal in past'))

        # Check date is in range librarian allowed to change (+4 weeks).
        if data > datetime.date.today() + datetime.timedelta(weeks=4):
            raise ValidationError(_('Invalid date - renewal more than 4 weeks ahead'))

        # Remember to always return the cleaned data.
        return data
