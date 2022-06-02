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

ModMedTest(X=X, Mo=Mo, Me=Me, MeCont=TRUE, Ycont=TRUE, 
Y = Y,Cov=Cov, seedset=1, nBoot=200)
```

## Output
```
[[1]]
      method           beta                  CI_Lower             CI_Upper             pvalue
 [1,] "medAllIndirect" "0.225442629357247"   "0.172778090769303"  "0.273434634492271"  "0"   
 [2,] "medAllDirect"   "0.459797205769818"   "0.375020707674902"  "0.557797408078059"  "0"   
 [3,] "medAllTotal"    "0.685239835127065"   "0.589783266170161"  "0.791653151609749"  "0"   
 [4,] "medMo0Indirect" "0.186241734703317"   "0.121898260411882"  "0.264270809702984"  "0"   
 [5,] "medMo0Direct"   "0.412241650996413"   "0.304619663445055"  "0.512159568446631"  "0"   
 [6,] "medMo0Total"    "0.59848338569973"    "0.486196964379987"  "0.710201203579402"  "0"   
 [7,] "medMo1Indirect" "0.263229228096292"   "0.201953323080154"  "0.355607834735026"  "0"   
 [8,] "medMo1Direct"   "0.50139195398143"    "0.361839172229264"  "0.606026393275425"  "0"   
 [9,] "medMo1Total"    "0.764621182077722"   "0.62841353895731"   "0.883287787336192"  "0"   
[10,] "modMedIndirect" "-0.0785460793831936" "-0.181381435861888" "0.0193046993111424" "0.12"
[11,] "modMedDirect"   "-0.0881558980701554" "-0.279244279732008" "0.100723720530605"  "0.27"
```
## Moderated Mediation Resources
Consider the following tutorials:

Mediation analysis [tutorial](https://data.library.virginia.edu/introduction-to-mediation-analysis/)

Moderated mediation analysis [tutorial](https://data.library.virginia.edu/getting-started-with-moderated-mediation/)

Moderated mediation analysis [tutorial](https://ademos.people.uic.edu/Chapter15.html) with sem
