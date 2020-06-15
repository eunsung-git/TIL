from django.urls import path
from . import views

app_name = 'articles'

urlpatterns = [
    # 1. GET /articles/
    path('', views.index, name='index'), # 게시물 목록
    
    # 2. GET /articles/new/
    path('new/', views.new, name='new'),  # 게시물 작성 폼 (GET)
    
    # 3. POST /articles/new/
    # path('create/', views.create, name='create'),  # 게시물 생성 (POST)
    
    # 4. GET /articles/detail/1/
    path('<int:pk>/', views.detail, name='detail'), # 게시물 확인
    
    # 5. POST /articles/1/delete/
    path('<int:pk>/delete/', views.delete, name='delete'), # 게시물 삭제
    
    # 6. GET /articles/1/edit/
    path('<int:pk>/edit/', views.edit, name='edit'), # 게시물 수정 폼 (GET)
    
    # 7. POST /articles/edit/
    # path('update/<int:pk>/', views.update, name='update'), # 게시물 수정(POST)
]
