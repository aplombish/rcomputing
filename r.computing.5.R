#5장. R함수 만들기
#5.1. 함수의 정의
#5.2. 함수의 기초
#5.2.1. 함수의 장점
#5.2.2. 함수의 구조 및 생성방법
u <-1 #전역변수
v <-8 #전역변수
g <- function(x){#x:매개변수
  x<-x+1
  u<-u+x#u 는 지역변수의 역할
  return(u)
}
g(v)
u #전역변수는 값의 변화 없음 
v
#함수의 생성방법
d.mean <- function(data){#함수 선언
  sum(data)/length(data) #매개변수 값으로 들어온 data 의 값을 data의 크기로 나누기
}
x<-rnorm(100, mean=3, sd=1.5)
d.mean(x)
x<-rnorm(1000, mean=3, sd=1.5)
d.mean(x)
x<-rnorm(10000, mean=3, sd=1.5)
d.mean(x)

#예제 5-3. 분산구하는 함수
data <- rnorm(100, 3, 2)
d.var <- function(data){
  data.var <-sum((data - d.mean(data))^2)/(length(data)-1)
  return(data.var)
}
d.var(data)

#예제 5.4. 범위 산출 함수
d.range <- function(data){
  data.min<-min(data)
  data.max<-max(data)
  c(data.min, data.max) #범위 출력 여기까지 그냥 메모장에 저장
}
#함수생성된 거 가져오는 코드 source("경로")
d.range(x)

#5.3. 여러가지 함수의 생성
#5.3.1. 함수의 저장
#예제. 5.5
f1 <- function(x,y){return(x+y)}
f2 <- function(x,y){return(x-y)}
f <- f1
f(1,2)
f <- f2
f(1,2)

#예제 5.6.
g <- function(h,x,y){h(x,y)} #f1,f2및 x,y를 매개변수로 하는 함수 g 생성 
g(f1,1,2) 
g(f2,1,2)

#5.3.2. 함수의 매개변수 지정
f0 <-function(){#매개변수가 없는 함수 선언
  x<-c(1,2,3,4)
  y<-c(4,3,2,1)
  z<-x-y
  print(z)#z를 출력
}
f0() #여기 괄호 없으면 저장만 하고 출력 안 한다

#예제 5.8.
f_default <- function(data, num=1){#num=1 기본값
  d.min<-min(data)
  d.max<-max(data)
  switch(num, mean(data), var(data), c(d.min, d.max))
}
f_default(x)

#예제 5.9.
x <- rnorm(1000, mean=5, sd=2) #random number 생성 #normal 정규분포 따름
f_default(data=x, num=2)
f_default(x,2)
f_default(x)

#5.3.3. 함수를 위한 함수
is.function(f_default)#함수인지 아닌지 검증하는 함수

#예제 5.11 
args(f_default)#매개변수를 반환하는 함수

#예제 5.12
args(log)

#예제 5.13
attributes(f_default)#소스코드반환

#5.3.4. 함수 생성방법의 응용
#연산자의 생성
"%a2b%" <-function(a,b) return(2*a+b)
3%a2b%5

#함수 내에서의 함수 생성 *중요*
f <-function(x){
  v<-2
  g<-function(y)return((u+v+y)^2)
  gu <- g(u)
  print(gu)
}
u <-5
f()







