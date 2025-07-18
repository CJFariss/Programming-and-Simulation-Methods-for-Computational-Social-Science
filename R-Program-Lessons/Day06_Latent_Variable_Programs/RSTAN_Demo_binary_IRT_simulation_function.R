## RSTAN_Demo_binary_IRT_simulation_function.R
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
##For this R tutorial we will simulate some number of binary dependent variables or items and then estimate the units-specific parameters (the latent variable) and item-specific parameters (the difficulty and discrimination parameters) that generate the variable.
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
    real<lower=0> beta[j];
    vector[n] theta;
}
transformed parameters {
    
}
model {
    // priors (these are variances not precision)
    //theta ~ std_normal(); //priors on latent variable
    theta ~ normal(0,1); //priors on latent variable
    
    alpha ~ normal(0,10); //priors for the intercepts/difficulty (these are variances not precision)
    beta ~ normal(0,10); // priors for the slope/discrimination. This is truncated so that the lowest possible value is 0
    
    // likelihood (link data to some combination of parameters and more data)
    // one equation for each of the observed items
   
   for(h in 1:j){
     y[,h] ~ bernoulli_logit(alpha[h] + beta[h] * theta);
   }
}
"
## -------------------------------------------------- #

## simulated data
n <- 1000
theta <- rnorm(n,0,1) ## standard normal latent estimand (it's an estimand because we cannot actually observe this)

## set parameters for each item
## alpha (the intercept) is the difficulty parameter or base-line probability of 1
## beta (the slope) is the discrimination parameter or the strength of the relationship
## between the estimated latent trait theta and the individual item
binary_item_func <- function(a, b, x){
  beta <- b
  alpha <- beta*a ## rescale alpha to "anchor" beta
  xb <- alpha + beta * x
  prob <- 1 / (1 + exp(-xb))
  return(rbinom(n, size=1, prob=prob))
}

## item responses
y1 <- binary_item_func(a=-1.0, b=2.0, x=theta)
y2 <- binary_item_func(a=0.0, b=2.0, x=theta)
y3 <- binary_item_func(a=1.0, b=2.0, x=theta)
y4 <- binary_item_func(a=-2.0, b=2.0, x=theta)
y5 <- binary_item_func(a=2.0, b=2.0, x=theta)
y6 <- binary_item_func(a=--3.0, b=2.0, x=theta)
y7 <- binary_item_func(a=3.0, b=2.0, x=theta)
y8 <- binary_item_func(a=-1.5, b=2.0, x=theta)
y9 <- binary_item_func(a=1.5, b=2.0, x=theta)
y10 <- binary_item_func(a=0.0, b=2.0, x=theta)



## create matrix of observed items
y <- cbind(y1, y2, y3, y4, y5, y6, y7, y8, y9, y10)

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

## this prints the posterior mean for the latent variable
apply(output$theta,2,mean)


## calculate the mean the posterior for the latent variable
latentmean <- apply(output$theta,2,mean)

## plot true latent variable with posterior mean
par(mfrow=c(1,1), mar=c(4,4,1,1), font=2, font.lab=2, cex=1.3)
plot(latentmean, theta, xlim=c(-3,3), ylim=c(-3,3), ylab="true theta", xlab="posterior mean of theta")
abline(a=0, b=1, col=2, lwd=2)

MASS::truehist(latentmean)

## correlate the true latent variable and the additive scale
cor(theta,(y1+y2+y3), method="spearman")

## correlate the estimated latent variable and the additive scale
cor(latentmean,(y1+y2+y3), method="spearman")

## correlate the estimated latent variable and the true latent variable
cor(latentmean,theta, method="spearman")

## how do these correlations compare when the true alpha parameters are spaced equally from one another and when they are not?


