from django.urls import path
from . import views

app_name = 'pages'

urlpatterns = [
    # mainpage
    path('', views.main, name='main'), 

    # 추천 결과
    path('recom/', views.recom, name='recom'),

    # 회원가입 폼
    path('signup/', views.signup, name='signup'),

    # 로그인 후 옵션 선택
    path('login_sel/', views.login_sel, name='login_sel'),

    # 비회원 옵션 선택
    path('non_sel/', views.non_sel, name='non_sel'),

    # 회원가입 완료 -> 로그인하러 가기
    path('signup_comp/', views.signup_comp, name='signup_comp'),

    # 팝업창
    path('recom/tips/', views.tips, name='tips'),

]