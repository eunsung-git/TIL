## mini_proj_R

#### 연관규칙 Epub

```R
install.packages('arules')
library(arules)

> data(Epub)
> summary(Epub)
#15729 rows (elements/itemsets/transactions) and
# 936 columns (items) and a density of 0.001758755

# 희소행렬 요소 확인
> inspect(Epub[1:3])     
    items     transactionID TimeStamp          
[1] {doc_154} session_4795  2003-01-02 10:59:00
[2] {doc_3d6} session_4797  2003-01-02 21:46:01
[3] {doc_16f} session_479a  2003-01-03 00:50:38

# 아이템별 대여 비율
> itemFrequency(Epub[,1:3])   
     doc_11d      doc_13d      doc_14c 
0.0226333524 0.0009536525 0.0024794965 


# 최소 지지도 설정 후 시각화
> itemFrequencyPlot(Epub,support=0.01,main="item Frequency")   

# 상위 20개 대여 비율 아이템 시각화
> itemFrequencyPlot(Epub,topN=20)  

# 임의로 100개 샘플링 후 시각화 -> 경향성 파악 용도
> image(sample(Epub,100))  


# 지지도 0.001,신뢰도 0.20, 2개 미만 item을 갖는 규칙 제외
> EpubRules<-apriori(Epub,parameter=list(support=0.001,confidence=0.20,minlen=2))  

# 향상도 기준 상위 3개 출력
> inspect(sort(EpubRules,by='lift')[1:3])  
    lhs                  rhs       support    
[1] {doc_6e7,doc_6e8} => {doc_6e9} 0.001080806
[2] {doc_6e7,doc_6e9} => {doc_6e8} 0.001080806
[3] {doc_6e8,doc_6e9} => {doc_6e7} 0.001080806
    confidence lift     count
[1] 0.8095238  454.7500 17   
[2] 0.8500000  417.8016 17   
[3] 0.8947368  402.0947 17 

# 지지도 기준 상위 3개 출력
> inspect(sort(EpubRules,by='support')[1:3])  
    lhs          rhs       support     confidence
[1] {doc_72f} => {doc_813} 0.004068917 0.3516484 
[2] {doc_4ac} => {doc_16e} 0.002797381 0.4313725 
[3] {doc_16e} => {doc_4ac} 0.002797381 0.3464567 
    lift     count
[1] 16.81178 64   
[2] 53.42566 44   
[3] 53.42566 44  


# item 중 'doc_72f','doc_4ac'가 포함된 모든 연관규칙
> doc_rules<-subset(EpubRules,items %in% c('doc_72f','doc_4ac'))   
> inspect(doc_rules)
  lhs          rhs       support     confidence
[1] {doc_4bf} => {doc_4ac} 0.001080806 0.5000000 
[2] {doc_4ac} => {doc_16e} 0.002797381 0.4313725 
[3] {doc_16e} => {doc_4ac} 0.002797381 0.3464567 
[4] {doc_72f} => {doc_813} 0.004068917 0.3516484 
    lift     count
[1] 77.10294 17   
[2] 53.42566 44   
[3] 53.42566 44   
[4] 16.81178 64 


# lhs가 'doc_72f'인 모든 연관규칙
> doc_rules_lhs<-subset(EpubRules,lhs %in% 'doc_72f')  
> inspect(doc_rules_lhs)
 lhs          rhs       support     confidence
[1] {doc_72f} => {doc_813} 0.004068917 0.3516484 
    lift     count
[1] 16.81178 64  

# items 이름에 부분적으로 '60e'가 들어가는 items의 연관규칙
# %pin% - partial matching
> doc_rules_pin<-subset(EpubRules,items %pin% c('60e'))
> inspect(doc_rules_pin)
    lhs          rhs       support     confidence
[1] {doc_60e} => {doc_6bf} 0.002670227 0.2745098 
[2] {doc_6bf} => {doc_60e} 0.002670227 0.2048780 
    lift     count
[1] 21.06227 42   
[2] 21.06227 42  


# lhs가 정확히 'doc_6e8','doc_6e9'인 연관규칙
# %ain% - select only itemsets matching all given item
> doc_rules_ain<-subset(EpubRules,lhs %ain% c('doc_6e8','doc_6e9'))
> inspect(doc_rules_ain)
    lhs                  rhs       support    
[1] {doc_6e8,doc_6e9} => {doc_6e7} 0.001080806
    confidence lift     count
[1] 0.8947368  402.0947 17 


# items 이름에 부분적으로 '60e'가 들어가고, 신뢰도 0.25 초과 연관규칙
> doc_rules_pin_conf<-subset(EpubRules,items %pin% c('60e') & confidence>0.25)
> inspect(doc_rules_pin_conf)
    lhs          rhs       support     confidence
[1] {doc_60e} => {doc_6bf} 0.002670227 0.2745098 
    lift     count
[1] 21.06227 42  

# 연관규칙 파일을 df로 변경
> epdf<-as(EpubRules,'data.frame')  

# 파일 저장
> write(EpubRules,file='EpubRules.csv',sep=',')  


## 연관규칙 시각화
install.packages('arulesViz')
library(arulesViz)
> plot(EpubRules)

> plot(sort(EpubRules,by='support')[1:20],method='grouped')

> plot(EpubRules,method='graph',control=list(type='items'))

# 원의 크기 ~ support / 원의 색깔 ~ lift / 화살표:lhs->rhs
plot(EpubRules,method='graph',
     control=list(type='items'),
     vertex.label.cex=0.7,   # 점 옵션 설정
     edge.arrow.size=0.3,    # 선 옵션 설정
     edge.arrow.width=2)

```

