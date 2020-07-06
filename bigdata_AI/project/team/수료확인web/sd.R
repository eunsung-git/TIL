getwd()
wt<-read.csv("C:/Users/ESLAB229/Desktop/출석율.csv")

#길상희
x<-table(wt$길상희)
prop.table(table(wt$길상희))*100
round(prop.table(table(wt$길상희))*100, digits=1)
sort(round(prop.table(table(wt$길상희))*100, digits=1), decreasing=T)
pie(table(wt$길상희),col=rainbow(4),radius=1)
pct<-round(prop.table(table(wt$길상희))*100, digits=1)
lab1<-c('결석','지각','출석')
lab2<-paste(lab1,"\n",pct,"%")
pie(table(wt$길상희),radius=1,col=rainbow(3),label=lab2)

#김예준
x<-table(wt$김예준)
prop.table(table(wt$김예준))*100
round(prop.table(table(wt$김예준))*100, digits=1)
sort(round(prop.table(table(wt$김예준))*100, digits=1), decreasing=T)
pie(table(wt$김예준),col=rainbow(4),radius=1)
pct<-round(prop.table(table(wt$김예준))*100, digits=1)
lab1<-c('결석','지각','출석')
lab2<-paste(lab1,"\n",pct,"%")
pie(table(wt$김예준),radius=1,col=rainbow(4),label=lab2)

#김준호
x<-table(wt$김준호)
prop.table(table(wt$김준호))*100
round(prop.table(table(wt$김준호))*100, digits=1)
sort(round(prop.table(table(wt$김준호))*100, digits=1), decreasing=T)
pie(table(wt$김준호),col=rainbow(4),radius=1)
pct<-round(prop.table(table(wt$김준호))*100, digits=1)
lab1<-c('결석','지각','출석')
lab2<-paste(lab1,"\n",pct,"%")
pie(table(wt$김준호),radius=1,col=rainbow(3),label=lab2)

#김효훈
x<-table(wt$김효훈)
prop.table(table(wt$김효훈))*100
round(prop.table(table(wt$김효훈))*100, digits=1)
sort(round(prop.table(table(wt$김효훈))*100, digits=1), decreasing=T)
pie(table(wt$김효훈),col=rainbow(4),radius=1)
pct<-round(prop.table(table(wt$김효훈))*100, digits=1)
lab1<-c('출석','지각','결석')
lab2<-paste(lab1,"\n",pct,"%")
pie(table(wt$김효훈),radius=1,col='green',label=lab2)

#박소정
x<-table(wt$박소정)
prop.table(table(wt$박소정))*100
round(prop.table(table(wt$박소정))*100, digits=1)
sort(round(prop.table(table(wt$박소정))*100, digits=1), decreasing=T)
pie(table(wt$박소정),col=rainbow(4),radius=1)
pct<-round(prop.table(table(wt$박소정))*100, digits=1)
lab1<-c('결석','지각','출석')
lab2<-paste(lab1,"\n",pct,"%")
pie(table(wt$박소정),radius=1,col=rainbow(3),label=lab2)

#배형미
x<-table(wt$배형미)
prop.table(table(wt$배형미))*100
round(prop.table(table(wt$배형미))*100, digits=1)
sort(round(prop.table(table(wt$배형미))*100, digits=1), decreasing=T)
pie(table(wt$배형미),col=rainbow(4),radius=1)
pct<-round(prop.table(table(wt$배형미))*100, digits=1)
lab1<-c('결석','지각','출석')
lab2<-paste(lab1,"\n",pct,"%")
pie(table(wt$배형미),radius=1,col=rainbow(3),label=lab2)

#양용주
x<-table(wt$양용주)
prop.table(table(wt$양용주))*100
round(prop.table(table(wt$양용주))*100, digits=1)
sort(round(prop.table(table(wt$양용주))*100, digits=1), decreasing=T)
pie(table(wt$양용주),col=rainbow(4),radius=1)
pct<-round(prop.table(table(wt$양용주))*100, digits=1)
lab1<-c('결석','지각','출석')
lab2<-paste(lab1,"\n",pct,"%")
pie(table(wt$양용주),radius=1,col=rainbow(3),label=lab2)

#유지은
x<-table(wt$유지은)
prop.table(table(wt$유지은))*100
round(prop.table(table(wt$유지은))*100, digits=1)
sort(round(prop.table(table(wt$유지은))*100, digits=1), decreasing=T)
pie(table(wt$유지은),col=rainbow(4),radius=1)
pct<-round(prop.table(table(wt$유지은))*100, digits=1)
lab1<-c('결석','지각','출석')
lab2<-paste(lab1,"\n",pct,"%")
pie(table(wt$유지은),radius=1,col=rainbow(3),label=lab2)

#윤수연
x<-table(wt$윤수연)
prop.table(table(wt$윤수연))*100
round(prop.table(table(wt$윤수연))*100, digits=1)
sort(round(prop.table(table(wt$윤수연))*100, digits=1), decreasing=T)
pie(table(wt$윤수연),col=rainbow(4),radius=1)
pct<-round(prop.table(table(wt$윤수연))*100, digits=1)
lab1<-c('결석','지각','출석')
lab2<-paste(lab1,"\n",pct,"%")
pie(table(wt$윤수연),radius=1,col=rainbow(3),label=lab2)

#이성천
x<-table(wt$이성천)
prop.table(table(wt$이성천))*100
round(prop.table(table(wt$이성천))*100, digits=1)
sort(round(prop.table(table(wt$이성천))*100, digits=1), decreasing=T)
pie(table(wt$이성천),col=rainbow(4),radius=1)
pct<-round(prop.table(table(wt$이성천))*100, digits=1)
lab1<-c('출석','지각','결석')
lab2<-paste(lab1,"\n",pct,"%")
pie(table(wt$이성천),radius=1,col='green',label=lab2)

#김건우
x<-table(wt$김건우)
prop.table(table(wt$김건우))*100
round(prop.table(table(wt$김건우))*100, digits=1)
sort(round(prop.table(table(wt$김건우))*100, digits=1), decreasing=T)
pie(table(wt$김건우),col=rainbow(4),radius=1)
pct<-round(prop.table(table(wt$김건우))*100, digits=1)
lab1<-c('결석','출석')
lab2<-paste(lab1,"\n",pct,"%")
pie(table(wt$김건우),radius=1,col=rainbow(3),label=lab2)

#이윤진
x<-table(wt$이윤진)
prop.table(table(wt$이윤진))*100
round(prop.table(table(wt$이윤진))*100, digits=1)
sort(round(prop.table(table(wt$이윤진))*100, digits=1), decreasing=T)
pie(table(wt$이윤진),col=rainbow(4),radius=1)
pct<-round(prop.table(table(wt$이윤진))*100, digits=1)
lab1<-c('결석','지각','출석')
lab2<-paste(lab1,"\n",pct,"%")
pie(table(wt$이윤진),radius=1,col=rainbow(3),label=lab2)

#이은성
x<-table(wt$이은성)
prop.table(table(wt$이은성))*100
round(prop.table(table(wt$이은성))*100, digits=1)
sort(round(prop.table(table(wt$이은성))*100, digits=1), decreasing=T)
pie(table(wt$이은성),col=rainbow(4),radius=1)
pct<-round(prop.table(table(wt$이은성))*100, digits=1)
lab1<-c('결석','지각','출석')
lab2<-paste(lab1,"\n",pct,"%")
pie(table(wt$이은성),radius=1,col=rainbow(3),label=lab2)

#이재현
x<-table(wt$이재현)
prop.table(table(wt$이재현))*100
round(prop.table(table(wt$이재현))*100, digits=1)
sort(round(prop.table(table(wt$이재현))*100, digits=1), decreasing=T)
pie(table(wt$이재현),col=rainbow(4),radius=1)
pct<-round(prop.table(table(wt$이재현))*100, digits=1)
lab1<-c('결석','지각','출석')
lab2<-paste(lab1,"\n",pct,"%")
pie(table(wt$이재현),radius=1,col=rainbow(3),label=lab2)

#한영규
x<-table(wt$한영규)
prop.table(table(wt$한영규))*100
round(prop.table(table(wt$한영규))*100, digits=1)
sort(round(prop.table(table(wt$한영규))*100, digits=1), decreasing=T)
pie(table(wt$한영규),col=rainbow(4),radius=1)
pct<-round(prop.table(table(wt$한영규))*100, digits=1)
lab1<-c('결석','출석')
lab2<-paste(lab1,"\n",pct,"%")
pie(table(wt$한영규),radius=1,col=rainbow(3),label=lab2)

#신재민
x<-table(wt$신재민)
prop.table(table(wt$신재민))*100
round(prop.table(table(wt$신재민))*100, digits=1)
sort(round(prop.table(table(wt$신재민))*100, digits=1), decreasing=T)
pie(table(wt$신재민),col=rainbow(4),radius=1)
pct<-round(prop.table(table(wt$신재민))*100, digits=1)
lab1<-c('결석','지각','출석')
lab2<-paste(lab1,"\n",pct,"%")
pie(table(wt$신재민),radius=1,col=rainbow(3),label=lab2)

#이의성
x<-table(wt$이의성)
prop.table(table(wt$이의성))*100
round(prop.table(table(wt$이의성))*100, digits=1)
sort(round(prop.table(table(wt$이의성))*100, digits=1), decreasing=T)
pie(table(wt$이의성),col=rainbow(4),radius=1)
pct<-round(prop.table(table(wt$이의성))*100, digits=1)
lab1<-c('결석','출석')
lab2<-paste(lab1,"\n",pct,"%")
pie(table(wt$이의성),radius=1,col=rainbow(3),label=lab2)

#오근우
x<-table(wt$오근우)
prop.table(table(wt$오근우))*100
round(prop.table(table(wt$오근우))*100, digits=1)
sort(round(prop.table(table(wt$오근우))*100, digits=1), decreasing=T)
pie(table(wt$오근우),col=rainbow(4),radius=1)
pct<-round(prop.table(table(wt$오근우))*100, digits=1)
lab1<-c('결석','출석')
lab2<-paste(lab1,"\n",pct,"%")
pie(table(wt$오근우),radius=1,col=rainbow(3),label=lab2)

#윤정우
x<-table(wt$윤정우)
prop.table(table(wt$윤정우))*100
round(prop.table(table(wt$윤정우))*100, digits=1)
sort(round(prop.table(table(wt$윤정우))*100, digits=1), decreasing=T)
pie(table(wt$윤정우),col=rainbow(4),radius=1)
pct<-round(prop.table(table(wt$윤정우))*100, digits=1)
lab1<-c('결석','지각','출석')
lab2<-paste(lab1,"\n",pct,"%")
pie(table(wt$윤정우),radius=1,col=rainbow(3),label=lab2)

#이수민
x<-table(wt$이수민)
prop.table(table(wt$이수민))*100
round(prop.table(table(wt$이수민))*100, digits=1)
sort(round(prop.table(table(wt$이수민))*100, digits=1), decreasing=T)
pie(table(wt$이수민),col=rainbow(4),radius=1)
pct<-round(prop.table(table(wt$이수민))*100, digits=1)
lab1<-c('결석','지각','출석')
lab2<-paste(lab1,"\n",pct,"%")
pie(table(wt$이수민),radius=1,col=rainbow(3),label=lab2)

#차용준
x<-table(wt$차용준)
prop.table(table(wt$차용준))*100
round(prop.table(table(wt$차용준))*100, digits=1)
sort(round(prop.table(table(wt$차용준))*100, digits=1), decreasing=T)
pie(table(wt$차용준),col=rainbow(4),radius=1)
pct<-round(prop.table(table(wt$차용준))*100, digits=1)
lab1<-c('결석','지각','출석')
lab2<-paste(lab1,"\n",pct,"%")
pie(table(wt$차용준),radius=1,col=rainbow(3),label=lab2)

#박성채
x<-table(wt$박성채)
prop.table(table(wt$박성채))*100
round(prop.table(table(wt$박성채))*100, digits=1)
sort(round(prop.table(table(wt$박성채))*100, digits=1), decreasing=T)
pie(table(wt$박성채),col=rainbow(4),radius=1)
pct<-round(prop.table(table(wt$박성채))*100, digits=1)
lab1<-c('결석','지각','출석')
lab2<-paste(lab1,"\n",pct,"%")
pie(table(wt$박성채),radius=1,col=rainbow(3),label=lab2)

#최서준
x<-table(wt$최서준)
prop.table(table(wt$최서준))*100
round(prop.table(table(wt$최서준))*100, digits=1)
sort(round(prop.table(table(wt$최서준))*100, digits=1), decreasing=T)
pie(table(wt$최서준),col=rainbow(4),radius=1)
pct<-round(prop.table(table(wt$최서준))*100, digits=1)
lab1<-c('결석','출석')
lab2<-paste(lab1,"\n",pct,"%")
pie(table(wt$최서준),radius=1,col=rainbow(3),label=lab2)
