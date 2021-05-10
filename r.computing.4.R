#4장. R프로그래밍의 기초
#4.1. 프로그래밍 언어로서의 R
#4.2. 연산자
#4.2.1. 산술연산자
#정수 나눗셈 연산자 %/% 몫의 정수부분만 출력
x<-3
y<-2 
x%/%y

#4.2.2. 비교연산자와 논리연산자
#비교연산자 
x<-2
y<-3
x==y

#비교되는 두 항이 다른지 비교
x!=y

#작거나 같은지 판단
x<=y

#크거나 같은지
x>=y

#논리연산자 (스칼라값 벡터값 비교 가능)
#&&는 일반적인 논리연산자 &는 벡터에서의 and 논리연산자
3==3 && 3>2
2==2 & c(2==2, 3>4)

#|| 일반적인 or 논리연산자 |는 벡터에서의 논리연산자
3!=3||3>4
2!=2|c(2==2, 3>4) #벡터끼리 비교할 때는 일반적인 논리 연산자를 쓰면 뒤에 것을 무시해 버림

#4.2.3. 집합연산자 union(x,y) 집합 x, y의 합집합 intersect(x,y) 교집합 산출
x<-c(1,2,5)
y<-c(5,1,7,8)
union(x,y)
intersect(x,y)

setdiff(x,y) #차집합 
setdiff(y,x)

setequal(x,y) #두 집합이 같은지 판단
setequal(y,x)

5 %in%x #원소가 x에 포함되는지 판단
choose(5,2) #n개의 원소로 이루어진 집합에서 추출 가능한 k개의 원소로 이루어진 부분집합 수 (5C2)

#4.3. 기본적인 R함수
#4.3.1. 수치적 함수
pi
log(x) #자연로그 함수
log10(x) #상용로그 함수
exp(x) #지수로그 함수
sqrt(x) #루트함수
sin(x) 
cos(x)
tan(x)
asin(x)
acos(x)
atan(x)
min(x) #벡터에서 최소값
max(x) #벡터에서 최대값
min(x,y) #전체 벡터 원소 중에서 최소값 나열해놓고 가장 작은 값
range(x) #벡터의 범위 
c(min(x),max(x)) #range 와 같음 
x1 <-c(1,2,-3,4)
x2 <-c(2,4,-6,7)
pmin(x1,x2) #두 벡터의 상응하는 원소들 중 작은 값. 늘어놓는 게 아니라 pairwise 하게 비교 
pmax(x1,x2) #두 벡터에 상응하는 원소들 중 큰 값

#4.3.2. 통계함수
mean(x1) #평균
sd(x1) #표준 편차
var(x1) #분산
median(x1) #중앙값
x1<-c(1,2,3,4,5,6,7,8,9,10)
quantile(x1,0.5) #100*p%에 해당하는 값
y<-c(10:2, 5)
cor(x1,y) #상관계수

#4.4. 프로그래밍의 기본 구조
#4.4.1. 조건문 특정한 조건을 만족했을 경우에만 프로그램 코드를 수행하는 제어 구문
x<-c(1,2,3,4)
y<-c(2,1,4,5)
if(sum(x)<sum(y))print(x)

if(sum(x)<sum(y)){
  print(mean(x))
  print(var(x))
}#x의 값이 y의 합보다 작은면 x의 평균과 분산 출력

if(mean(x)>mean(y)) print("Mean(x)>Mean(y)") else
  print("Mean(x)<Mean(y)")

if(mean(x)>mean(y)){
  print(mean(x))
  print(var(x))
}else{
  print(mean(y))
  print(var(y))
}

#중첩 조건문 조건문 안에 조건문 위치
if (length(x)==5){#외부조건문
  if(sum(x)==10) print("length=5, sum=10")#내부조건문
}else{
  print("length=4, sum=10")
}

if (length(x)==4){#외부조건문
  if(sum(x)==10) print("length=4, sum=10")#내부조건문
}else{
  print("length=4, sum=10")
}

#ifelse 조건문
ifelse(x<y,x,y)
ifelse(sum(x-y)>0, "positive",ifelse(sum(x-y)<0,"negative","zero"))

#switch문 매개변수의 값에 따라 조건에 맞는 실행문을 찾아 수행
x<-c(1:4)
type <-"var"
switch(type, mean=mean(x), median=median(x), sum=sum(x),var=var(x))

switch(1, mean(x), sum(x), var(x)) #1,2,3번째 수행하라

#4.4.2. 반복문
#for 반복문
for(i in 1:5) print(rep(i,i))

#for 반복문을 실행하여 1에서 10까지 합을 구하기 
x<-0
for(i in 1:10)
  x<-x+i
x

#while (조건){실행문}
i<-1
while(i<=5){
  print(rep(i,i))
  i<-i+1 #1씩 증가시켜 자신에게 할당 
}

i<-1
x<-0
while(i<=10){
  x<-x+i
  i<-i+1
}
x

#repeat 반복문
i<-1
repeat{
  if(i>5) break #기준점 설정
  print(rep(i,i))
  i<-i+1
}

i<-1
x<-0
repeat{
  if(i>10)break
  x<-x+i
  i<-i+1
}
x
#4.4.3. 무조건 분기문
#break 루프에서 빠져나가는 구문
x<-0
for(i in 1:10){
  x<-x+i
  if(x>25) break
  print(x)
}

#구구단 출력 (break 없을 땐 구구단 모두 출력)
i<-1
j<-1
for(i in 1:9){
  if(i>3) break
  for (j in 1:9) {
    if(j>1) break
    cat(i, "*",j, "=",i*j,"\n")
  }
}

#next 분기문 break 보다 더 강제적. 반복문을 수행하더라도 조건 충족하면 next 이후 실행문 수행하지 않고 건너뛰게 됨
i<-1
x<-0
while(i<10){#while 초기값 i, 기준치, 수행문
  i<-i+1
  if(i<8) next #next 이후의 명령은 if의 조건이 충족되는 한 미수행
  print(i)
  x<-x+i
  
}
x




















