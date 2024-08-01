## RSTAN_Demo_IRT_categorical_softmax_simulation.R
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
##For this R tutorial we will simulate 4 binary dependent variables or items and then estimate the units-specific parameters (the latent variable) and item-specific parameters (the difficulty and discrimination parameters) that generate the variable.
##
## In the softmax framework, there is a latent trait theta_i.
## 
## This should be equivalent to the Generalized Partial Credit Model (Masters 1982).
## Masters, Geoff N. 1982. “A Rasch Model for Partial Credit Scoring.” Psychometrika 47 (2). Springer: 149–74.
##
## The simulated data is consistent with the ordered IRT model or graded response model. I'm still working on updating a new simulation and comparing across simulation processes and versions of the IRT models for ordered data.
##
## See the Stan case study for this model and extensions here: 
## https://mc-stan.org/users/documentation/case-studies/pcm_and_gpcm.html
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
    int n;
    int j;
    int<lower=1, upper=3> y1[n];
    int<lower=1, upper=3> y2[n];
    int<lower=1, upper=3> y3[n];
    int<lower=1, upper=3> y4[n];
}
parameters {
    // declared the parameters in memory
    vector[3] alpha1;
    vector[3] alpha2;
    vector[3] alpha3;
    vector[3] alpha4;
    real<lower=0> beta[j];
    real theta[n];
}
transformed parameters {
    matrix[3,n] prob_eta1;
    matrix[3,n] prob_eta2;
    matrix[3,n] prob_eta3;
    matrix[3,n] prob_eta4;
    
    for(i in 1:n){
        prob_eta1[,i] = softmax(cumulative_sum(alpha1 - beta[1]*theta[i]));
        prob_eta2[,i] = softmax(cumulative_sum(alpha2 - beta[2]*theta[i]));
        prob_eta3[,i] = softmax(cumulative_sum(alpha3 - beta[3]*theta[i]));
        prob_eta4[,i] = softmax(cumulative_sum(alpha4 - beta[4]*theta[i]));
      }
}
model {
    // priors (these are variances not precision)
    theta ~ std_normal();
    alpha1 ~ normal(0,10);
    alpha2 ~ normal(0,10);
    alpha3 ~ normal(0,10);
    alpha4 ~ normal(0,10);
    beta ~ normal(0,10);
    
    for(i in 1:n){  
      y1[i] ~ categorical(prob_eta1[,i]);
      y2[i] ~ categorical(prob_eta2[,i]);
      y3[i] ~ categorical(prob_eta3[,i]);
      y4[i] ~ categorical(prob_eta4[,i]);
    }
}
generated quantities {
    // posterior predictions
    vector[n] y1_predict;
    vector[n] y2_predict;
    vector[n] y3_predict;
    vector[n] y4_predict;

    // the loop is necessary within the generated quantities block
    for(i in 1:n){
        y1_predict[i] = categorical_rng(prob_eta1[,i]);
        y2_predict[i] = categorical_rng(prob_eta2[,i]);
        y3_predict[i] = categorical_rng(prob_eta3[,i]);
        y4_predict[i] = categorical_rng(prob_eta4[,i]);
    }
}
"
## -------------------------------------------------- #

# Load packages
library(rstan)

# simulate the latent variable theta
# and set the "true" population values for the alphas and betas
set.seed(940)
#n <- 300
n <- 1000
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


# generate the items with theta and measurement error
y1 <- y2 <- y3 <- y4 <- NA
for(i in 1:n){
  y1[i] <- sample(c(0,1,2), size=1, replace=T, prob=c(P1.1[i],P1.2[i],P1.3[i]))
  y2[i] <- sample(c(0,1,2), size=1, replace=T, prob=c(P2.1[i],P2.2[i],P2.3[i]))
  y3[i] <- sample(c(0,1,2), size=1, replace=T, prob=c(P3.1[i],P3.2[i],P3.3[i]))
  y4[i] <- sample(c(0,1,2), size=1, replace=T, prob=c(P4.1[i],P4.2[i],P4.3[i]))
}

y <- cbind(y1, y2, y3, y4)

## inspect the y matrix
head(y, 10)

## no matter the scale is, we need the min of the scale to be 1 for the Stan program
y <- y+1

## inspect 1 more time 
head(y, 10)
apply(y, 2, table)

n <- nrow(y)
n


## tell us how many items are binary and ordered respectively
data_list <- list(y1=y1+1, y2=y2+1, y3=y3+1, y4=y4+1, x=x, n=n, j=j)

## fit stan model
fit <- stan(model_code = model, data = data_list, iter = 1000, chains = 4, cores = 4)

## extract draws from stan model object
output <- extract(fit, permuted = TRUE)

## print names
names(output)

## this prints the posterior mean for the latent variable
apply(output$alpha1,2,mean)
apply(output$alpha2,2,mean)
apply(output$alpha3,2,mean)
apply(output$alpha4,2,mean)
apply(output$beta,2,mean)

theta_hat <- apply(output$theta,2,mean)

lapply(output, dim)

## plot true latent variable with posterior mean
par(mar=c(4,4,1,1), font=2, font.lab=2, cex=1.3)
plot(theta_hat, theta, xlim=c(-3,3), ylim=c(-3,3), ylab="true theta", xlab="posterior mean of theta")
abline(a=0, b=-1, col=2, lwd=2)



xb1.1 <- alpha1.1 - beta1 * theta
xb1.2 <- alpha1.2 - beta1 * theta
xb2.1 <- alpha2.1 - beta2 * theta
xb2.2 <- alpha2.2 - beta2 * theta
xb3.1 <- alpha3.1 - beta3 * theta
xb3.2 <- alpha3.2 - beta3 * theta
xb4.1 <- alpha4.1 - beta4 * theta
xb4.2 <- alpha4.2 - beta4 * theta

alpha1_hat <- apply(output$alpha1,2,mean)
alpha2_hat <- apply(output$alpha2,2,mean)
alpha3_hat <- apply(output$alpha3,2,mean)
alpha4_hat <- apply(output$alpha4,2,mean)
beta_hat <- apply(output$beta,2,mean)
theta_hat <- apply(output$theta,2,mean)

alpha1_hat
alpha2_hat
alpha3_hat
alpha4_hat


MASS::truehist(theta_hat)
MASS::truehist(theta)
