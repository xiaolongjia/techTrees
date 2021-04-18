from django.db import models, IntegrityError # module for query failure
import subprocess # for running code
from django.http import Http404 # when query failed return 404


class APIQuerysetMinx(object):
    """
    to acquire queryset. when used, model attr or queryset must be presented.

    :model: 
    :queryset:
    """
    
    model = None
    queryset = None
    
    def get_queryset(self):
        """
        acquire queryset. if model is presented, then return all model query instances by default.
        :return: queryset
        """
        
        # throw error if no args pass in
        assert self.model or self.queryset, 'No queryset found'
        if self.queryset:
            return self.queryset
        else:
            return self.model.objects.all()

class APISingleObjectMixin(APIQuerysetMinx):
    """
    acquire request instances
    
    :lookup_args: list to define lookup arguments. ['pk','id'] by default
    """
    lookup_args = ['pk', 'id']
    
    def get_object(self):
        """
        find instance based on arguments. when acquired value, stop query process. order of args is important.
        :return: single request instannce
        """
        queryset = self.get_queryset() # acquire queryset
        for key in self.lookup_args:
            if self.kwargs.get(key):
                id = self.kwargs[key]
                try:
                    instance = queryset.get(id=id) # acquire current instance
                    return instance 
                except models.ObjectDoesNotExist:
                    raise Http404('NO object found.')
                    
        raise Http404('No object found.')
        
class APIListMixin(APIQuerysetMinx):
    """
    acquire requested list
    """
    def list(self, fields=None):
        """
        return query response
        :param fields: 
        :return: JsonResopnse
        """
        return self.response(
            queryset=self.get_queryset(),
            fields=fields) 
            
class APICreateMixin(APIQuerysetMinx):
    """
    API: create instance operation
    """
    def create(self, create_fields=None):
        """
        use create_fileds iist to get value from POST, and use those value to create instances, return success response if created successfully，otherwise return creation failure.
        :param create_fields: list, fields that wish to create
       . if it is None, then all key fields on POST 
        :return: JsonResponse
        """
        create_values = {}
        if create_fields: 
            for field in create_fields:
                create_values[field]=self.request.POST.get(field)
        else:
            for key in self.request.POST: 
                create_values[key]=self.request.POST.get(key);
        queryset = self.get_queryset() 
        try:
            instance = queryset.create(**create_values)
        except IntegrityError: 
            return self.response(status='Failed to Create.') 
        return self.response(status='Successfully Create.') 
        
class APIDetailMixin(APISingleObjectMixin):
    """
    API read instance operation
    """
    def detail(self, fields=None):
        """
        return requested instance
        :param fields: 
        :return: JsonResponse
        """
        return self.response(
            queryset=[self.get_object()],
            fields=fields)    

class APIUpdateMixin(APISingleObjectMixin):
    """
    API update instance operation
    """
    def update(self, update_fields=None):
        """
        update instance of current request. return success response if update successful, otherwise return failure response.
        if updata_fields is passed, then only update fields in this list, otherwise update all fields.
        :param update_fields: list, fields in the instance that need to be updated
        :return: JsonResponse
        """
        instance = self.get_object() 
        if not update_fields: 
            update_fields=self.request.PUT.keys()
        try: 
            for field in update_fields:
                update_value = self.request.PUT.get(field) # get value from PUT
                setattr(instance, field, update_value) # renew fields
            instance.save() # save updates
        except IntegrityError: # catch error
            return self.response(status='Failed to Update.') 
        return self.response(
            status='Successfully Update')        
class APIDeleteMixin(APISingleObjectMixin):
    """
    API delete instance operations
    """
    # method name cannot be delete since delete is request method name.
    def remove(self):
        """
        remove instance from current request. if delete success then return succeful response.
        :return: JsonResponse
        """
        instance = self.get_object() 
        instance.delete() 
        return self.response(status='Successfully Delete')   
        
class APIRunCodeMixin(object):
    """
    run code operation
    """
    def run_code(self, code):
        """
        run  given code，and return executed result.
        :param code: str, code that need to be run
        :return: str, run result.
        """
        try:
            output = subprocess.check_output(['python', '-c', code], # run code
                                             stderr=subprocess.STDOUT, # redirect stderr output
                                             universal_newlines=True, # return running result as string
                                             timeout=30) # set up timeout limit
        except subprocess.CalledProcessError as e: # catch runtime error
            output = e.output # acquire subprocess error message
        except subprocess.TimeoutExpired as e: # catch timeout error
            output = '\r\n'.join(['Time Out!', e.output]) # acquire subprocess error message and add in timeout error
        return output # return execution results.
        
class APIMethodMapMixin(object):
    """
    map request method to Mixin method
    :method_map: dict,
    if we map GET to list mixin，then dict should be {'get':'list'}
    """
    method_map = {}
    def __init__(self,*args,**kwargs):
        """
        map request method. search for method_map args. expected dict.
        find corresponding value.
        if method_map is passed in，then refer to pass-in method_map
        :param args: position args
        :param kwargs: keyword args
        """
        method_map=kwargs['method_map'] if kwargs.get('method_map',None) \
                                        else self.method_map # acquire method_map param
        for request_method, mapped_method in method_map.items(): 
            mapped_method = getattr(self, mapped_method) # acquire mapped method
            method_proxy = self.view_proxy(mapped_method) # set corresponding view proxy 
            setattr(self, request_method, method_proxy) # map view code to method_proxy
        super(APIMethodMapMixin,self).__init__(*args,**kwargs) # apply instantiation from other subclass

    def view_proxy(self, mapped_method):
        """
        proxy mapped method，and receive other params that passed in。
        :param mapped_method: method that be proxied
        :return: function, view_proxy method
        """
        def view(*args, **kwargs):
        
            """
            proxy method of the view
            :param args: 
            :param kwargs: 
            :return: mnapped_method()
            """
            return mapped_method() 
        return view 



        