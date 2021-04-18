#!C:\Python38\Python
#coding=utf-8

# rest tutorial I
# https://www.jianshu.com/p/4d532214d6e0 


from django.conf import settings 
from django.http import HttpResponse
from django.conf.urls import url

from django.views.decorators.http import require_POST # 目前的 API 视图只能用于接收 POST 请求
from django.http import JsonResponse # 用于返回 JSON 数据

from django.views.decorators.csrf import csrf_exempt

# https://cloud.tencent.com/developer/article/1445388
import subprocess # 子进程

setting = {
    'DEBUG':True,
    'ROOT_URLCONF':__name__
}

settings.configure(**setting)


# 主视图
def home(request):
    with open('index.html','rb') as f:
        html = f.read()
    return HttpResponse(html)


# 执行客户端代码核心函数
def run_code(code):
    try:
        output = subprocess.check_output(['python','-c',code],
                universal_newlines=True,
                stderr=subprocess.STDOUT,
                timeout=30)
    except subprocess.CalledProcessError as e:
        output = e.output
    except subprocess.TimeoutExpired as e:
        output = '\r\n'.join(['Time Out!!!',e.output])
    print(output)
    return output


# API 请求视图
@csrf_exempt
@require_POST
def api(request):
    code = request.POST.get('code')
    output = run_code(code)
    return JsonResponse(data={'output':output})


# URL 配置
urlpatterns = [
    url('^$', home, name='home'),
    url('^api/$', api, name='api')
]


if __name__ == '__main__':
    import sys
    from django.core.management import execute_from_command_line
    execute_from_command_line(sys.argv)
