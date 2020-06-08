install.packages('arules')
library(arules)

groceries<-read.transactions('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/groceries.csv',sep=',')
str(groceries)
summary(groceries)

inspect(groceries[1:3])

itemFrequency(groceries[,1:3])

itemFrequencyPlot(groceries,support=0.1)
itemFrequencyPlot(groceries,topN=20)
image(groceries[1:5])
image(sample(groceries,100))

groceryRules<-apriori(groceries,
        parameter=list(support=0.006,confidence=0.25,minlen=2))
summary(groceryRules)

inspect(groceryRules[1:3])

inspect(sort(groceryRules,by='lift')[1:3])


berryRules<-subset(groceryRules,items %in% 'berries')
inspect(berryRules)

write(groceryRules,file='groceryRules.csv',sep=',')

class(groceryRules)

grdf<-as(groceryRules,'data.frame')
grdf

help(Epub)
data(Epub)
summary(Epub)
class(Epub)

inspect(Epub[1:3])
inspect(Epub[1:10])
itemFrequency(Epub[,1:3])
itemFrequencyPlot(Epub,support=0.01)
itemFrequencyPlot(Epub,topN=20)

image(sample(Epub,100))

EpubRules<-apriori(Epub,parameter=list(support=0.001,confidence=0.20,minlen=2))

inspect(sort(EpubRules,by='lift')[1:3])
inspect(sort(EpubRules,by='support')[1:3])
doc_rules<-subset(EpubRules,items %in% c('doc_72f','doc_4ac'))
inspect(doc_rules)

doc_rules_lhs<-subset(EpubRules,lhs %in% c('doc_72f','doc_4ac'))
inspect(doc_rules_lhs)

doc_rules_lhs<-subset(EpubRules,lhs %in% 'doc_72f')
inspect(doc_rules_lhs)

doc_rules_pin<-subset(EpubRules,items %pin% c('60e'))
inspect(doc_rules_pin)

doc_rules_ain<-subset(EpubRules,lhs %ain% c('doc_6e8','doc_6e9'))
inspect(doc_rules_ain)

doc_rules_pin_conf<-subset(EpubRules,items %pin% c('60e') & confidence>0.25)
inspect(doc_rules_pin_conf)

epdf<-as(EpubRules,'data.frame') 
write(EpubRules,file='EpubRules.csv',sep=',')  


help(Epub)
data(Epub)
summary(Epub)
inspect(Epub[1:10])
itemFrequency(Epub[,1:10])
itemFrequencyPlot(Epub,support=0.01)
itemFrequencyPlot(Epub,support=0.01,main="item Frequency")   
itemFrequencyPlot(Epub,topN=20,main="item Frequency")
image(sample(Epub,100))
apriori(Epub,parameter=list(support=0.001, confidence=0.20,minlen=2))
summary(EpubRules)
inspect(sort(EpubRules,by='lift')[1:20])

doc_rules<-subset(EpubRules,items %in% c('doc_72f','doc_4ac'))   
inspect(doc_rules)

doc_rules_lhs<-subset(EpubRules,lhs %in% c('doc_72f','doc_4ac'))  
inspect(doc_rules_lhs)



doc_rules_pin<-subset(EpubRules,items %pin% c('60e'))
inspect(doc_rules_pin)

doc_rules_ain<-subset(EpubRules,lhs %ain% c('doc_6e8','doc_6e9'))
inspect(doc_rules_ain)


inspect(doc_rules_pin_conf)


install.packages('arulesViz')
library(arulesViz)

plot(EpubRules)

plot(sort(EpubRules,by='support')[1:20],method='grouped')

plot(EpubRules,method='graph',
     control=list(type='items'),
     vertex.label.cex=0.7,
     edge.arrow.size=0.3,
     edge.arrow.width=2)
# 원의 크기 ~ support / 원의 색깔 ~ lift / 화살표:lhs->rhs
