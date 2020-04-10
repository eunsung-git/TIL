```python
# image data 불러오기
from sklearn.datasets import fetch_olivetti_faces
faces=fetch_olivetti_faces()

# image 갯수 확인
faces.data.shape
> (400, 4096)
faces.images.shape
> (400, 64, 64)
len(faces.data)
> 400
range(len(faces.data))
> range(0, 400)

# 뽑고자 하는 이미지 번호 random 추출
klist=np.random.choice(range(len(faces.data)),10)

# 2*5로 image 출력
fig=plt.figure(figsize=(12,5))
for i in range(2):
    for j in range(5):
        k=klist[i*5+j]
        ax=fig.add_subplot(2,5,i*5+j+1)
        ax.imshow(faces.images[k],cmap=plt.cm.bone)
        plt.title(faces.target[k])
        ax.yaxis.set_ticks([])
        ax.xaxis.set_ticks([])
plt.show()      

```



#### SVM을 이용한 image 예측

```python
xtrain,xtest,ytrain,ytest=train_test_split(faces.data, faces.target, test_size=0.3, random_state=0)

model=SVC(kernel='linear').fit(xtrain, ytrain)

klist=np.random.choice(range(len(ytest)),10)
fig=plt.figure(figsize=(12,5))
for i in range(2):
    for j in range(5):
        k=klist[i*5+j]
        ax=fig.add_subplot(2,5,i*5+j+1)
        ax.imshow(xtest[k:(k+1),:].reshape(64,64),cmap=plt.cm.bone)
        plt.title('%d -> %d' % (ytest[k],model.predict(xtest[k:(k+1),:])))
        ax.yaxis.set_ticks([])
        ax.xaxis.set_ticks([])
plt.show()

```

---------------------------------------------------------------------------------------------------------


#### model 평가

> ###### confusion matrix (실제, 예측)  
>
> row(실제) x col(예측) / 실제와 예측이 일치하는 갯수
>
> ```python
> xtrue=[1,0,1,1,0,1]
> xpred=[0,0,1,1,0,1]
> confusion_matrix(xtrue, xpred)
> > array([[2, 0],   2(1*1) : 예측 0, 정답 0  -> 2건
> >       [1, 3]])   0(1*2) : 예측 1, 정답 0  -> 0건
>                    1(2*1) : 예측 0, 정답 1  -> 1건
>                    3(2*2) : 예측 1, 정답 1  -> 3건
> ```
>
> 
>
> ###### 이진 분류 
>
> |             | predict 양성         | predict 음성         |
> | ----------- | -------------------- | -------------------- |
> | actual 양성 | True Positive  (TP)  | False Negative  (FN) |
> | actual 음성 | False Positive  (FP) | True Negative  (TN)  |
>
> -> 뒤부터 해석 : TP -> 양성(P)로 예측, 실제 양성(T)
>
> ​                          : FN -> 음성(N)으로 예측, 실제 양성(F)
>
> 
>
> ###### 평가점수
>
> confusion-matrix로부터 평가점수 계산 -> 정확도, 정밀도, 재현율 확인
>
> | 정확도(Accuracy)    | 전체 샘플 중, 맞게 예측한 샘플 비율              | TP+TN  /  TP+TN+FP+FN                    | ↑    |
> | ------------------- | ------------------------------------------------ | ---------------------------------------- | ---- |
> | 정밀도(Precision)   | 양성이라고 예측한 샘플 중, 실제 양성인 샘플 비율 | TP  /  TP+FP                             | ↑    |
> | 재현율(Recall)      | 실제 양성 샘플 중, 양성이라고 예측한 샘플 비율   | TP  /  TP+FN                             | ↑    |
> | 특이도(Specificity) | 실제 음성 샘플 중, 양성이라고 예측한 샘플 비율   | TN  /  TN+FP            (= 1 - 위양성율) | ↑    |
> | 위양성율(Fallout)   | 실제 음성 샘플 중, 음성이라고 예측한 샘플 비율   | FP  /  TN+FP            (= 1 - 특이도)   | ↓    |
> | F1 Score            | 조화평균값                                       | 2PR  /  P+R                              | ↑    |
>
> ```python
> xtrue=[0,0,0,1,1,0,0]
> xpred=[0,0,0,0,1,1,1]
> print(classification_report(xtrue,xpred))
> >  precision    recall  f1-score   support
> 
>            0       0.75      0.60      0.67         5
>            1       0.33      0.50      0.40         2
> 
>     accuracy                           0.57         7
>    macro avg       0.54      0.55      0.53         7
> weighted avg       0.63      0.57      0.59         7
> 
> -> 0 으로 예측한 데이터의 75%가 실제 0
> -> 1 로 예측한 데이터의 33%가 실제 1
> -> 실제 0인 데이터의 60%가 0으로 예측
> -> 실제 1인 데이터의 50%가 1로 예측
> ```
>
> 



