#3장. 데이터 구조
#3.1. 데이터의 기본 형태
#3.2. 벡터
#3.2.1. 벡터의 생성
c(3:7) 
c(3,4,5,6,7)
c(7,3,5,4,6)
#문자형 벡터
v1 <- c("1", "Korea", "National", "Open", "University")
length(v1) #벡터의 크기 출력
#논리형 벡터
c(F,F,T)
c(TRUE, FALSE, TRUE)
#scan() 함수를 이용하여 3에서 7까지 자연수로 이루어진 벡터 생성
scan()
3 4 5
6 7 

scan(sep=",")
3
4,5
6,7

seq (from=3, to=7, by=1) #from=시작값, to=종료값, by=증가분
seq (to=7, from=3, by=1)
seq (by=1, from=3, to=7)
seq (3,7,1) #생략 시 시작, 종료, 증가분 순서로 인식

seq(3,7, length=3) #length = 원소 3개
seq(from=1, by=0.05, along=1:5) #along 으로 수열지정시 해당 수열에 따라 동일한 크기 벡터 생성
seq(from=1, to=5, along=1:6)

rep(c(1,2), times=2) #1과 2로 구성된 벡터를 2회 반복
rep(1:2, times=2) #1에서 2까지로 구성된 벡터를 2회 반복
rep(c(2,4), times=c(2,1)) #앞의 원소는 2회, 뒤의 원소는 1회 반복
rep(c(2,4), each=2) #앞, 뒤 모든 원소를 2회 반복
rep(c(2,4,8), length=5) #2,4,8로 구성된 벡터를 반복하되 생선되는 벡터의 크기를 5로 한정

#3.2.2. 벡터 자료의 편집
#na.last=TRUE 라고 기본값으로 지정된 옵션의 의미는 만약 결측치 존재한다면 
#자료의 맨 끝에 위치하는 것으로 간주 decreasing=FALSE 오름차순을 기본으로 하라
v1<-c(11:20)
v1
v1[c(3,5)] #v1의 세번째와 다섯번째 값 출력
v1[v1>15] #v1의 원소 중 15보다 큰 값을 출력
v1[c(-2,-4)] #v1의 원소 중 두 번째와 네 번째 값을 삭제하고 출력

v2 <-c(1:5)
v2
replace (v2,2,6) #v2의 두번째 원소 값을 6으로 변경
append(v2,8,after=5)#v2의 다섯 번째 값 다음에 8을 추가
v3 <-append(v2,8,after=5)
v3

#3을 세번 반복한 뒤 3에서 7까지 2만큼의 증가분으로 수열을 생성하고 
#이어서 rev()함수를 이용해서 3에서 7까지 이르는 크기 3인 벡터의 역순을 구해 연결한 뒤 
#4를 세 번 반복한 벡터를 덧붙임
#여기다 sort 이용해서 오름차순 정렬, rank 함수를 통해 자료 순위 출력, 
#order 함수 이용해 오름차순에 의한 자료의 위치 값 출력

x<-c(rep(3,3),seq(3,7,by=2),rev(seq(3,7,length=3)),rep(4,3))
x
sort(x)
rank(x) #자료의 순위 출력 3 다섯개가 5위까지 해당하는 값을 갖기 때문에 평균값 (1-5등까지 동률이니까 평균 3을 준다)
order(x) #원래 자료의 위치값

vector("complex",5) #벡터로 초기화
logical(3) #logical 벡터로 초기화
numeric(4) #numeric 벡터로 초기화
complex(5) #complex 벡터로 초기화
character(6) #character 벡터로 초기화

#3.3. 행렬
matr <-matrix(1:9,nrow=3)#3행 3열 행렬 생성
matr
length(matr)#원소 개수
mode(matr) #원소 형태
dim(matr) #행과 열의 개수

#matrix(data,nrow=,ncol=,byrow=FALSE, dimnames=NULL)
#cbind(벡터1,벡터2) 또는 rbind(벡터1,벡터2)
#dim(x) <-c(행의 개수, 열의 개수)

r1<-c(1,2,3)
r2<-c(4,5,6)
r3<-c(7,8,9)
rbind(r1,r2,r3)

c1 <- c(1:3)
c2 <- c(4:6)
c3 <- c(7:9)
cbind(c1,c2,c3) #열을 기준으로 경합

m1 <- 1:9
dim(m1)<-c(3,3) #dim:차원 지정
m1

#3.3.2. 행렬의 연산
#[]를 이용하여 행렬의 일부 원소를 추출 apply(행렬, 조건,fun) 함수를 이용한 
#행 또는 열의 연산 sweep(행렬, 조건,stats, fun=) 함수를 이용한 연산
x1 <- 1:9
dim(x1) <-c(3,3)
x1
mat <-matrix(c(1:9),ncol=3,byrow=T) #byrow=T 를 줌으로써 행 기준 3열의 행렬 생성 (디폴트는 열 방향)
mat
mat[1,] #1행의 값
mat[,2] #2열의 값
mat[mat[,3]>4,2] #3열에서 4보다 큰 행의 값 중 2열의 모든 값
mat[2,3] #2행 3열의 값 추출
height <-c(140, 155, 142, 175)
size.1 <- matrix(c(130,26,110,24,118,25,112,25), ncol=2, byrow=T,dimnames=list(c("Lee","Kim","Park","Choi"), c("Weight","Waist")))
size.1 <- cbind(size.1, height) #열 기준 결합
colmean <- apply(size.1,2,mean) #2: 열평균 계산
colmean
rowmean <- apply(size.1,1,mean) #행평균 계산
rowmean
colvar <- apply(size.1,2,var) #열의 분산값 계산
colvar
rowvar <- apply(size.1,1,var) #행의 분산값 계산
rowvar
sweep(size.1,2,colmean) #size 각 열의 값과 colmean 의 차 기본연산은 빼기로 되어 있음
sweep(size.1,1,rowmean) #size 각 행의 값과 rowmean 의 차
sweep(size.1,1,c(1,2,3,4), "+") #각 행의 값에 c(1,2,3,4)값을 더해줌
sweep(size.1,1,c(1,2,3,4),"-") #각 행에서 빼줌

#행렬 연산 관련 함수  
#전치행렬 t(a) 
#%*%행렬 곱 
#crossprod t(A)%*%B 
#outer(A,B) 외적 
#svd(A) singular value 분해 
#qr(A) QR 분해 
#solve(A,B) 방정식의 해 
#solve(A) 역행렬 
#eigen(A) 고유치와 고유벡터 
#chol(A) choleski 분해함수

m1 <- matrix(1:4, nrow=2) 
m1
m2 <- matrix(5:8, nrow=2)
m2
m1%*%m2
solve(m1) #역행렬
t(m1) #m1의 전치행렬 - 행과 열을 바꾼다

#3.4. 배열
#배열은 행렬의 확장으로 기본적인 성질이 행렬과 유사 
#array(data, dim=c(행 개수, 열 개수, 행렬 개수, dim.names=NULL) 
#dim(x) <-c(행의 개수, 열의 개수, 행렬의 개수)
                                   
arr <- array(1:24, dim=c(3,3,2)) #mnatrix 에서는 행렬 숫자가 딱 맞아야 되는데 array 는 좀 더 융통성 있음 
arr
dimnames(arr) <- list(paste("row", c(1:3)),paste("col",c(1:3)),paste("ar",c(1:2)))#각 차원의 이름을 지정
arr 
length(arr) #자료 개수 확인
mode(arr) #각 차원 벡터의 크기
dimnames(arr) #각 차원 리스트의 이름

array(1:6)
array(1:6, c(2,3))
array(1:8, c(2,2,2))
arr <- c(1:24) #이건 벡터 1차원 자료구조
dim(arr) <-c(3,4,2) #이건 배열이 됨 
arr

#3.4.2. 배열의 연산
ary1 <- array(1:8, dim=c(2,2,2))
ary2 <- array(8:1, dim=c(2,2,2))
ary1 + ary2 #원소별 연산 
ary1 * ary2 #배열의 곱셈
ary1 %*% ary2 #두 배열 원소들의 곱의 합 행렬일 때와 배열일 때와 다르다 
ary1[,,1] # 배열 원소의 추출/삭제
ary1[1,1,]
ary1[1,,-2]

#3.5. 리스트
#서로 다른 형태의 데이터로 구성된 객체. length, mode, names
a <- 1:10
b <- 11:15
klist <- list(vec1=a, vec2=b, descrip="example")
length(klist) #배열 까지는 개별 원소 개수 list 에서는 component 개수 세개 매우 중요 
mode(klist)
names(klist)
klist

clist <- list(a,b,"example")
length(clist)
mode(clist)
names(clist)
clist

list1 <- list("A", 1:8)
list1
list1[[3]]<-list(c(T,F))
list1
list1[[2]][9]<-9 #두번째 성분에 원소 추가
list1
list1[3]<-NULL #세번째 성분 삭제
list1[[2]] <-list1[[2]][-9] #두번째 성분의 9번째 원소 삭제
list1

a<-1:10
b<-11:15
nlist<-list(vec1=a,vec2=b,descrip="example")
nlist
nlist[[2]][5]
nlist$vec2[c(2,3)] #vec2의 두번째와 세번째 원소

#3.6. 데이터 프레임
#형태가 일반화된 행렬. 하나의 객체에 여러 종류의 자료가 들어갈 수 있음. 
#각 열은 각각 변수와 대응. 분석이나 모형설정에 적합
d2 <- read.table("story.txt", row.names='num', header=T) #num은 데이터의 num이라는 변수가 행 이름임을 나타냄 
d2
char1 <- rep(LETTERS[1:3],c(2,2,1)) #abc 를 두개 두개 하나 반복하라
char1
num1<-rep(1:3,c(2,2,1))
num1
test1<-data.frame(char1,num1)
test1
a1<-LETTERS[1:15]
a1
dim(a1)<-c(5,3)
a1
test3<-as.data.frame(a1) #문자형 행렬을 데이터프레임으로 변경 - 열번호 행번호가 사라지고 변수명과 각 케이스로 변환 
test3

#3.6.2. 데이터 프레임의 결합
cbind(test1,test3)
char1 <- rep(LETTERS[1:3],c(1,2,2))
char1
num1 <-rep(1:3,c(1,1,3))
num1
test4<-data.frame(char1,num1)
test4
rbind(test1,test4) #아래로 합친 형태
merge(test1,test4) 
#같은 변수에 대해 한번만 출력. 처음의 변수에 대해 알파벳 순서로 정렬이 되고 나머지 변수들이 옆으로 나열












































































