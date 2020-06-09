### django 설치 및 기본

```bash
## git bash  
# 가상환경 만들기
$ python -m venv venv

# 가상환경 활성화
$ source venv/Scripts/activate

# django package 설치
$ pip install django==2.2.13

# django project 생성
$ django-admin startproject 프로젝트명 경로
$ django-admin startproject intro .
# . -> 현재 폴더
# .. -> 상위 폴더
.
.
.
# vs code 실행
$ code .

# interpreter 설정
ctrl + shift + p  -> 만든 가상환경 선택

# server 실행
$ python manage.py runserver

# 새로운 app 만들기
$ python manage.py startapp app이름
$ python manage.py startapp pages

# app 등록
settings.py -> line 33 INSTALLED_APPS 에 추가

# language 설정
settings.py -> line 107 LANGUAGE_CODE 에 입력
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


