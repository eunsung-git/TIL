## 처음부터 설정 시

```bash
1. python 가상환경

$ python -m venv venv

2. python 가상환경 활성화
- Ctrl + Shift + p -> Select Interpreter -> 'venv' 선택
or
$ source venv/Scripts/activate

terminal 종료 후 다시 실행

3. django 설치
$ pip install django==2.2.13

4. django project 생성
$ django-admin startproject crud .


5. django app 생성
$ python manage.py startapp articles


6. django app 등록
- settings.py -> INSTALLED_APPS 에 app 이름 추가

7. 언어/시간 설정
- settings.py -> LANGUAGE_CODE 에 'ko-kr' 입력
- settings.py -> TIME_ZONE 에 'Asia/Seoul' 입력

8. base.html 설정
- settings.py -> TEMPLATES -> DIRS
> os.path.join(BASE_DIR, 'templates')

- 해당 project 폴더 (가장 바깥)/templates 폴더/base.html 생성

9. urls.py 분리
- 해당 app -> urls.py 생성
- 기존 project 폴더 -> urls.py 복사
- admin 관련 코드 지우고 저장

- 기존 project urls.py에서 아래 세 줄 추가
> from django.urls import path, include
> path('app이름/', include('app이름.urls')),

10. database 생성
- 해당 app models.py에서 class 생성
> class Article(models.Model):
    title = models.CharField(max_length=10)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
terminal에서
> python manage.py makemigrations
> python manage.py migrate

11. 관리자 설정
해당 app의 admin.py에서
# from .models import class이름
# admin.site.register(class이름)
> from .models import Article
> class ArticleAdmin(admin.ModelAdmin):
	list_display = ('pk','title','created_at','updated_at')
> admin.site.register(Article, ArticleAdmin)

- terminal에서 관리자 계정 생성
$ python manage.py createsuperuser

12. server 실행
$ python manage.py runserver

13. page 만들기
- 해당 app 안에 templates/articles 폴더 추가
- 해당 app의 urls.py에서 추가 후 path 작성
> from . import views
> app_name = 'app이름'

- views.py에 
> from .models import modelclass이름
- 그리고 함수 추가


- 해당 html 파일 작성
{% extends 'base.html' %}
{% block body %}

{% endblock %}

14. form 생성
- 해당app 안에 forms.py 만든 후
> from django import forms
> class ArticleForm(forms.Form):
    title = forms.CharField()
    content = forms.CharField()

- 해당 app의 views.py에 추가
> from .forms import formclass이름

- 해당 함수 작성



```

--------------------------------------------------------------------------------------



### django 설치 및 기본

```bash
## 1 가상환경 만들기
$ python -m venv venv

## 2 가상환경 활성화
$ source venv/Scripts/activate
or
ctrl + shift + p  -> select interpreter -> 만든 가상환경 'venv' 선택

## 3 django package 설치
$ pip install django==2.2.13

## 4 django project 생성
$ django-admin startproject 프로젝트명 경로
$ django-admin startproject intro .
# . -> 현재 폴더
# .. -> 상위 폴더


## 5 새로운 app 만들기
$ python manage.py startapp app이름
$ python manage.py startapp pages

## 6 app 등록
settings.py -> line 33 INSTALLED_APPS 에 app 이름 추가


## 7 language / time 설정
settings.py -> line 106 LANGUAGE_CODE 에 'ko-kr' 입력
            -> line 1-8 TIME_ZONE 에 'Asia/Seoul' 입력
            
## 8 server 실행
$ python manage.py runserver
```



```python
# pages/templates/  templates 폴더 추가
# html 작성
```



```python
## pages/views.py
# 함수 정의


## intro/urls.py
> from pages import views

line 19 urlpatterns
# path 추가
> path('주소창path', views.함수이름),
```



### urls.py 분리

```python
### 원하는 app 폴더 안에 urls.py 만들기

from django.urls import path
# from 현재 디렉토리 import views
from . import views  

urlpatterns = [
 	사용할 path 복붙
    path('admin/', admin.site.urls), 제외  
]

cf) 기존 urls.py 파일에 추가할 코드
> from django.urls import path, include
# path('app이름/', include('app이름.urls')),
> path('pages/', include('pages.urls')),

cf) 기존 urls.py 파일에서 삭제할 코드
> from pages import views

### 기존에 만들었던 html 파일의 url 주소 변경
ex) <form action="/user_create/" method="POST">
# '/pages' 추가
-> <form action="/pages/user_create/" method="POST">
```



### templates  분리

```python
### app을 여러 개 만들 경우, templates 경로를 app별로 분리
# 각 app의 templates 폴더 안에 app 이름 폴더 생성
ex) pages app -> templates/pages
    tools app -> templates/tools
    
# 새로운 폴더들에 기존 html 파일들 이동

# 각 app의 views.py 에서 url 주소 변경
ex) return render(request, 'index.html', context)
-> return render(request, 'pages/index.html', context)

```



### html에 static  파일 불러오기

```html
### 각 app 폴더 안에 static 폴더 생성
ex) tools app -> tools/static

### static 폴더에 원하는 파일들 추가

### 해당 html 파일 상단에 {% load static %} 추가

### 해당 파일 코드 작성
ex) <link rel="stylesheet" href="{% static 'tools/index.css' %}">
    <img src="{% static 'tools/spongebob.png' %}" alt="">

### bootstrap
## bootstrap 다운받은 후, bootstrap.css 파일을 해당 app의 static 폴더에 복붙

## 다른 파일들과 마찬가지로 불러오기
<link rel="stylesheet" href="{% static 'tools/bootstrap.css' %}">
</head>

-> 이러면 해당 html 파일에만 bootstrap이 적용됨

```



### static option을 모든 파일에 적용하기

```html
cf) bootstrap 모든 파일에 적용하기 (a.k.a html 상속)

1) django project folder에 기본 틀로 사용할 폴더 만들기
ex) django/intro/templates

2) settings.py line 56 TEMPLATES 의 
line 59 'DIRS' 리스트에
os.path.join(BASE_DIR, 'templates') 추가 ->절대경로 생성


3) 기본 틀 html 작성
ex) django/intro/templates/base.html
{% load static %}
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="{% static 'tools/index.css' %}">
    <link rel="stylesheet" href="{% static 'tools/bootstrap.css' %}">
</head>
<body>
    {% block body %}

    {% endblock %}
</body>
</html>

4) 기본 틀 html을 상속받을 html 작성
{% extends 'base.html' %}

{% load static %}

{% block body %}

    <h1>Tools index</h1>
    <img src="{% static 'tools/spongebob.png' %}" alt="">

{% endblock %}

```



### 관리자 기능

```python
$ python manage.py createsuperuser
 이름/password 지정
    
$ python manage.py runser 후 http://127.0.0.1:8000/admin/ 

로그인

### class 등록

## 해당app/해당class/admin.py 에 추가
# from . models import class이름
> from . models import Article

# admin.site.register(class이름)
> admin.site.register(Article)


### admin customizing
> class ArticleAdmin(admin.ModelAdmin):
    list_display = ['id', 'title', 'created_at']

> admin.site.register(Article, ArticleAdmin)

```



### library 설치

```python
$ pip install library이름

# settings.py line 33 INSTALLED_APPS 맨 마지막줄에 library 이름 추가

cf) library이름이 django-extensions 라면,
INSTALLED_APPS 에 추가 시, 'django_extensions'로 입력

```



폴더 생성

폴더 안에서 code 열기

