## RSTAN_Demo_binary_IRT_guessing_simulation.R
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
    int<lower=0, upper=1> y1[n];
    int<lower=0, upper=1> y2[n];
    int<lower=0, upper=1> y3[n];
    int<lower=0, upper=1> y4[n];
    int<lower=0, upper=1> y5[n];
}
transformed data{
}
parameters {
    // declared the parameters in memory
    vector[j] alpha;
    real<lower=0> beta[j];
    vector[n] theta;
}
transformed parameters {
    vector[n] prob_xb1;
    vector[n] prob_xb2;
    vector[n] prob_xb3;
    vector[n] prob_xb4;
    vector[n] prob_xb5;
    real<lower=0, upper=1> guessing;

    guessing <- 0.2;  // assumes 5 multiple choice options with one correct answer 1/5. we could also estimate this parameter with a uniform or beta prior
    
    prob_xb1 <- guessing + (1-guessing)*inv_logit(alpha[1] + beta[1] * theta);
    prob_xb2 <- guessing + (1-guessing)*inv_logit(alpha[2] + beta[2] * theta);
    prob_xb3 <- guessing + (1-guessing)*inv_logit(alpha[3] + beta[3] * theta);
    prob_xb4 <- guessing + (1-guessing)*inv_logit(alpha[4] + beta[4] * theta);
    prob_xb5 <- guessing + (1-guessing)*inv_logit(alpha[5] + beta[5] * theta);
    
}
model {
    // priors (these are variances not precision)
    //theta ~ std_normal(); //priors on latent variable
    theta ~ normal(0,1); //priors on latent variable
    
    guessing ~ uniform(0,.2)
    
    alpha ~ normal(0,10); //priors for the intercepts/difficulty (these are variances not precision)
    beta ~ normal(0,10); // priors for the slope/discrimination. This is truncated so that the lowest possible value is 0
    
    // likelihood (link data to some combination of parameters and more data)
    // one equation for each of the observed items
    y1 ~ bernoulli(prob_xb1);
    y2 ~ bernoulli(prob_xb2);
    y3 ~ bernoulli(prob_xb3);
    y4 ~ bernoulli(prob_xb4);
    y5 ~ bernoulli(prob_xb5);
}
"
## -------------------------------------------------- #

## simulated data
n <- 300
theta <- rnorm(n,0,1) ## standard normal latent estimand (it's an estimand because we cannot actually observe this)
##theta <- runif(n,-3,3)

## set parameters for each item
## alpha (the intercept) is the difficulty parameter or base-line probability of 1
## beta (the slope) is the discrimination parameter or the strength of the relationship
## between the estimated latent trait theta and the individual item

## item 1 is the most difficult item (it is centered over the +1/+2 on the latent trait)
alpha1 <- -2.000000
##alpha1 <- -1.000000
beta1 <- 1.000000

## item 2 is of medium difficulty relative to the two other items
alpha2 <- 0.000000
beta2 <- 1.000000

## item 3 is the least difficult item but is also the most informative (it is centered over the -1 on the latent trait)
alpha3 <- 0.000000
beta3 <- 10.000000

## item 4
alpha4 <- -1.000000
beta4 <- 10.000000

## item 5
alpha5 <- 1.000000
beta5 <- 10.000000


## define j as the number of items
j <- 5

## linear terms of the item specific models f() that link the latent trait to the items
xb1 <- alpha1 + beta1 * theta
xb2 <- alpha2 + beta2 * theta
xb3 <- alpha3 + beta3 * theta
xb4 <- alpha4 + beta4 * theta
xb5 <- alpha5 + beta5 * theta

guessing_rate <- 1/5  ## assumes 5 multiple choices options and 1 correct answer

## transform the linear xb terms using the logit function
## so that theta is bound from 0 to 1
pi_1 <- guessing_rate + ((1-guessing_rate) / (1 + exp(-xb1))) ## equivalent to g + (1-g)*inv.logit(p)
pi_2 <- guessing_rate + ((1-guessing_rate) / (1 + exp(-xb2)))
pi_3 <- guessing_rate + ((1-guessing_rate) / (1 + exp(-xb3)))
pi_4 <- guessing_rate + ((1-guessing_rate) / (1 + exp(-xb4)))
pi_5 <- guessing_rate + ((1-guessing_rate) / (1 + exp(-xb5)))

## generate the items with theta and measurement error
y1 <- rbinom(n, size=1, prob=pi_1)
y2 <- rbinom(n, size=1, prob=pi_2)
y3 <- rbinom(n, size=1, prob=pi_3)
y4 <- rbinom(n, size=1, prob=pi_4)
y5 <- rbinom(n, size=1, prob=pi_5)

## create matrix of observed items
y <- cbind(y1, y2, y3, y4, y5)

## create data list with each of the observed items
data_list <- list(y1=y1, y2=y2, y3=y3, y4=y4, y5=y5, j=j, n=n)

## fit stan model
fit <- stan(model_code = model, data = data_list, iter = 4000, chains = 4, cores=4, thin=2)

## this summarizes the named parameters but not along the dimensions
fit

## extract draws from stan model object
output <- extract(fit, permuted = TRUE)

## print names
names(output)

## this prints the posterior mean for the latent variable
apply(output$theta,2,mean)


## calculate the mean the posterior for the latent variable
theta_hat <- apply(output$theta, MARGIN=2, FUN=mean)
theta_hat

## plot true latent variable with posterior mean
par(mfrow=c(1,1), mar=c(4,4,1,1), font=2, font.lab=2, cex=1.3)
plot(theta_hat, theta, xlim=c(-3,3), ylim=c(-3,3), ylab="true theta", xlab="posterior mean of theta")
abline(a=0, b=1, col=2, lwd=2)


## correlate the true latent variable and the additive scale
cor(theta,(y1+y2+y3), method="spearman")

## correlate the estimated latent variable and the additive scale
cor(theta_hat,(y1+y2+y3), method="spearman")

## correlate the estimated latent variable and the true latent variable
cor(theta_hat,theta, method="spearman")

## how do these correlations compare when the true alpha parameters are spaced equally from one another and when they are not?



additive_scale <- y1 + y2 + y3 + y4 + y5

cor(theta, theta_hat)
cor(additive_scale, theta_hat)

apply(output$alpha, MARGIN=2, FUN=mean)
c(alpha1, alpha2, alpha3, alpha4, alpha5)


apply(output$beta, MARGIN=2, FUN=mean)
c(beta1, beta2, beta3, beta4, beta5)

alpha_hat <- apply(output$alpha, MARGIN=2, FUN=mean)
beta_hat <- apply(output$beta, MARGIN=2, FUN=mean)

## inflection points in the latent space
inflection_points <- - alpha_hat / beta_hat

x_seq <- seq(-4,4,.1)
prob_y1_hat <- guessing_rate + (1-guessing_rate)*inv.logit(alpha_hat[1] + beta_hat[1] * x_seq)
prob_y2_hat <- guessing_rate + (1-guessing_rate)*inv.logit(alpha_hat[2] + beta_hat[2] * x_seq)
prob_y3_hat <- guessing_rate + (1-guessing_rate)*inv.logit(alpha_hat[3] + beta_hat[3] * x_seq)
prob_y4_hat <- guessing_rate + (1-guessing_rate)*inv.logit(alpha_hat[4] + beta_hat[4] * x_seq)
prob_y5_hat <- guessing_rate + (1-guessing_rate)*inv.logit(alpha_hat[5] + beta_hat[5] * x_seq)

par(mfrow=c(2,3))
plot(x=x_seq, y=prob_y1_hat, type="l", ylim=c(0,1))
abline(v=inflection_points[1], col=2); abline(h=.5, lty=2)
abline(h=guessing_rate, lty=2)

plot(x=x_seq, y=prob_y2_hat, type="l", ylim=c(0,1))
abline(v=inflection_points[2], col=2); abline(h=.5, lty=2)
abline(h=guessing_rate, lty=2)

plot(x=x_seq, y=prob_y3_hat, type="l", ylim=c(0,1))
abline(v=inflection_points[3], col=2); abline(h=.5, lty=2)
abline(h=guessing_rate, lty=2)

plot(x=x_seq, y=prob_y4_hat, type="l", ylim=c(0,1))
abline(v=inflection_points[4], col=2); abline(h=.5, lty=2)
abline(h=guessing_rate, lty=2)

plot(x=x_seq, y=prob_y5_hat, type="l", ylim=c(0,1))
abline(v=inflection_points[5], col=2); abline(h=.5, lty=2)
abline(h=guessing_rate, lty=2)



##
par(mfrow=c(2,3))
boxplot(theta_hat ~ y1)
boxplot(theta_hat ~ y2)
boxplot(theta_hat ~ y3)
boxplot(theta_hat ~ y4)
boxplot(theta_hat ~ y5)

##
par(mfrow=c(1,1))
boxplot(theta_hat~additive_scale)

##
MASS::truehist(theta_hat)

