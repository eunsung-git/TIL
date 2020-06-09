from django.urls import path
from . import views

urlpatterns = [
    path('index/', views.index),
    path('hello/<name>/', views.hello),
    
    # path('주소창path', views.함수명),
    path('multiple/<int:num1>/<int:num2>/', views.multiple),
    path('dtl/', views.dtl),

    # ex) 생일page 만들기 "is it your bday?"
    path('bday/', views.bday),
    
    # GET 
    path('throw/', views.throw),
    path('catch/', views.catch),
    # ex) 로또번호 생성기 만들기
    path('lotto/', views.lotto),
    path('generate/', views.generate),

    
    # ex) 회원가입 페이지 만들기
    path('user_new/', views.user_new),
    path('user_create/', views.user_create),

]