from django.db import models

# Create your models here.
class Article(models.Model):
    # id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=100)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f'{self.id}번 글 - {self.title} : {self.content}'


    # 1. models.py 작성 및 변경(생성 및 수정)
    # 2. $ python manage.py makemigrations -> migration(설계도) 파일 생성
    # 3. $ python manage.py migrate -> 실제 DB에 적용 (table 생성)

    ## Django Shell
    # from articles.models import Article

    # 1. Create
    # 1-1. 
    # article = Article()
    # article.title = 'First'
    # article.content = 'Wow!'

    # 1-2. 
    # article2 = Article(title='Second', content='two')
    # article2.save()

    # 1-3. 
    # article3 = Article.objects.create(title='Third', content='three')

    # 2. Read
    # 2-1. all()
    # Article.objects.all()

    # 2-2. filter()
    # Article.objects.filter(title='First') 

    # 2-3. get() 
    # Article.objects.get(id=1)
    # Article.objects.get(pk=1)
    # Article.objects.get(title='First') (x)
    # Article.objects.get(pk=10) (x)

    # 2-4. QuerySet (유사 리스트)
    # articles = Article.objects.all()
    # articles[0]
    # articles.first()
    # articles[-1]
    # articles.last()
    # articles[1:3]

    # 2-5. order_by()
    # Article.objects.order_by('created_at')  오름차순
    # Article.objects.order_by('-created_at')  내림차순(역순)

    # 3. Update
    # 1) data 가져오기
    # article = Article.objects.get(pk=1)
    # 2) instance 수정
    # article.content = 'Bye'
    # 3) instance 저장
    # article.save()

    # 4. Delete
    # 1) data 가져오기
    # article = Article.objects.get(pk=1)
    # 2) instance 삭제
    # article.delete()
