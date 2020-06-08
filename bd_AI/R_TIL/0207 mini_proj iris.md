## mini_proj_R

### iris data 분석

```R
# column별 na 갯수 확인
> colSums(is.na(iris))
Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
           0            0            0            0 
     Species 
           0 

panel.fun <-function(x,y,...){
        horizontal<-(par("usr")[1]+
                       par("usr")[2])/2;
        vertical<-(par("usr")[3]+
                     par("usr")[4])/2;
        text(horizontal, vertical, 
             format(abs(cor(x,y)),digits=2))
      }

pairs(iris[1:4],
      pch=21, bg=c("red","green","blue")[unclass(iris$Species)],
      upper.panel=panel.fun,
      main="Scatter")

-----------------------------------------------------------

## ggplot 시각화

library(ggplot2)
iris_plot<-ggplot(iris,aes(x=Petal.Length,y=Petal.Width,colour=Species))+
  geom_point(shape=19,size=4)
iris_plot2<-iris_plot+
  annotate('text',x=1.5,y=0.7,label='Setosa')+
  annotate('text',x=3.5,y=1.5,label='Versicolor')+
  annotate('text',x=6,y=2.7,label='Virginica')
iris_plot2+
  annotate('rect',xmin=0,xmax=2.6,ymin=0,ymax=0.8,alpha=0.1,fill='red')+
  annotate('rect',xmin=2.6,xmax=4.9,ymin=0.8,ymax=1.5,alpha=0.1,fill='green')+
  annotate('rect',xmin=4.8,xmax=7.2,ymin=1.5,ymax=2.7,alpha=0.1,fill='blue')

-----------------------------------------------------------

## k-means

> iris_kmeans<-kmeans(iris[,c('Petal.Length','Petal.Width')],3)
> table(iris_kmeans$cluster)
 1  2  3 
48 52 50 

```







```R
> airquality_1<-airquality[,c(1:4)]

# na 처리
> airquality_2<-na.omit(airquality_1)
> colSums((is.na(airquality_2)))
  Ozone Solar.R    Wind    Temp 
      0       0       0       0 

# 함수 적용
panel.hist <- function(x, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(usr[1:2], 0, 1.5) )
  h <- hist(x, plot = FALSE)
  breaks <- h$breaks; nB <- length(breaks)
  y <- h$counts; y <- y/max(y)
  rect(breaks[-nB], 0, breaks[-1], y, col = "cyan", ...)
}

panel.cor <- function(x, y, digits = 2, prefix = "", cex.cor, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- abs(cor(x, y))
  txt <- format(c(r, 0.123456789), digits = digits)[1]
  txt <- paste0(prefix, txt)
  if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
  text(0.7, 0.7, txt, cex = cex.cor * r)
}

panel.lm<-function(x,y,col=par('col'),
                   bg=NA,pch=par('pch'),
                   cex=1,col.smooth='black',...){
  points(x,y,pch=pch,col=col,
         bg=bg,cex=cex)
  abline(stats::lm(y~x),
         col=col.smooth,...)
}

# 상관분석표 출력
pairs(airquality_2,pch='*',main='scatter plot',lower.panel=panel.lm,
      upper.panel=panel.cor,diag.panel=panel.hist)

```

