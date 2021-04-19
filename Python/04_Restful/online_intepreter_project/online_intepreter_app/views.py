
from django.views import View
from django.http import JsonResponse, HttpResponse
from django.core.serializers import serialize
from .models import CodeModel
import json
from .mixins import APIDetailMixin, APIUpdateMixin, \
    APIDeleteMixin, APIListMixin, APIRunCodeMixin, \
    APICreateMixin, APIMethodMapMixin, APISingleObjectMixin 
    
class APIView(View):
    def response(self, 
                 queryset=None,
                 fields=None,
                 **kwargs):
                    
        """
        serialize queryset or other python type. return JsonResponse.
        : param queryset: can be None
        :param fields: fields that need to be serialized, can be None
        :param kwargs: other keyword arguments that need to be serialized
        :return: return JsonResponse
        """
        
        if queryset and fields:
            serialized_data = serialize(format='json',
                                        queryset=queryset,
                                        fields=fields)
        elif queryset:
            serialized_data = serialize(format='json',
                                        queryset=queryset)
        else:
            serialized_data = None
        instances = json.loads(serialized_data) if serialized_data else 'No instance'
        data = {'instances':instances}
        data.update(kwargs)
        return JsonResponse(data=data)

#            
# Create your views here.
class APICodeView(APIListMixin,  
                  APIDetailMixin,  
                  APIUpdateMixin,  
                  APIDeleteMixin,  
                  APICreateMixin,  
                  APIMethodMapMixin,  
                  APIView):  
    model = CodeModel  # pass in model

    def list(self):  # pass params to superclass.
        return super(APICodeView, self).list(fields=['name'])
        
class APIRunCodeView(APIRunCodeMixin,
                     APISingleObjectMixin,
                     APIView):
    model = CodeModel  # pass in model

    def get(self, request, *args, **kwargs):
        """
        GET only response to url who can acquire pk
        :param request: 
        :param args: 
        :param kwargs: 
        :return: JsonResponse
        """
        instance = self.get_object()  # acquire object
        code = instance.code  # acquire code
        output = self.run_code(code)  # run code
        return self.response(output=output, status='Successfully Run')  # return response

    def post(self, request, *args, **kwargs):
        """
        POST request can be access randomly, if save == true then would save uploaded code.
        :param request: 
        :param args: location arguments
        :param kwargs: keyword arguments
        :return: JsonResponse
        """
        code = self.request.POST.get('code')  
        save = self.request.GET.get('save') == 'true'  
        name = self.request.POST.get('name')  
        output = self.run_code(code)  
        if save:  
            instance = self.model.objects.create(name=name, code=code)
        return self.response(status='Successfully Run and Save',
                             output=output)  # return response

    def put(self, request, *args, **kwrags):
        """
        PUT request only respond to update operation
        :param request: 
        :param args: location arguments
        :param kwrags: keyword arguments
        :return: JsonResponse
        """
        code = self.request.PUT.get('code')  
        name = self.request.PUT.get('name')  
        save = self.request.GET.get('save') == 'true'  
        output = self.run_code(code)  
        if save:  
            instance = self.get_object()  
            setattr(instance, 'name', name)  # change name
            setattr(instance, 'code', code)  # change code
            instance.save()
        return self.response(status='Successfully Run and Change',
                             output=output)  # return response      
# home view        
def home(request):
    """
    read 'index.html' and return response
    :param request: request object
    :return: HttpResponse
    """
    with open('frontend/index.html', 'rb') as f:
        content = f.read()
    return HttpResponse(content)
    
# read js view
def js(request, filename):
    """
    read js file and return js file response
    :param request: request object
    :param filename: str
    :return: HttpResponse
    """
    with open('frontend/js/{}'.format(filename), 'rb') as f:
        js_content = f.read()
    return HttpResponse(content=js_content,
                        content_type='application/javascript')  # return js response


# read css view
def css(request, filename):
    """
    read css file and return css file response
    :param request: request object
    :param filename: str
    :return: HttpResponse
    """
    with open('frontend/css/{}'.format(filename), 'rb') as f:
        css_content = f.read()
    return HttpResponse(content=css_content,
                        content_type='text/css')  # return css response