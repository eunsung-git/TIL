from django.urls import path
from . import views

app_name = 'accounts'

urlpatterns = [
    # 회원가입
    path('signup/', views.signup, name='signup'),
    # 로그인
    path('login/', views.login, name='login'),
    # 로그아웃
    path('logout/', views.logout, name='logout'),
    # 회원 탈퇴
    path('delete/', views.delete, name='delete'),
    # 회원 정보 수정
    path('edit/', views.edit, name='edit'),
    # password 수정
    path('password/', views.password, name='password'),
    # profile - Read
    path('profile/', views.profile_detail, name='profile_detail'),
    # profile - update
    path('profile/edit/', views.profile_edit, name='profile_edit'),
    # 다른 사람 profile
    path('<str:username>/', views.profile, name='profile'),


]