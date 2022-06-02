# ModMedTest
R package to run moderated mediation analysis using the mediation R package. For a binary moderator, this package runs the mediation analysis for 3 groups: all, moderator==0, and moderator==1. In addition, the test of the moderated direct and indirect effects are performed.  

## Installation
```
install.packages("devtools") # devtools must be installed first
install.packages("mediation") # mediation must be installed first

devtools::install_github("SharonLutz/ModMedTest")
```

## Example
For this example with 1000 subjects (input:n), the exposure X is generated to be 0,1,2 (input X). The moderator is binary (input: Mo). The mediator (input:Me) is generated from a normal distribution as a function of the exposure (X) and moderator (MO). The outcome Y (input:Y) is  generated as a function of the exposure (X), moderator (Mo), and mediator (Me). 3 covariates (input:Cov) are generated from a normal distribution. MeCont=TRUE and Ycont=TRUE because the mediator and outcomes are continuous.

```
library(ModMedTest)

n<-1000
X=rbinom(n,2,0.5)
Mo<-rbinom(n,1,0.5)
Me<-rnorm(n,mean=(X*0.5+Mo*0.5))
Y = rnorm(n,mean=(X*0.5*Mo+Me*0.5))
Cov<-(cbind(rnorm(n),rnorm(n),rnorm(n)))
Cov <- as.matrix(Cov)

ModMedTest(X=X, Mo=Mo, Me=Me, MeCont=TRUE, Ycont=TRUE, 
Y = Y,Cov=Cov, seedset=1, nBoot=200)
```

## Output
The output gives the beta, confidence interval and p-value for the indirect, direct, and total effects for all subjects, moderator==0, and moderator==1. The last 2 rows test the moderated indirect and direct effects.
```
[[1]]
      method           beta                  CI_Lower              CI_Upper             pvalue
 [1,] "medAllIndirect" "0.292764298660755"   "0.244690129724609"   "0.349043718707872"  "0"   
 [2,] "medAllDirect"   "0.27529448381099"    "0.172779579073123"   "0.374556793111455"  "0"   
 [3,] "medAllTotal"    "0.568058782471745"   "0.467001789763911"   "0.675340532873967"  "0"   
 [4,] "medMo0Indirect" "0.244795449168569"   "0.171359018682888"   "0.330971103406291"  "0"   
 [5,] "medMo0Direct"   "0.0333778994516747"  "-0.0903661016785465" "0.150339662443659"  "0.73"
 [6,] "medMo0Total"    "0.278173348620243"   "0.142726956750542"   "0.387779304150516"  "0"   
 [7,] "medMo1Indirect" "0.328320573973207"   "0.246265270872772"   "0.409765278096648"  "0"   
 [8,] "medMo1Direct"   "0.507215394950678"   "0.394032082559287"   "0.643817417860877"  "0"   
 [9,] "medMo1Total"    "0.835535968923885"   "0.709542728130224"   "0.949105307159415"  "0"   
[10,] "modMedIndirect" "-0.0841114951814884" "-0.203267151911546"  "0.0294393571071484" "0.11"
[11,] "modMedDirect"   "-0.471258615964704"  "-0.647942072918113"  "-0.274148056290907" "0"   
```
## Moderated Mediation Resources
Consider the following tutorials for mediation and moderated mediation analyses:

Mediation analysis [tutorial](https://data.library.virginia.edu/introduction-to-mediation-analysis/)

Moderated mediation analysis [tutorial](https://data.library.virginia.edu/getting-started-with-moderated-mediation/)

Moderated mediation analysis [tutorial](https://ademos.people.uic.edu/Chapter15.html) with sem
