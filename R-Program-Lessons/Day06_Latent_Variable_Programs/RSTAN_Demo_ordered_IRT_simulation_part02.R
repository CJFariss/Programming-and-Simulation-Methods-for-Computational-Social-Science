## RSTAN_Demo_ordered_IRT_simulation_part02.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Programming and Simulation Methods for Computational Social Science (2W)
## University of Essex Summer School 2024
##
## Date: 2024-07-22
##
## Please e-mail me if you find any errors or have and suggestions
## e-mail: cjf0006@gmail.com
##
##########################################################################
##
## Introduction to tutorial:
##
##For this R tutorial we will simulate 3 binary dependent variables or items and then estimate the units-specific parameters (the latent variable) and item-specific parameters (the difficulty and discrimiation parameters) that generate the variable.
##
## In the Ordered IRT (OIRT!) framework, there is a latent trait theta_i.
## Where the subscript i = 1,... ,N indicates multiple units. y_ij is the observed value for item j for unit i. For each item thresholds or cutpoints_j and beta_j are also estimated. alpha_j continues to act as "difficulty" parameters, or threshold that benchmarks how likely an indicator is to be observed relative to the values of the latent trait.  In this formulation, this is analogous to an intercept in a traditional logistic regression model.  beta_j, often referred to as the "discrimination" parameters and is the analogue of a slope coefficient.
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
    //int<lower=1> y[n,j];  // note this is a matrix
    int<lower=1, upper=3> y1[n];
    int<lower=1, upper=3> y2[n];
    int<lower=1, upper=3> y3[n];
    int<lower=1, upper=3> y4[n];
    int<lower=1, upper=4> y5[n];
}
parameters {
    // declared the parameters in memory
    ordered[2] cut_points[j]; // this is the ordered variable type
    ordered[3] cut_points_3levels[1]; // this is the ordered variable type
    real<lower=0> beta[j];
    real<lower=0> beta_3levels[1];
    vector[n] theta;
}
transformed parameters {
    
}
model {
    // priors (these are variances not precision)
    theta ~ normal(0,1); //priors on latent variable
    cut_points[1] ~ normal(0,10);
    cut_points[2] ~ normal(0,10);
    cut_points[3] ~ normal(0,10);
    cut_points[4] ~ normal(0,10);
    cut_points_3levels[1] ~ normal(0,10);
    
    // discrimination parameters
    beta ~ normal(0,10);
    beta_3levels ~ normal(0,10);
    
    // likelihood (link data to some combination of parameters and more data)
    // one equation for each of the observed items
    y1 ~ ordered_logistic(beta[1] * theta, cut_points[1]);
    y2 ~ ordered_logistic(beta[2] * theta, cut_points[2]);
    y3 ~ ordered_logistic(beta[3] * theta, cut_points[3]);
    y4 ~ ordered_logistic(beta[4] * theta, cut_points[4]);
    y5 ~ ordered_logistic(beta_3levels[1] * theta, cut_points_3levels[1]);
}
"
## -------------------------------------------------- #

# Load packages
library(rstan)


# simulate the latent variable x
# and set the "true" population values for the alphas and betas
n <- 300
theta <- rnorm(n,0,1)

## discrimination parameters
beta1 <- 3.000000
beta2 <- 3.000000
beta3 <- 3.000000
beta4 <- 3.000000

## cutpoint parameters
alpha1.1 <- -4.000000
alpha1.2 <- -1.000000
alpha2.1 <- -2.00000
alpha2.2 <- 0.500000
alpha3.1 <- -1.5000000
alpha3.2 <- 1.5000000
alpha4.1 <- 0.000000
alpha4.2 <- 1.000000

# define j as the number of items
j <- 4

# linear terms of the model
xb1.1 <- alpha1.1 - beta1 * theta
xb1.2 <- alpha1.2 - beta1 * theta
xb2.1 <- alpha2.1 - beta2 * theta
xb2.2 <- alpha2.2 - beta2 * theta
xb3.1 <- alpha3.1 - beta3 * theta
xb3.2 <- alpha3.2 - beta3 * theta
xb4.1 <- alpha4.1 - beta4 * theta
xb4.2 <- alpha4.2 - beta4 * theta

xb5.1 <- -1.5 - 3 * theta
xb5.2 <- 0 - 3 * theta
xb5.3 <- 1.5 - 3 * theta

# transform the linear xb terms using the logit function
# so that theta is bound from 0 to 1
eta1.1 <- 1 / (1 + exp(-xb1.1))
eta1.2 <- 1 / (1 + exp(-xb1.2))
eta2.1 <- 1 / (1 + exp(-xb2.1))
eta2.2 <- 1 / (1 + exp(-xb2.2))
eta3.1 <- 1 / (1 + exp(-xb3.1))
eta3.2 <- 1 / (1 + exp(-xb3.2))
eta4.1 <- 1 / (1 + exp(-xb4.1))
eta4.2 <- 1 / (1 + exp(-xb4.2))

P1.1 <- eta1.1
P1.2 <- eta1.2 - eta1.1
P1.3 <- 1 - eta1.2

P2.1 <- eta2.1
P2.2 <- eta2.2 - eta2.1
P2.3 <- 1 - eta2.2

P3.1 <- eta3.1
P3.2 <- eta3.2 - eta3.1
P3.3 <- 1 - eta3.2

P4.1 <- eta4.1
P4.2 <- eta4.2 - eta4.1
P4.3 <- 1 - eta4.2

eta5.1 <- 1 / (1 + exp(-xb5.1))
eta5.2 <- 1 / (1 + exp(-xb5.2))
eta5.3 <- 1 / (1 + exp(-xb5.3))

P5.1 <- eta5.1 - 0
P5.2 <- eta5.2 - eta5.1
P5.3 <- eta5.3 - eta5.2
P5.4 <- 1 - eta5.3

# generate the items with theta and measurement error
y1 <- y2 <- y3 <- y4 <- y5 <- NA
for(i in 1:n){
  y1[i] <- sample(c(0,1,2), size=1, replace=T, prob=c(P1.1[i],P1.2[i],P1.3[i]))
  y2[i] <- sample(c(0,1,2), size=1, replace=T, prob=c(P2.1[i],P2.2[i],P2.3[i]))
  y3[i] <- sample(c(0,1,2), size=1, replace=T, prob=c(P3.1[i],P3.2[i],P3.3[i]))
  y4[i] <- sample(c(0,1,2), size=1, replace=T, prob=c(P4.1[i],P4.2[i],P4.3[i]))
  y5[i] <- sample(c(0,1,2,3), size=1, replace=T, prob=c(P5.1[i],P5.2[i],P5.3[i],P5.4[i]))
}

y <- cbind(y1, y2, y3, y4, y5)

## inspect the y matrix
head(y, 10)

## no matter the scale is, we need the min of the scale to be 1 for the Stan program
y <- y+1

## inspect 1 more time 
head(y, 10)


## tell us how many items are binary and ordered respectively
data_list <- list(y1=y1+1, y2=y2+1, y3=y3+1, y4=y4+1, y5=y5+1, n=nrow(y), j=j)

## fit stan model
fit <- stan(model_code = model, data = data_list, iter = 1000, chains = 4, cores = 4)

## extract draws from stan model object
output <- extract(fit, permuted = TRUE)

## print names
names(output)

## this prints the posterior mean for the latent variable
apply(output$theta,2,mean)


## calculate the mean the posterior for the latent variable
latentmean <- apply(output$theta,2,mean)


## plot true latent variable with posterior mean
par(mar=c(4,4,1,1), font=2, font.lab=2, cex=1.3)
plot(latentmean, theta, xlim=c(-3,3), ylim=c(-3,3), ylab="true theta", xlab="posterior mean of theta")
abline(a=0, b=1, col=2, lwd=2)

## correlate the true latent variable and the additive scale
cor(theta,(y1+y2+y3+y4), method="spearman")

## correlate the estimated latent variable and the additive scale
cor(latentmean,(y1+y2+y3+y4), method="spearman")

## correlate the estimated latent variable and the true latent variable
cor(latentmean,theta, method="spearman")

## how do these correlations compare when the true alpha parameters are spaced equally from one another and when they are not?


cut_points_1_hat <- apply(output$cut_points[,,1], MARGIN=2, FUN=mean)
cut_points_2_hat <- apply(output$cut_points[,,2], MARGIN=2, FUN=mean)
beta_hat <- apply(output$beta, MARGIN=2, FUN=mean)
cut_points_1_hat
cut_points_2_hat
beta_hat

cut_points_3levels_1_hat <- mean(output$cut_points_3levels[,,1])
cut_points_3levels_2_hat <- mean(output$cut_points_3levels[,,2])
cut_points_3levels_3_hat <- mean(output$cut_points_3levels[,,3])
beta_3levels_hat <- apply(output$beta_3levels, MARGIN=2, FUN=mean)
cut_points_3levels_1_hat
cut_points_3levels_2_hat
cut_points_3levels_3_hat
beta_3levels_hat


## check against this grm {ltm}	package for a MLE gradient response model (which should be equivalent)
library(ltm)
fit_grm <- grm(data=y, IRT.param=TRUE)
fit_grm
fit_grm$coefficients
