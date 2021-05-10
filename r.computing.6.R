#6장 R 그래픽스

#6-1 범주형 단변수 자료
library(MASS)
head(Cars93)

#기본 막대그림
(tab <- with(Cars93, table(Type)))#테이블 함수에 괄호 없으면 빈도표를 그냥 값만 저장한다. with함수를 사용하면 따로 데이터를 지정하지 않아도 변수명을 바로 지정하여 원하는 함수를 실행시킬 수 있다.  
barplot(tab, main="Type of Car", xlab="Type", ylab="Number of Car", col=1:6, legend=c('Compact','Large','Midsize','Small','Sporty','Van'))
names.arg=c('Compact','Large','Midsize','Small','Sporty','Van')

#6.1.2 side 형 막대그림 
tab <- with(Cars93, xtabs(~Type+AirBags)) #type 과 airbag 을 섞어서 그려라 xtab = cross table
barplot(tab,col=rainbow(6), legend=c('Compact','Large','Midsize','Small','Sporty','Van'), 
        xlab="AirBags", ylab="Number of Cars", beside=TRUE) #beside 가 붙으면 사이드형 막대그림

#6.1.3. stacked 막대그림 (1) 
#stacked 막대그림
barplot(tab,col=rainbow(6), legend=c('Compact','Large','Midsize','Small','Sporty','Van'), 
        xlab="AirBags", ylab="Number of Cars", beside=FALSE) #beside false 면 스택

#6.1.4 Stacked 막대그림 (2)
barplot(tab,col=rainbow(6), legend=c('Compact','Large','Midsize','Small','Sporty','Van'), 
        xlim=c(0,ncol(tab)+2), xlab="AirBags", ylab="Number of Cars", 
        args.legend=list(x=ncol(tab)+2, y=max(colSums(tab)), bty="n")) #주석의 위치 변경. 좌표를 정해준 경우

#6.1.5. 파이차트 (1)
#파이차트
tab<-with(Cars93, table(Type))
pie(tab, col=topo.colors(6))

#6.1.6. 파이차트 (2)
#표시되는 이름 변경 
names(tab) <- c('Compact','Large','Midsize','Small','Sporty','Van')
pie(tab,col=topo.colors(6))

#6.2. 연속형 단변수 자료
#6.2.1. 히스토그램
with(Cars93, hist(MPG.highway,xlab='MPG in Highway', main='MPG in Highway')) 
#히스토그램으로 분포 파악 오른쪽으로 꼬리가 치우친 그래프

#6.2.2. 확률밀도함수 그림(Density Plot)
install.packages("vcd")
library(vcd)
summary(Arthritis)
head(Arthritis)
with(Arthritis, plot(density(Age))) #density 확률밀도함수 (연결된 함수처럼 만드는 명령)

#6.2.3. 확률밀도함수 그림 (2)
with(Cars93, hist(MPG.highway,xlab='MPG in Highway', main='MPG in Highway', probability=T))
with(Cars93, lines(density(MPG.highway), col='red', lwd=2)) #확률밀도 함수 값을 히스토그램에 overlay
#lines 를 붙이면 겹쳐서 나온다

#6.2.4. Quantile-Qunatile(Q-Q) 그림
#qqplot 실제 우리 관측치하고 이론에 따라 정규분포로 나올 수 있는 값을 나눠 그려서 
#자료가 특정 분포를 따르는지 확인
with(Cars93, qqnorm(Turn.circle,main='Q-Q plot of Turn.circle \n (U-turn space, feet)'))
with(Cars93, qqline(Turn.circle,col='orange',lwd=2)) #\n으로 줄바꿈 main=타이틀 추가 qqline으로 직선 추가

#6.3. 연속형 다변수와 범주형 단변수 자료의 표현
#6.3.1. 상자그림 (Box Plot)(1)
boxplot(Min.Price~AirBags, data=Cars93)
#boxplot 개별 값 확인
boxplot(Min.Price~AirBags, data=Cars93)[]$stats
#driver only 그룹의 분포 출력
summary(subset(Cars93, AirBags=='Driver only')$Min.Price) #subset 뽑아내라. driver only 조건을 만족하는 것만 뽑아내라. 
#그 다음에 Min.Price 가격 변수만 뽑아서 서머리해라

#6.3.2. 상자그림 (2)
boxplot(Min.Price~AirBags, data=Cars93, names=c("Driver & Passenger", "Driver only","None"),
        col=c("orange", "cyan", "yellow"), ylab="Minimum Price", 
        xlab="Airbag", ylime=c(0,50), boxwex=0.25)

#6.3.3. 상자그림 (3)
boxplot(Min.Price~AirBags, data=Cars93, at=c(3,2,1), names=c("Driver & Passenger", "Driver only","None"),
        col=c("orange", "cyan", "yellow"), ylab="Minimum Price", 
        xlab="Airbag", ylime=c(0,50), boxwex=0.25) #at 으로 순서바꾸기

#6.3.4. 상자그림 (4)
library(ggplot2)
qplot(AirBags, Min.Price, data=Cars93, geom=c("boxplot","jitter"), fill=AirBags, 
      ylab="Minimum Price", xlab="Airbags", alpha=I(.2))

#6.3.5. 상자그림 (5)
p <- ggplot(Cars93, aes(x=AirBags, y=Min.Price)) + geom_boxplot(aes(fill=AirBags)) + scale_fill_viridis_d()
p

#6.3.6. 상자그림 (6)
p + theme(legend.position="none")+xlab("AirBags")+ylab("Minimum Price") #범례생략

#6.3.7. Pirate 그림 (1)
library(yarrr)
pirateplot(formula=Price~AirBags,point.o=0.1,data=Cars93, main="Price by Airbag type"
           , inf.method='iqr')

#6.3.8. Pirate 그림 (2)
pirateplot(formula=MPG.city~Origin+DriveTrain, point.o=0.5,data=Cars93, 
           main="City MPG by Origin and Drive Train"
           , inf.method='iqr')

#6.3.9. 그룹별 확률밀도함수 그림 (1)
ggplot(Cars93, aes(x=MPG.highway))+geom_density(aes(group=Type, colour=Type))+
  labs(x="MPG.highway", y="Density")+ggtitle("Density of MPG in Highway by Type")+theme(plot.title=element_text(hjust=0.5))
#그룹별 확률밀도 함수

#6.3.10. 그룹별 확률밀도함수 그림 (2)
ggplot(Cars93, aes(x=MPG.highway))+theme_bw()+geom_density(aes(group=Type, colour=Type))+
  labs(x="MPG.highway", y="Density")+ggtitle("Density of MPG in Highway by Type")+theme(plot.title=element_text(hjust=0.5))
#배경색 변경

#6.3.11. 여러 가지 확률밀도함수 그림을 동시에 배열하기 (1)
p1 <- ggplot(Cars93, aes(x=MPG.highway))+theme_bw()+geom_density(aes(group=Type, colour=Type))+
  labs(x="MPG.highway", y="Density")+ggtitle("Density of MPG in Highway by Type")+theme(plot.title=element_text(hjust=0.5))
p2 <- ggplot(Cars93, aes(x=MPG.highway))+theme_bw()+geom_density(aes(group=Origin, colour=Origin))+
  labs(x="MPG.highway", y="Density")+ggtitle("Density of MPG in Highway by Origin")+theme(plot.title=element_text(hjust=0.5))
library(gridExtra)
grid.arrange(p1, p2, ncol=2)

#6.3.12. 여러 가지 확률밀도함수 그림을 동시에 배열하기 (2)
p1 <- ggplot(Cars93, aes(x=MPG.highway))+theme_bw()+geom_density(aes(group=Type, colour=Type))+
  labs(x=expression("MPG"^highway), y=expression("Density"[value]))+ggtitle("Density of MPG in Highway by Type") +
  theme(plot.title=element_text(hjust=0.5))+coord_cartesian(xlim=c(25,40)) #zoom in for specific range

p2 <- ggplot(Cars93, aes(x=MPG.highway))+theme_bw()+geom_density(aes(group=Origin, colour=Origin))+
  labs(x=expression("MPG"^highway), y=expression("Density"[value]))+ggtitle("Density of MPG in Highway by Origin") +
  theme(plot.title=element_text(hjust=0.5))

p3 <- ggplot(Cars93, aes(x=MPG.highway))+theme_bw()+geom_density(aes(group=Man.trans.avail, colour=Man.trans.avail))+
  labs(x=expression("MPG"^highway), y=expression("Density"[value]))+ggtitle("Density of MPG in Highway \n by Manual Transmission Availability") +
  theme(plot.title=element_text(hjust=0.5))

p4 <- ggplot(Cars93, aes(x=MPG.highway))+theme_bw()+geom_density(aes(group=AirBags, colour=AirBags))+
  labs(x=expression("MPG"^highway), y=expression("Density"[value]))+ggtitle(expression(paste("Density of MPG(",mu,")")^highway)) +
  theme(plot.title=element_text(hjust=0.5))

grid.arrange(p1,p2,p3,p4, ncol=2, nrow=2)

#6.3.13. 호흡곡선(1)
library(vcd)
spine(Improved~Age, data=Arthritis,breaks=3) #호흡곡선

#6.3.14. 호흡곡선(2)
with(Arthritis, spine(Improved~Age, breaks=quantile(Age))) #호흡곡선 quantile에 따라 4등분

#6.3.15. 호흡곡선(3)
spine(Improved~Age, data=Arthritis,breaks="Scott") #호흡곡선 5세 10세 단위 구간

#6.3.16. 조건부 밀도함수 그림 (1)
cdplot(Improved~Age, data=Arthritis) #조건부밀도함수

#6.3.17. 조건부 밀도함수 그림 (2)
cdplot(Improved~Age, data=Arthritis) #조건부밀도함수 연속형 변수의 값이 특정 구간에 얼마나 많이 분포하는지 
with(Arthritis, rug(jitter(Age),col='white', quiet=TRUE))

#6.4. 연속형 이변수 변수들에 대한 자료의 표현
#6.4.1. 기본 산점도 (11강)
#기본 산점도 
library(MASS)
with(Cars93, plot(Price, MPG.city, main="Price vs MPG.city", xlab="Price", 
                  ylab="MPG in City", pch=10))
with(Cars93, abline(lm(MPG.city~Price), col="red", lwd=2))
with(Cars93, lines(lowess(Price,MPG.city), col="blue", lwd=2)) #lowess 직선의 제한을 완화해서 부드럽게 두 변수의 관계 설명하는 모형
legend(40,40,lty=1,col=c("red","blue"), c('regression','lowess'), lwd=2, bty="n")

?pch

#6.5.다변수 자료의 요약
#6.5.1. vcd 패키지를 활용한 모자이크 그림
library(vcd)
summary(Arthritis)
art <- xtabs(~Treatment+Improved, data=Arthritis, subset=Sex == "Female")
art #교차표 생성
mosaic (art, gp= shading_max)
#pearson residuals = 실제 데이터에서 기대도수를 빼고 나눈 숫자

#6.5.2. vcd 패키지를 활용한 모자이크 그림 (2) 
mosaic(~Sex+Age+Survived, data=Titanic, main="Survival on the Titanic", shade=TRUE, legend=TRUE)

#6.5.3. 다중 산점도
dat1 <- subset(Cars93, select=c(Min.Price, Price, Max.Price, MPG.city, MPG.highway))
pairs(dat1)

#6.5.4. 단순 산점도 (1)
with(Cars93, plot(Price, MPG.city, xlab='Price', ylab='MPG in City', main='mileage'))

#6.5.5. 단순 산점도 - 그룹별 산점도
with(Cars93, plot(Price, MPG.city, xlab='Price', ylab='MPG in City', type='n'))
with (subset(Cars93, DriveTrain=='Front'), points(Price, MPG.city, col='orange', 
                                                  pch=19))
with (subset(Cars93, DriveTrain=='Rear'), points(Price, MPG.city, col='firebrick', 
                                                 pch=17))
with (subset(Cars93, DriveTrain=='4WD'), points(Price, MPG.city, col='black', 
                                                pch=8))
legend("topright", legend=c('Front','Rear','4WD'), col=c('orange','firebrick','black'),
       pch=c(19,17,8), bty='n')

#6.5.6. 단순 산점도에 회귀선 추가하기
fit1 <- with(subset(Cars93, DriveTrain=='Front'), lm(MPG.city~Price))
fit2 <- with(subset(Cars93, DriveTrain=='Rear'), lm(MPG.city~Price))
fit3 <- with(subset(Cars93, DriveTrain=='4WD'), lm(MPG.city~Price))

xx1<-subset(Cars93, DriveTrain=='Front')$Price
yy1<-fit1$coef[1]+fit1$coef[2]*xx1

xx2<-subset(Cars93, DriveTrain=='Rear')$Price
yy2<-fit2$coef[1]+fit2$coef[2]*xx2

xx3<-subset(Cars93, DriveTrain=='4WD')$Price
yy3<-fit3$coef[1]+fit3$coef[2]*xx3

with(Cars93, plot(Price, MPG.city, xlab='Price', ylab='MPG in City', type='n'))
with (subset(Cars93, DriveTrain=='Front'), points(Price, MPG.city, col='orange', 
                                                  pch=19))
with (subset(Cars93, DriveTrain=='Rear'), points(Price, MPG.city, col='firebrick', 
                                                 pch=17))
with (subset(Cars93, DriveTrain=='4WD'), points(Price, MPG.city, col='black', 
                                                pch=8))
legend("topright", legend=c('Front','Rear','4WD'), col=c('orange','firebrick','black'),
       pch=c(19,17,8), bty='n')
lines(xx1,yy1,col='orange',lwd=2)
lines(xx2,yy2,col='firebrick',lwd=2)
lines(xx3,yy3,col='black', lwd=2)

#6.5.7.여러 개의 그림 동시에 표현하기
par(mfrow=c(2,2))

with (subset(Cars93, DriveTrain=='Front'), plot(Price, MPG.city, col='orange', 
                                                pch=19, main='Front'))
with (subset(Cars93, DriveTrain=='Rear'), plot(Price, MPG.city, col='firebrick', 
                                               pch=17, main='Rear'))
with (subset(Cars93, DriveTrain=='4WD'), plot(Price, MPG.city, col='black', 
                                              pch=8, main='4WD'))

#6.5.8. 그룹별 산점도 
library(ggplot2)
qplot(Wheelbase, Width, data=Cars93, shape=Type, color=Type, facets=Origin~AirBags,
      size=I(2), xlab="Wheelbase", ylab="Car Width")

#6.5.9. 나무지도 그림(1)
install.packages("treemap")
install.packages("GNI2014")
library(treemap)
data(GNI2014)
treemap(GNI2014, index=c("continent", "iso3"), vSize="population", vColor="GNI",
        type="value") #연속형 변수 나타냄 명목형일 때는 type="categorical"

#6.5.10. 나무지도 그림 (2)
treemap(Cars93, index=c("Manufacturer","Make"), vSize="Price", vColor="AirBags", type="categorical")

#6.5.11. 풍선그림 
library(gplots)
dt<-with(Cars93, xtabs(~AirBags+Type))
balloonplot(dt, main="Airbags by Car Type", xlab="", ylab="", label=FALSE,
            show.margins=FALSE)

#6.5.12. 풍선그림 (2)
#실제 값 표시
balloonplot(dt, main="Airbags by Car Type", xlab="", ylab="", label=TRUE,
            show.margins=TRUE)

#6.5.13. graphics 패키지를 활용한 두 변수 모자이크 그림 
library(graphics)
mosaicplot(dt, color=TRUE, las=1, main="Airbags by Car Type")

#6.5.14. graphics 패키지를 활용한 다변수 모자이크 그림
mosaicplot(~DriveTrain + AirBags + Origin, las=1, main="Drive Train by Airbags and Origin", ylab='Airbag type', xlab='Drive Train',
           data=Cars93, color=TRUE)
with(Cars93, xtabs(~DriveTrain+AirBags+Origin)) #교차표에서 구체적인 값 확인






