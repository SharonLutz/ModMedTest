# ModMedTest
R package to run moderated mediation analysis

## Installation
```
install.packages("devtools") # devtools must be installed first
install.packages("mediation") # mediation must be installed first

devtools::install_github("SharonLutz/ModMedTest")
```

## Example
```
library(ModMedTest)

n<-1000
X=rbinom(n,2,0.5)
Mo<-rbinom(n,1,0.5)
Me<-rnorm(n,mean=(X*0.5+Mo*0.5))
Y = rnorm(n,mean=(X*0.5+Me*0.5))
Cov<-(cbind(rnorm(n),rnorm(n),rnorm(n)))
Cov <- as.matrix(Cov)

ModMedTest(X=X, Mo=Mo, Me=Me, MeCont=TRUE, Ycont=TRUE, Y = Y,Cov=Cov, seedset=1, nBoot=200)
```

## Moderated Mediation Resources
For more details on moderated mediation analysis, see this full [tutorial](https://ademos.people.uic.edu/Chapter15.html) for running moderated mediation analyses in R. 
