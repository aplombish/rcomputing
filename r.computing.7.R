#7장. R그래픽스 (2)
#7.1. 두 변수 간의 상관관계를 표현한 그래프
#7.1.1. 상관도 그림
install.packages("corrr")
library(corrr)
install.packages("magrittr")
library(magrittr)
mtcars %>% head #head(mtcars) 수행
mtcars %>% tan %>% cos %>% sin %>% head %>% round(2) 
mtcars %>% correlate() %>% fashion()
mtcars %>% correlate() %>% rplot()

#7.1.2. 상관도 네트워크 그림
mtcars %>% correlate() %>% network_plot(min_cor=.3) #상관계수 절대값이 0.3 이상이면 네트워크로 표현

#7.1.3. 변수 군집 그림 
#변수간의 상관도의 정도를 나무 그림 형태로 표현 
install.packages("Hmisc")
library(Hmisc)
library(MASS)
temp <- Cars93[,c('Price','MPG.city','Horsepower','RPM','Length','Wheelbase')]
plot(v<-varclus(~., data=temp, similarity="spear"))

#7.2. 외부그림 불러오기와 그림 저장하기
#7.2.1. JPEG 그림 불러오기 
library(ggplot2)
qplot(Horsepower, Price, data=Cars93, colour=AirBags, size=AirBags)
#jpeg 그림 불러오기
library(jpeg)
sales.amount <- c(1.5,2.3,5.4,7.5,9,8)
img <- readJPEG("경로") #외부 이미지 불러오기
plot(c(0.5,6.5), c(0,10), axes=F, cex.lab=1.3) #전체적으로 그래프를 그릴 준비를 해라
type='n', xlab='Months', ylab='Sales(in million dollars)')
axis (1, at=c(1,2,3,4,5,6), labels=c('January','February','March','April','May','June'), cex.axis=1.2) #x축 
axis (2, at=c(0,2,4,6,8,10), labels=c('0','2','4','6','8','10'), cex.axis=1.2) #y축
lines(1:6, sales.amount, lwd=2, col='orange')
for (jj in 1:6{rasterImage(img, jj-0.3, sales.amount[jj]-0.3, jj+0.3, sales.amount[jj]+0.3)}) #외부이미지를 뿌려주는 과정

#7.2.2. PNG 글미 불러오기
  #png 그림 불러오기
  library(png)
img <- readPNG("경로")
plot(c(1,6),c(15,46), cex.lab=1.3, axes=F, type='n', xlab='Engine Size', ylab='MPG in CIty')
rasterImage(img, 0.7, 14.5, 6.1, 46.0)
axis(1, at=c(1,2,3,4,5,6), labels=c('1','2','3','4','5','6'), cex.axis=1.2)
axis(2, at=seq(15, 45, by=5), labels=seq(15,45, by=5), cex.axis=1.2)
with(subset(Cars93, Origin=='non=USA'), points(EngineSize, MPG.city, col=2, pch=16))
with(subset(Cars93, Origin=='USA'), points(EngineSize, MPG.city, col=4, pch=16))
legend('topright', bty='n', c('non-USA', 'USA'), col=c(2,4), lwd=2, pch=16)
text(2.3, 35, pos=4, 'Cars in USA have low MPGs in City, \nwhile having large engines compared \nto Non-USA.', col=1)  

#7.2.3. 그림 저장
#그림저장
jpeg(file='파일 이름'), width=6, height=6, units='in', res=600, bg="white")
dev.off()

pdf(file='제목', ,width=6, height=6, bg="white", paper='special')
dev.off()

#7.3. ggplot2 패키지를 이용한 그림 그리기
#7.3.1. subgroup 존재하는 경우 산점도 
library(ggplot2)
qplot(Horsepower, Price, data=Cars93, colour=AirBags, size=AirBags)
Cars93$manual <- with (Cars93, ifelse(Man.trans.avail=='No', 'Manual_Trans_No', 
                                     'Manual_Trans_Yes'))
with(Cars93, qplot(Horsepower, Price, data=Cars93, facets=manual ~ Origin))

#7.3.3. qplot 활용한 확률밀도 함수 그림
qplot(Fuel.tank.capacity, data=Cars93, geom="density", fill=Origin, alpha=I(2),
      main="Fuel tank capacity by Origin", xlab="Fuel tank capacity (US gallons)",
      ylab="Density")+theme(plot.title=element_text(hjust=0.5))

#7.3.4. 회귀선 추가 산점도 (1)
#ggplot 함수를 이용하면 따로 회귀 계수 계산할 필요 없이 회귀선 추가
ggplot(Cars93, aes(x=Horsepower, y=Price))+geom_point(shape=16)+geom_smooth(method=lm)

#7.3.5. 회귀선 추가 산점도 (2)
ggplot(Cars93, aes(x=Horsepower, y=Price))+geom_point(shape=16)+geom_smooth(method=lm, se=FALSE)

#7.3.6. Smoothing Line 산점도 
qplot(Horsepower, Price, data=Cars93, geom=c("point","smooth"), color=Origin,
      main="Price vs Horsepower by Origin", xlab="Horsepower", ylab="Price") +
      theme(plot.title=element_text(hjust=0.5))

#7.3.7. 연속형 변수가 추가된 산점도 (1)
ggplot(Cars93, aes(x=Horsepower, y=Price, color=Width))+geom_point(shape=16)+
  scale_color_gradient(low="yellow", high="red")
  
#7.3.8. 연속형 변수가 추가된 산점도 (2)
ggplot(Cars93, aes(x=Horsepower, y=Price, color=Width))+geom_point(shape=16)+
  scale_color_gradientn(colours=rainbow(5))

#7.3.9. 명목형 변수가 추가되는 경우의 산점도 (1)
install.packages("RColorBrewer")
library(RColorBrewer)
library(ggplot2)
ggplot(Cars93, aes(x=Horsepower, y=Price, shape=AirBags, color=AirBags)) +geom_point(size=3)+scale_shape_manual(values=c(16, 17, 18)) +
  scale_color_brewer(palette="Dark2")

#7.3.10. 명목형 변수가 추가되는 경우의 산점도 (2)
#명목형변수가 추가되는 경우의 산점도 회귀선 그리기 위해 옵션 추가
ggplot(Cars93, aes(x=Horsepower, y=Price, shape=AirBags, color=AirBags)) +geom_point(size=3)+scale_shape_manual(values=c(16, 17, 18)) +
  scale_color_brewer(palette="Dark2") + geom_smooth(method=lm, se=FALSE)

#7.3.11. 명목형 변수가 추가되는 경우의 산점도 (3)
#회귀선 연장을 위해 옵션 fullrange=TRUE 추가 전 영역에 회귀선 추가
ggplot(Cars93, aes(x=Horsepower, y=Price, shape=AirBags, color=AirBags)) +geom_point(size=3)+scale_shape_manual(values=c(16, 17, 18)) +
  scale_color_brewer(palette="Dark2") + geom_smooth(method=lm, se=FALSE, fullrange=TRUE)

#13강
#7.4. 레이더 차트 
install.packages("doBy")
library(MASS)
library(doBy)
mean.by.Type2 <- summaryBy(MPG.highway+RPM+Horsepower+Weight+Length+Price~Type, 
                           data=Cars93, FUN=c(mean))
mean.by.Type2

#각 변수의 최대값 최솟값 구하기 
df2 <- mean.by.Type2[,c(2:7)]
df2
df_radarchart <- function(df){
  df <- data.frame(df)
  dfmax <- apply(df,2,max)
  dfmin <- apply(df,2,min)
  as.data.frame(rbind(dfmax, dfmin, df))
}
mean.by.Type <- df_radarchart(df2)
row.names(mean.by.Type) <- c('max','min', names(table(Cars93$Type)))
mean.by.Type

#7.4.1. 육각레이더 차트
install.packages("fmsb")
library(fmsb)
radarchart(df=mean.by.Type,
           seg=6, #육각
           pty=16,
           pcol=1:6,
           plty=1,
           plwd=2,
           title=c("Radar chart by Car types")
           )
legend("topleft", legend=mean.by.Type2$Type, col=c(1:6), lty=1, lwd=2)

#7.4.2.오각레이더 차트
dat <-Cars93[2:6, c('Price', 'Horsepower', 'Turn.circle', 'Rear.seat.room', 'Luggage.room')]
datmax <- apply(dat, 2, max)
datmin <- apply(dat, 2, min)
dat <- rbind (datmax, datmin, dat)
radarchart(dat, seg=5, plty=1, vlabels=c('Price', 'Horsepower', 'U-turn space\n(feet)',
                                         'Rear seat room\n(inches)',
                                         'Luggage capacity\n(cubic feet)'),
           title="5 segments, with specified vlables", 
           vlces=0.8, pcol=rainbow(5))
legend("topleft", legend=Cars93[2:6, 'Make'], col=rainbow(5), lty=1, lwd=1)

#7.5. 고밀도 자료에 대한 그림
#7.5.1. 상자그림 고밀도 산점도 (1)
library(ggplot2) 
summary(diamonds) #가로의 전체 영역을 회색 테두리 25개의 상자로 구분
ggplot(diamonds, aes(carat,price))+stat_bin2d(bins=25, colour="grey50") 

#7.5.2. 상자그림 고밀도 산점도(2)
#bins 를 40, x축 범위를 0에서 6까지로 증가 
ggplot(diamonds, aes(carat,price))+stat_bin2d(bins=40, colour="grey50") + scale_x_continuous(limits=c(0,6))

#7.5.3. 상자글미 고밀도 산점도 (3)
#scale_fill_gridientn 을 이용하여 색지정
ggplot(diamonds, aes(carat,price))+stat_bin2d(bins=40, colour="grey50") + scale_x_continuous(limits=c(0,6))+
  ggtitle("Price vs Carat")+theme(plot.title=element_text(hjust=0.5))+
  scale_fill_gradientn(colours=c('yellow','green','blue','red'))+labs(x="Carat", y="Price")

#7.5.4. 고밀도 자료에 대한 일반 산점도
install.packages("SwissAir")
library(SwissAir)
dim(AirQual)
with(AirQual, plot(ad.WS~ad.O3,xlab='03',ylab='WS'))
head(AirQual)

#7.5.5. smoothed density 이용한 산점도 
with(AirQual, smoothScatter(ad.WS,ad.O3,main="Scatter plot by smoothed densities', xlab='03", ylab='WS'))

#7.5.6. 고밀도 자료에 대한 육면 상자그림 (Hexagonal Binning Plot)(1)
#육면 상자 그림으로 표현
install.packages("hexbin")
library(hexbin)
with(AirQual, plot(hexbin(ad.O3,ad.WS,xbins=100), main='Hexagonal binning(bins=100)',
                   xlab='03',ylab='WS'))

#7.5.7. 고밀도 자료에 대한 육면 상자그림 (2)
#xbins 옵션을 작게 하였을 때
with(AirQual, plot(hexbin(ad.O3,ad.WS,xbins=30), main='Hexagonal binning(bins=100)',
                   xlab='03',ylab='WS'))

#7.5.8. 이미지 산점도 
#고밀도 자료를 산점도로 표현
install.packages("IDPmisc")
library(IDPmisc) #image plot 
with(AirQual, iplot(ad.O3, ad.WS, xlab='03', ylab='WS', main='Image Scatter Plot
                    with \n Color Indicating Density'))

#7.5.9. 다변수 고밀도 자료에 대한 이미지 산점도 
ipairs(subset(AirQual, select=c(ad.O3,ad.WS,ad.WD)))

#14강
#7.6. 단계 구분도 
#7.6.1. 단계 구분도 (1)
library(ggplot2)
library(maps)
library(maptools)
safety <- read.csv('data_2018.csv', header=T)
head(safety)
map <- read.csv('mapv2_final.csv', header=T)
head(map)
head(safety)
ggplot(safety, aes(map_id=region, fill=accident))+
  geom_map(map=map, alpha=0.3, colour='snow4',size=0.1)+
  theme(legend.position=c(0.9, 0.3))+labs(title="교통사고안전등급")+
  theme(plot.title=element_text(hjust=0.5))+
  scale_fill_gradientn(colours=c('white','orange','red'))+
  expand_limits(x=map$long, y=map$lat)+coord_fixed()+
  theme(axis.ticks=element_blank(), axis.text.y=element_blank())+
  theme(axis.ticks=element_blank(), axis.text.x=element_blank())+
  xlab("")+ylab("")+xlim(80000,750000)

#7.6.2. 단계구분도 (2)
ggplot(safety, aes(map_id=region, fill=fire))+
  geom_map(map=map, alpha=0.5, colour='white',size=0.0)+
  theme(legend.position='right')+ scale_fill_gradientn(colours=c('yellow','red'))+
          labs(title="화재안전등급")+theme(plot.title=element_text(hjust=0.5))+
  expand_limits(x=map$long, y=map$lat)+coord_fixed()+
  theme(axis.ticks=element_blank(), axis.text.y=element_blank())+
  theme(axis.ticks=element_blank(), axis.text.x=element_blank())+
  xlab("")+ylab("")+xlim(80000,750000)

#7.6.3. 단계구분도 (3)
young_d <- read.csv('data_seoul_child.csv', header=T)
head(young_d)

map_seoul <- read.csv('mapv2_final_seoul.csv', header=T)
head(map_seoul)

head(subset(map, 시군구명=='금천구'))
#서울 25개 구 코드 확인
pro.list <- names(table(map_seoul$시군구명))
xx <- vector(); yy <- vector()

head(map_seoul)
#위도 경도 좌표 계산
for (jj in 1:length(pro.list)){
  xx[jj] <- mean(subset(map_seoul, 시군구명==pro.list[jj])$long)
  yy[jj] <- mean(subset(map_seoul, 시군구명==pro.list[jj])$lat)
}

tab.x.y <- cbind(pro.list,xx,yy)
head(tab.x.y)
data5 <- young_d[sort.int(young_d[,1], index.return=T)$ix,]
head(data5)
  
ggplot(young_d,aes(map_id=region, fill=영유아보육시설))+
  geom_map(map=map_seoul, alpha=0.3, colour='white', size=0.1)+
  theme(legend.position=c(0.1,0.8))+
  scale_fill_gradientn(colours=c('yellow','red'))+
  expand_limits(x=map_seoul$long,y=map_seoul$lat)+coord_fixed()+
  labs(x="",y="", title="영유아보육시설")+
  theme(plot.title=element_text(hjust=0.5))+
  theme(axis.ticks=element_blank(), axis.text.y=element_blank())+
  theme(axis.ticks=element_blank(), axis.text.x=element_blank())+
  geom_text(x=xx, y=yy+400, label=data5$영유아보육시설, size=3, col=4)+
  geom_text(x=xx, y=yy-600, label=pro.list, size=3, col=1)

#7.7. 네트워크 그림
library(igraph)
split.screen(figs=c(1,2))
screen(1)
g1 <- graph(edges=c(1,2, 2,3, 3,1), n=3, directed=F) #방향성 없음
plot(g1)
screen(2)
g1 <- graph(edges=c(1,2, 2,3, 3,1), n=3, directed=T) #방향성 있음(default)
plot(g1)

#7.7.2. 네트워크 그림 (2)
split.screen(figs=c(1,2))
screen(1)
g1 <- graph(edges=c(1,2, 2,3, 3,1, 1,3), n=3)
plot(g1, edge.arrow.size=0.5)
screen(2)
g2 <- graph(edges=c(1,2, 2,3, 3,1), n=7)
plot(g2, edge.arrow.size=0.5)

#7.7.3. 네트워크 그림 (3)
g3 <- graph(c("Seoul", "Busan", "Busan", "Gwangju", "Gwangju", "Seoul"))
plot (g3)


#7.7.4. 네트워크 그림 (4)
library(igraph)
g4 <- graph(c("Seoul", "Busan", "Busan", "Gwangju", "Gwangju", "Seoul", "Seoul",
               "Daegu", "Seoul", "Daejeon"), isolates=c("Sejong", "Ulsan"))
plot(g4, edge.arrow.size=1.5, vertex.color="gold", vertex.size=15,
     vertex.frame.color="gray", vertex.label.color="black", 
     vertex.label.cex=1.2, vertex.label.dist=2, edge.curved=0.2)


#7.7.5. 네트워크 그림 (5)
g4 <- graph(c("Seoul", "Busan", "Busan", "Gwangju", "Gwangju", "Seoul", "Seoul",
              "Daegu", "Seoul", "Daejeon"), isolates=c("Sejong", "Ulsan"))
E(g4) #edge 에 대한 정보 확인
V(g4)$name #vertex 에 대한 정보 확인 
V(g4)$Type <- c("Special", "Metropolitan", "Metropolitan", "Metropolitan", 
                "Metropolitan", "Multi-funcitonal Administrative", "Metropolitan")
V(g4)$Pop <- c(9.7, 3.4, 5.5, 2.4, 1.5, 4.27, 2.1)
V(g4)$Type

#edge 에 대한 특성 입력
E(g4)$traffic_volume <- c(2.8, 4.5, 8.7, 7.5, 64, 4.9)
E(g4)$traffic <- c('train', 'plane', 'train', 'highway', 'highway')
E(g4)$ttype <- c('business', 'business', 'business', 'travel', 'travel')

#색지정: 서울(pink), 광역시 (skyblue), 세종시(peru)
plot(g4, edge.arrow.size=1.5, vertex.label.color="black", vertex.label.dist=2,
     vertex.color=c("pink", rep("skyblue",4), "peru", "skyblue"), edge.curved=0.2)

#7.7.6. 네트워크 그림 (6)
plot(g4, edge.arrow.size=1.5, vertex.label.color="black", vertex.label.dist=2,
     vertex.color=c("pink", rep("skyblue", 4), "peru", "skyblue"),
     edge.cerved=c(0.1, 0.9, 0.3, 0.4, 0.1))

#7.7.7. 네트워크 그림 (7)
plot(g4, edge.arrow.size=1.5, vertex.size=30,
     vertex.frame.color="gray", vertex.label.color="black",
     vertex.label.cex=1.2, vertex.label.dist=3.5, edge.curved=0.2,
     vertex.color=c("pink", rep("skyblue", 4), "peru", "skyblue"))

#7.7.8. 네트워크 그림 (8)
(E(g4)$width <- E(g4)$traffic_volume/2)
plot(g4, edge.arrow.size=1, vertex.size=V(g4)$Pop*4,
     vertex.frame.color="gray", vertex.label.color="black",
     vertex.label.cex=1.2, vertex.label.dist=3.5, edge.curved=0.2,
     vertex.color=c("pink", rep("skyblue", 4), "peru", "skyblue"))

#7.7.9. 네트워크 그림 (9)
#교통수단 색지정, 기차:1(black), 비행기: 2(maroon), 고속도로: 3(blue)
te <- c('train', 'plane', 'train', 'highway', 'highway')
line.col <- ifelse(te=='train', 1, ifelse(te=='plane', 2,3))
colrs <- c("black", "maroon", "blue")
plot(g4, edge.color=colrs[line.col], vertex.size=V(g4)$Pop*4,
     vertex.frame.color="gray", vertex.label.color="black",
     vertex.label.cex=1.2, vertex.label.dist=3.5, edge.curved=0.2,
     vertex.color=c("pink", rep("skyblue", 4), "peru", "skyblue"))

#7.7.10. 네트워크 그림 (10)
line.curve <- c(0.1, 0.9, 0.3, 0.4, 0.1)
mycolrs <- c("gold", rep("tomato", 4), "lightpink", "tomato")
plot(g4, edge.color=colrs[line.col], vertex.size=V(g4)$Pop*6,
     vertex.frame.color="gray", vertex.lable.color="black",
     vertex.label.cex=1.2, edge.curved=line.curve, vertex.color=mycolrs)
legend('topleft', c("Special", "Metropolitan", "Metropolitan Autonomous"),
       pch=21, pt.bg=c("gold", "tomato","lightpink"), pt.cex=2, bty="n", ncol=1)
legend(x=-1.5, y=-1.5, c('train', 'plane', 'highway'), lty=1, lwd=2, col=colrs,
       bty="n", ncol=3)































  
  
  
  
  
  


