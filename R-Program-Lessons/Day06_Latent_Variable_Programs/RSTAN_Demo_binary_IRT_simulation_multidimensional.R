## RSTAN_Demo_binary_IRT_simulation.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Programming and Simulation Methods for Computational Social Science (1T, 2W)
## University of Essex Summer School 2025
##
## Date: 2025-07-15
##
## Please e-mail me if you find any errors or have and suggestions
## e-mail: cjf0006@gmail.com
## e-mail: cjfariss@umich.edu
##
##########################################################################
##
## Introduction to tutorial:
##
##For this R tutorial we will simulate 3 binary dependent variables or items and then estimate the units-specific parameters (the latent variable) and item-specific parameters (the difficulty and discrimination parameters) that generate the variable.
##
## In the IRT framework, there is a latent trait theta_i.
## Where the subscript i = 1,... ,N indicates multiple units. y_ij is the observed value for item j for unit i. For each item alpha_j and beta_j are also estimated. alpha_j continues to act as "difficulty" parameters, or threshold that benchmarks how likely an indicator is to be observed relative to the values of the latent trait.  In this formulation, this is analogous to an intercept in a traditional logistic regression model.  beta_j, often referred to as the "discrimination" parameters and is the analogue of a slope coefficient.
##
##########################################################################

## load library
library(rstan) # load rstan library
library(MASS) # load library with truehist function

## -------------------------------------------------- ##
## define STAN model
## -------------------------------------------------- ##
model <- "
data {
    // declared the data in memory
    int<lower=0> n;
    int<lower=0> j;
    int<lower=0, upper=1> y[n,j];
}
parameters {
    // declared the parameters in memory
    vector[j] alpha;
    real<lower=0> beta1[j];
    //vector[n] theta1;
    real<lower=0> beta2[j];
    //vector[n] theta2;
    vector[2] theta[n];
    //real beta1_raw[j];
    //real beta2_raw[j];

}
transformed parameters {
    vector[n] theta1;
    vector[n] theta2;
    //real beta1[j];
    //real beta2[j];
    
    // single parameter identification constraint
    //beta[1] = abs(beta_raw[1]);
    //for(k in 2:j){
    //  beta[k] = beta_raw[k];
    //}

    vector[2] mu;
    cov_matrix[2] Sigma;
    mu[1] = 0;
    mu[2] = 0;
    Sigma[1,1] = 1;
    Sigma[2,2] = 1;
    Sigma[1,2] = 0;
    Sigma[2,1] = 0;
    
    for(i in 1:n){
      theta1[i] = theta[i,1];
      theta2[i] = theta[i,2];
    }
    
}
model {
    // priors (these are variances not precision)
    //theta ~ std_normal(); //priors on latent variable
    //theta1 ~ normal(0,1); //priors on latent variable
    //theta2 ~ normal(0,1); //priors on latent variable
    theta ~ multi_normal(mu, Sigma);

    alpha ~ normal(0,10); //priors for the intercepts/difficulty (these are variances not precision)
    //beta1 ~ normal(0,1); // priors for the slope/discrimination. This is truncated so that the lowest possible value is 0
    //beta2 ~ normal(0,1); // priors for the slope/discrimination. This is truncated so that the lowest possible value is 0
    beta1 ~ gamma(0.01,0.01);
    beta2 ~ gamma(0.01,0.01);
    
    // likelihood (link data to some combination of parameters and more data)
    // one equation for each of the observed items
   
   for(h in 1:j){
     y[,h] ~ bernoulli_logit(alpha[h] + beta1[h] * theta1 + beta2[h] * theta2);
   }
}
"
## -------------------------------------------------- #

## simulated data
n <- 1000
theta1 <- rnorm(n,0,1) ## standard normal latent estimand (it's an estimand because we cannot actually observe this)
theta2 <- rnorm(n,0,1) ## standard normal latent estimand (it's an estimand because we cannot actually observe this)

plot(theta1, theta2)

## set parameters for each item
## alpha (the intercept) is the difficulty parameter or base-line probability of 1
## beta (the slope) is the discrimination parameter or the strength of the relationship
## between the estimated latent trait theta and the individual item

binary_item_func <- function(a, b, x){
  beta <- b
  alpha <- beta*a ## rescale alpha to anchor beta
  xb <- alpha + beta * x
  prob <- 1 / (1 + exp(-xb))
  return(rbinom(n, size=1, prob=prob))
}

## item responses
y1 <- binary_item_func(a=-1.0, b=2.0, x=theta1)
y2 <- binary_item_func(a=0.0, b=2.0, x=theta1)
y3 <- binary_item_func(a=1.0, b=2.0, x=theta1)
y4 <- binary_item_func(a=-2.0, b=2.0, x=theta1)
y5 <- binary_item_func(a=2.0, b=2.0, x=theta1)
y6 <- binary_item_func(a=--3.0, b=2.0, x=theta1)
y7 <- binary_item_func(a=3.0, b=2.0, x=theta1)
y8 <- binary_item_func(a=-1.5, b=2.0, x=theta1)
y9 <- binary_item_func(a=1.5, b=2.0, x=theta1)
y10 <- binary_item_func(a=0.0, b=2.0, x=theta1)
y11 <- binary_item_func(a=-1.0, b=2.0, x=theta2)
y12 <- binary_item_func(a=0.0, b=2.0, x=theta2)
y13 <- binary_item_func(a=1.0, b=2.0, x=theta2)
y14 <- binary_item_func(a=-2.0, b=2.0, x=theta2)
y15 <- binary_item_func(a=2.0, b=2.0, x=theta2)
y16 <- binary_item_func(a=--3.0, b=2.0, x=theta2)
y17 <- binary_item_func(a=3.0, b=2.0, x=theta2)
y18 <- binary_item_func(a=-1.5, b=2.0, x=theta2)
y19 <- binary_item_func(a=1.5, b=2.0, x=theta2)
y20 <- binary_item_func(a=0.0, b=2.0, x=theta2)



## create matrix of observed items
y <- cbind(y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20)

## define j as the number of items
j <- ncol(y)

## create data list with each of the observed items
data_list <- list(y=y, j=j, n=n)

## fit stan model
fit <- stan(model_code = model, data = data_list, iter = 2000, chains = 4, cores=4)

## this summarizes the named parameters but not along the dimensions
fit

## extract draws from stan model object
output <- extract(fit, permuted = TRUE)

## print names
names(output)

## betas
apply(output$beta1,2,mean)
apply(output$beta2,2,mean)

## this prints the posterior mean for the latent variable
#apply(output$theta1,2,mean)


## calculate the mean the posterior for the latent variable
latentmean1 <- apply(output$theta1,2,mean)
latentmean2 <- apply(output$theta2,2,mean)

cor(latentmean1, theta1)
cor(latentmean2, theta2)

## plot true latent variable with posterior mean
par(mfrow=c(1,2), mar=c(4,4,1,1), font=2, font.lab=2, cex=1.3)
plot(latentmean1, theta1, xlim=c(-3,3), ylim=c(-3,3), ylab="true theta", xlab="posterior mean of theta")
abline(a=0, b=1, col=2, lwd=2)

## plot true latent variable with posterior mean
plot(latentmean2, theta2, xlim=c(-3,3), ylim=c(-3,3), ylab="true theta", xlab="posterior mean of theta")
abline(a=0, b=1, col=2, lwd=2)

#MASS::truehist(latentmean)

par(mfrow=c(1,1))
plot(theta1, theta2)
plot(latentmean1, latentmean2)

plot(latentmean1, apply(cbind(y1,y2,y3,y4,y5,y6,y7,y8,y9,y10), 1, sum))
plot(latentmean2, apply(cbind(y11,y12,y13,y14,y15,y16,y17,y18,y19,y20), 1, sum))


cor(theta1, theta2)
cor(apply(cbind(y1,y2,y3,y4,y5,y6,y7,y8,y9,y10), 1, sum),  apply(cbind(y11,y12,y13,y14,y15,y16,y17,y18,y19,y20), 1, sum))


df <- data.frame(y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15,y16,y17,y18,y19,y20)
fit <- factanal(df, factors=2, scores="regression")
fit
cor(fit$scores)


fit <- factanal(df, factors=3, scores="regression")
fit
cor(fit$scores)


fit <- factanal(df, factors=4, scores="regression")
fit
cor(fit$scores)
