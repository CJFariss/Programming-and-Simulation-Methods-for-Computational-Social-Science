#### R_Demo_Simulation_Inference_2_Sample_Hold_out.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Programming and Simulation Methods for Computational Social Science (1T, 2W)
## University of Essex Summer School 2025
##
## Date: 2025-07-10
##
## Please e-mail me if you find any errors or have and suggestions (either email is fine)
## e-mail: cjf0006@gmail.com
## e-mail: cjfariss@umich.edu
##########################################################################
##
## Goal: Improve the predictive power or predictive validity of a model
##
##########################################################################
## Introduction to tutorial:
##
## (1) Begin building towards and learning about cross-validation
## (NOTE: There is no "crossing" yet)
##
## For this R tutorial we will simulate a dataset and then randomly divide it into two subsets.
##
## We will fit a model using the observations from one of the subsets of data (training data).
##
## We will then use the model estimates to predict the value of the dependent variable for the remaining out-of-sample data subset (testing data).
##
##########################################################################


#set.seed(940)

in_sample_rmse <- rmse <- rmse_2foldcross <- c()
in_sample_rmse
rmse
rmse_2foldcross

for(i in 1:10000){

  ## set number of observations for simulation
  n <- 100
  
  ## simulation of variables (This model is one of Anscombe's quartets)
  x <- sample(4:14,n,replace=TRUE)
  table(x)
  y <- -5.996 + 2.781*x -0.127*x^2 + rnorm(n,0,1)
  #y <- -5.996 + 2.781*x -0.127*x^2 + rnorm(n,0,2)
  
  ## plot the simulated relationship
  #par(mfrow=c(1,1))
  #plot(x=x, y=y)
  
  
#for(i in 1:1000){
  ## create a subject/unit ID variable with one values for each unit
  ## here the indicator values takes on 2-Fold values {1,2}
  folds <- sample(1:2, size=n, replace=TRUE)
  table(folds)
  
  folds <- sample(rep(1:2, n/2), size=n, replace=FALSE)
  folds
  table(folds)
  length(folds)
  
  ## doesn't always yield 50/50 ratio of 1s and 2s
  #folds <- sample(1:2, size=n, replace=TRUE)
  #folds
  #table(folds)
  
  ## create a data frame with the dependent variable, independent variable, and randomly created ID
  dat <- data.frame(y, x, folds)
  
  summary(dat)
  
  head(dat)
  
  ## fit a linear model to the full dataset
  model <- lm(y ~ x, data=dat)
  summary(model)
  
  
  ## subset the full dataset into to subsets based on the ID variable
  train <- subset(dat, folds==1)
  test <- subset(dat, folds==2)
  
  train <- dat[dat$folds==1,]
  test <- dat[dat$folds==2,]
  
  nrow(train)
  nrow(test)
  
  
  ## Model 2: fit a linear model with a squared term
  fit <- lm(y ~ x + I(x^2), data=train)
  in_sample_rmse[i] <- sqrt(mean((as.numeric(predict(fit))-train$y)^2))
  #in_sample_rmse
  
  pred <- predict(fit, newdata=test)
  rmse[i] <- sqrt(mean((as.numeric(pred)-test$y)^2))
  #rmse
  
  for(j in 1:2){
    fit <- lm(y ~ x + I(x^2), data=subset(dat, folds!=j))
    pred <- predict(fit, newdata=subset(dat, folds==j))
    dat$y.hat[dat$fold==j] <- as.numeric(pred)
  }
  rmse_2foldcross[i] <- sqrt(mean((dat$y.hat-dat$y)^2))
  
  
}

boxplot(in_sample_rmse, rmse, rmse_2foldcross, xaxt="n")
abline(h=1, col=2)
axis(side=1, at=1:3, labels=c("in sample", "out of sample \nno crossing", "out of sample \ncrossing"))

plot(density(in_sample_rmse), col=2, xlim=c(.5,1.5))
lines(density(rmse), col=4)
lines(density(rmse_2foldcross), col=5)

