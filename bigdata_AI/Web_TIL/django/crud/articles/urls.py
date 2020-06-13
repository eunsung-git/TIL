from django.urls import path
from . import views

urlpatterns = [
    path('index/', views.index), # 게시물 목록
    path('new/', views.new),  # 게시물 작성 폼 (GET)
    path('create/', views.create),  # 게시물 생성 (POST)
    path('detail/<int:pk>/', views.detail), # 게시물 확인
    path('delete/<int:pk>/', views.delete), # 게시물 삭제
    path('edit/<int:pk>/', views.edit), # 게시물 수정 폼 (GET)
    path('update/<int:pk>/', views.update), # 게시물 수정(POST)
]
