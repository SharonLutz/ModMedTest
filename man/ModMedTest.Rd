\name{ModMedTest}
\alias{ModMedTest}
\title{ModMedTest}
\description{
The ModMedTest package runs the ModMedTest function to run mediation, mediation stratified by the moderator, and moderated mediation.
}
\usage{
ModMedTest(X, Y, Me, Mo, Cov, Ycont, MeCont, seedset = 1, nBoot = 200)
}
\arguments{
  \item{X}{
is a vector for the exposure.
}
  \item{Y}{
is a vector for the outcome.
}
  \item{Me}{
is a vector for the mediator.
}
  \item{Mo}{
is a vector of binary values for the moderator.
}
  \item{Cov}{
is a matrix with the covariates.
}
  \item{Ycont}{
is true if Y (the outcome) is continuous, and false if Y is binary.
}
  \item{MeCont}{
is true if Me (the mediator) is continuous, and false if Me is binary.
}
  \item{seedset}{
sets the seed used for the random generator.
}
  \item{nBoot}{
is the number of bootstrap samples.
}
}

\value{
A matrix of the results is returned which includes the betas, 95\% confidence intervals, and p-values for the direct, indirect, and total effects from the different analyses. The results are saved for the following methods: (1) medAllInd, indirect effects results for mediation; (2) medAllDir, direct effects results for mediation; (3) medAllTot, total effects results for mediation; (4) medMo0Ind, indirect effects results for stratified mediation where moderator=0; (5) medMo0Dir, direct effects results for stratified mediation where moderator=0; (6) medMo0Tot, total effects results for stratified emdiation where moderator=0; (7) medMo1Ind, indirect effects results for stratified mediation where moderator=1; (8) medMo1Dir, direct effects results for stratified mediation where moderator=1; (9) medMo1Tot, total effects results for stratified mediation where moderator=1; (10) modMedInd, indirect effect moderated mediation results; (11) modMedDir, durect effect moderated mediation results.
}
\author{
Sharon Lutz, Kirsten Voorhies
}

\section{Warning}{library(mediation) is required to run this function.}

\examples{
n<-1000
X=rbinom(n,2,0.5)
Mo<-rbinom(n,1,0.5)
Me<-rnorm(n,mean=(X*0.5+Mo*0.5))
Y = rnorm(n,mean=(X*0.5+Me*0.5))
Cov<-(cbind(rnorm(n),rnorm(n),rnorm(n)))
Cov <- as.matrix(Cov)

ModMedTest(X=X, Mo=Mo, Me=Me, MeCont=TRUE, Ycont=TRUE, Y = Y,Cov=Cov, seedset=1, nBoot=20)

}

\keyword{ mediation }
