### database 설계

```bash
## 해당 app/models.py 에 table 작성

## 작성한 모델의 migration(설계도) 파일 생성
$ python manage.py makemigrations

## DB에 적용 -> table 생성
$ python manage.py migrate

## table 변경 사항 발생 시,
# 1) 해당 app/models.py에 변경 사항 작성
# 2) 
$ python manage.py makemigrations
$ python manage.py migrate
# 3) 해당 app/migrations 에 설계도가 추가되었는지 확인

```



### Django Shell

```python
--- terminal에서 작성 -------

# from 해당app이름.models import table이름
from articles.models import Article


## Create   <-> CREATE
# [1]
>>> article = Article()  
>>> article.title = 'First'
>>> article.content = 'Wow!'
>>> article.save()

# [2]
>>> article2 = Article(title='Second', content='two')
>>> article2.save()

# [3]
>>> article3 = Article.objects.create(title='Third', content='three')


## Read
# [1] all()  <->  SELECT *
>>> Article.objects.all()
<QuerySet [<Article: Article object (1)>, <Article: Article object (2)>, <Article: Article object (3)>]>

# cf) 조회 결과 변경
# models.py 에 __str__ 함수 작성
def __str__(self):
        return f'{self.id}번 글 - {self.title} : {self.content}'
# shell 종료 후 다시 실행
>>> exit()
$ python manage.py shell
>>> from articles.models import Article
>>> Article.objects.all()
<QuerySet [<Article: 1번 글 - First : Wow!>, <Article: 2번 글 - Second : two>, <Article: 3번 글 - Third : three>]>

# [2] filter()  <-> WHERE
>>> Article.objects.filter(title='First') 
<QuerySet [<Article: 1번 글 - First : Wow!>, <Article: 4번 글 - First : Ah!>]>

# [3] get()  -> 1개만 return & unique value
>>> Article.objects.get(id=1)   
<Article: 1번 글 - First : Wow!>
>>> Article.objects.get(pk=2)
<Article: 2번 글 - Second : two>
        
>>> Article.objects.get(title='First') (복수값이므로 x)
>>> Article.objects.get(pk=10) (존재하지 않으므로 x)

# [4] QuerySet (유사 리스트)
>>> articles = Article.objects.all()
>>> articles[0]
>>> articles.first()
>>> articles[-1]
>>> articles.last()
>>> articles[1:3]

# [5] order_by()
>>> Article.objects.order_by('created_at')  # 오름차순
<QuerySet [<Article: 1번 글 - First : Wow!>, <Article: 2번 글 - Second : two>, <Article: 3번 글 - Third : three>, <Article: 4번 글 - First : Ah!>]>
>>> Article.objects.order_by('-created_at')  # 내림차순(역순)
<QuerySet [<Article: 4번 글 - First : Ah!>, <Article: 3번 글 - Third : three>, <Article: 2번 글 - Second : two>, <Article: 1번 글 - First : Wow!>]>
        

## type
>>> article = Article.objects.get(id=1)  (instance)
>>> type(article)
<class 'articles.models.Article'>

>>> articles = Article.objects.all() (list)
>>> type(articles)
<class 'django.db.models.query.QuerySet'>


## Update
# 1) data 가져오기
>>> article = Article.objects.get(pk=1)
# 2) instance 수정
>>> article.content = 'Bye'
# 3) instance 저장
>>> article.save()

>>> Article.objects.get(pk=1) 
<Article: 1번 글 - First : Bye>
        
        
## Delete
# 1) data 가져오기
article = Article.objects.get(pk=1)
# 2) instance 삭제
article.delete()

>>> Article.objects.all()     
<QuerySet [<Article: 2번 글 - Second : two>, <Article: 3번 글 - Third : three>, <Article: 4번 글 - First : Ah!>]>    

# DB에서는 삭제되었지만 python shell에는 남아있음
# 삭제된 data를 변경하고 싶다면
>>> article.save()
>>> article 
<Article: 5번 글 - First : Bye> # 새로운 번호를 부여받음
        

```

