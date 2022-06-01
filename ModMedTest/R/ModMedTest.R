ModMedTest <-
function(X,Y, Me, Mo, Cov, Ycont, MeCont, seedset=1, nBoot=200){
  
  # load library
  library(mediation)
  # set seed
  set.seed(seedset)

  # Error checks
  if(any(Mo<0) | any(Mo>1)){stop("Moderator must be binary variable (coded 0/1)")}
  if(nrow(Cov) != length(X)){stop("Covariate matrix must be the same length as vector X")}
  if(nrow(Cov) != length(Y)){stop("Covariate matrix must be the same length as vector Y")}
  if(nrow(Cov) != length(Me)){stop("Covariate matrix must be the same length as the mediator Me")}
  if(nrow(Cov) != length(Mo)){stop("Covariate matrix must be the same length as the moderator Mo")}
  if(Ycont==F & (any(Y<0) | any(Y>1))){stop("If Y is not continuous, then it must be coded as 0/1")}
  if(MeCont==F & (any(Me<0) | any(Me>1))){stop("If the mediator Me is not continuous, then it must be coded as 0/1")}
  if(nBoot<0 | nBoot==0 | floor(nBoot)!=ceiling(nBoot) ){stop("nBoot must be an integer greater than 0")}

  # create matrix to save results
  matR <- matrix(NA, ncol=5, nrow=11)
  colnames(matR) <- c("method", "beta", "CI_Lower", "CI_Upper", "pvalue")
  
  # fill in methods column of matrix
  matR[,"method"] <- c("medAllIndirect", "medAllDirect", "medAllTotal", 
                        "medMo0Indirect", "medMo0Direct", "medMo0Total",
                        "medMo1Indirect","medMo1Direct", "medMo1Total",
                        "modMedIndirect", "modMedDirect")
  
  
  # Mediation ??? DO WE STILL WANT MODERATOR HERE AS COVARIATE?
  if(Ycont==T){
    modelY <- lm(Y ~ Me+X+Mo+Cov)}
  if(Ycont==F){
  modelY <- glm(Y ~ Me+X+Mo+Cov, family=binomial(link="logit"))}
  
  if(MeCont==T){
  modelM <- lm(Me ~ X+Mo+Cov)}
  if(MeCont==F){
    modelM <- glm(Me ~ X+Mo+Cov, family=binomial(link="logit"))}
  
  medAll <- mediate(model.m=modelM, model.y=modelY, mediator = "Me", treat="X", sims=nBoot, boot=T)
  matR[1,"beta"] <- medAll$d.avg
  matR[2, "beta"] <- medAll$z.avg
  matR[3, "beta"] <- medAll$tau.coef
  
  matR[1, "CI_Lower"] <- medAll$d.avg.ci[1]
  matR[2,"CI_Lower"] <- medAll$z.avg.ci[1]
  matR[3,"CI_Lower"] <- medAll$tau.ci[1]
  
  matR[1, "CI_Upper"] <- medAll$d.avg.ci[2]
  matR[2,"CI_Upper"] <- medAll$z.avg.ci[2]
  matR[3,"CI_Upper"] <- medAll$tau.ci[2]
  
  matR[1, "pvalue"] <- medAll$d.avg.p
  matR[2,"pvalue"] <- medAll$z.avg.p
  matR[3,"pvalue"] <- medAll$tau.p
  
  
  # Mediation stratified by moderator -- 0
  Y0 <- Y[Mo==0]
  X0 <- X[Mo==0]
  
  Me0 <- Me[Mo==0]
  Cov0 <- Cov[Mo==0,]
  
  
  if(Ycont==T){
    modelY0 <- lm(Y0 ~ Me0+X0+Cov0)}
  if(Ycont==F){
    modelY0 <- glm(Y0 ~ Me0+X0+Cov0, family=binomial(link="logit"))}
  
  if(MeCont==T){
    modelM0 <- lm(Me0 ~ X0+Cov0)}
  if(MeCont==F){
    modelM0 <- glm(Me0 ~ X0+Cov0, family=binomial(link="logit"))}
  
  
  med0 <- mediate(model.m=modelM0, model.y=modelY0, mediator = "Me0", treat="X0", sims=nBoot, boot=T)
  matR[4,"beta"] <- med0$d.avg
  matR[5, "beta"] <- med0$z.avg
  matR[6, "beta"] <- med0$tau.coef
  
  matR[4, "CI_Lower"] <- med0$d.avg.ci[1]
  matR[5,"CI_Lower"] <- med0$z.avg.ci[1]
  matR[6,"CI_Lower"] <- med0$tau.ci[1]
  
  matR[4, "CI_Upper"] <- med0$d.avg.ci[2] 
  matR[5,"CI_Upper"] <- med0$z.avg.ci[2]
  matR[6,"CI_Upper"] <- med0$tau.ci[2]
  
  matR[4, "pvalue"] <- med0$d.avg.p
  matR[5,"pvalue"] <- med0$z.avg.p
  matR[6,"pvalue"] <- med0$tau.p
  


  # Mediation stratified by moderator -- 1
  
  Y1 <- Y[Mo==1]
  X1 <- X[Mo==1]
  
  Me1 <- Me[Mo==1]
  Cov1 <- Cov[Mo==1,]
  
  if(Ycont==T){
    modelY1 <- lm(Y1 ~ Me1+X1+Cov1)}
  if(Ycont==F){
    modelY1 <- glm(Y1 ~ Me1+X1+Cov1, family=binomial(link="logit"))}
  
  if(MeCont==T){
    modelM1 <- lm(Me1 ~ X1+Cov1)}
  if(MeCont==F){
    modelM1 <- glm(Me1 ~ X1+Cov1, family=binomial(link="logit"))}
  
  
  med1 <- mediate(model.m=modelM1, model.y=modelY1, mediator = "Me1", treat="X1", sims=nBoot, boot=T)
  matR[7,"beta"] <- med1$d.avg
  matR[8, "beta"] <- med1$z.avg
  matR[9, "beta"] <- med1$tau.coef
  
  matR[7, "CI_Lower"] <- med1$d.avg.ci[1]
  matR[8,"CI_Lower"] <- med1$z.avg.ci[1]
  matR[9,"CI_Lower"] <- med1$tau.ci[1]
  
  matR[7, "CI_Upper"] <- med1$d.avg.ci[2] 
  matR[8,"CI_Upper"] <- med1$z.avg.ci[2]
  matR[9,"CI_Upper"] <- med1$tau.ci[2]
  
  matR[7, "pvalue"] <- med1$d.avg.p
  matR[8,"pvalue"] <- med1$z.avg.p
  matR[9,"pvalue"] <- med1$tau.p
  
  
  # We mean center our IV and moderator because we have interactions terms in the remaining regression analyses
  X <- scale(X, center=T, scale=F)
  Mo <- scale(Mo, center=T, scale=F)
  X <- as.vector(X)
  Mo <- as.vector(Mo)

  
  if(MeCont==T){
    Mod.Med.Model.1<-lm(Me~X+Mo+X*Mo+Cov)   
  }
  if(MeCont==F){
    Mod.Med.Model.1<-glm(Me~X+Mo+X*Mo+Cov, family=binomial(link="logit"))   
  }
  
  
  if(Ycont==T){
    Mod.Med.Model.2<-lm(Y ~ X+Mo+X*Mo+Me+Me*Mo+Cov) 
  }
  if(Ycont==F){
  Mod.Med.Model.2<-glm(Y ~ X+Mo+X*Mo+Me+Me*Mo+Cov, family=binomial(link="logit")) 
  }
  
  #moderator for Mo=0. 
  Mo.low<-min(Mo)
  # moderator for Mo=1
  Mo.high<-max(Mo)
  
  # tests if difference between indirect effects at each level of the moderator is significantly different from zero
  Mod.Med.TestMod <- mediate(Mod.Med.Model.1, Mod.Med.Model.2, boot = TRUE,  
                             boot.ci.type = "bca", sims = nBoot, treat="X", mediator="Me")  
  
  ModMedRes <- test.modmed(Mod.Med.TestMod, covariates.1 = list(Mo = Mo.low),   
                    covariates.2 = list(Mo = Mo.high), sims = nBoot)
  ModMedRes.acme <- ModMedRes[[1]]
  ModMedRes.ade <- ModMedRes[[2]]
  
  
  matR[10, "beta"] <- ModMedRes.acme$statistic
  matR[11, "beta"] <- ModMedRes.ade$statistic
  
  matR[10, "CI_Lower"] <- ModMedRes.acme$conf.int[1]
  matR[11, "CI_Lower"] <- ModMedRes.ade$conf.int[1]
  
  matR[10, "CI_Upper"] <- ModMedRes.acme$conf.int[2]
  matR[11, "CI_Upper"] <- ModMedRes.ade$conf.int[2]
  
  matR[10, "pvalue"] <- ModMedRes.acme$p.value
  matR[11, "pvalue"] <- ModMedRes.ade$p.value 

  matR_list <- list(matR)
  return(matR_list)
  
}
