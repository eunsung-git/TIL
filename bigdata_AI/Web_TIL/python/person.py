# class
class Person():
    # class 변수
    name = '사람의 고유한 속성'
    age = '출생 이후부터 삶을 마감할 때까지의 기간'

    def greeting(self):  # method
        print(f'{self.name}이 인사합니다. 안녕하세요!')

    def eating(self):
        print(f'{self.name}은 밥을 먹습니다.')
    
    def aging(self):
        print(f'{self.name}은 {self.age}살이지만, 나이를 먹어가는 중입니다.')

# class - 사람(집단)
# instance - 사람(개인)
# method - 사람(개인)의 행위
# class 변수 - 사람(집단)이 가지고 있는 공통 특성
# instance 변수 - 사람(개인)이 가지는 고유한 특성

eunsung = Person()  # instance

eunsung.name = '은성'   # instance 변수
eunsung.age = '26'
print(eunsung.name)
print(eunsung.age)
print(Person.name)
print(Person.age)
eunsung.eating()

justin = Person()
justin.name = '재석'

# DB - class
# table - class
# column - class 변수
# row - instance
# row값 - instance 변수
# 값들의 조합/가공  - method