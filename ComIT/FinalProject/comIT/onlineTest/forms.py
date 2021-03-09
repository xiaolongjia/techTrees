from django import forms


class AddForm(forms.Form):
    a = forms.IntegerField()
    b = forms.IntegerField()
    renewal_date = forms.DateField(label="Renewal Date")
