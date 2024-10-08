## RSTAN_dynamic_IRT_simulation_part02.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Programming and Simulation Methods for Computational Social Science (2W)
## University of Essex Summer School 2024
##
## Date: 2024-07-22
##
## Please e-mail me if you find any errors or have and suggestions
## e-mail: cjf0006@gmail.com
## e-mail: cjfariss@umich.edu
##
##########################################################################
##
## Introduction to tutorial:
##
## In the IRT framework, there is a latent trait theta_i.
## Where the subscript i = 1,... ,N indicates multiple units. y_itj is the observed value for item j for unit i, in t = 1, ... T, tim periods. For each item alpha_j and beta_j are also estimated. alpha_j continues to act as "difficulty" parameters, or threshold that benchmarks how likely an indicator is to be observed relative to the values of the latent trait.  In this formulation, this is analogous to an intercept in a traditional logistic regression model.  beta_j, often referred to as the "discrimination" parameters and is the analogue of a slope coefficient.
##
## The STAN model below adds a dependency into the relationship between the latent variable in time t+1 and time t. It is dynamic because of this dependency. See Schnakenberg and Fariss (2014) or Reuning, Kenwick, Fariss (2019) for more details (see the Papers folder).
##
##########################################################################

##
library(boot)
library(rstan)

time_index <- 1:30
time_index

## simulation for checking the distribution of correlations
value <- NA
for(j in 1:1000){
x <- rnorm(1, mean=0, sd=1)
x

for(i in 2:length(time_index)){
  x[i] <- rnorm(1, mean=x[i-1], sd=.25)
}
x

par(mfrow=c(1,1))
#plot(x, type="l")
#MASS::truehist(x)

#cbind(x[2:length(time_index)], x[1:(length(time_index)-1)])

value[j] <- cor(x[2:length(time_index)], x[1:(length(time_index)-1)])
}
MASS::truehist(value)
summary(value)

x <- rnorm(1, mean=0, sd=1)
x

for(i in 2:length(time_index)){
  x[i] <- rnorm(1, mean=x[i-1], sd=1)
}
x

par(mfrow=c(1,1))
plot(x, type="l")


alpha1 <- -2.5
beta1 <- 6
prob_y1 <- inv.logit(alpha1 + beta1*x + rnorm(length(time_index)))
y1 <- rbinom(length(time_index), 1, prob=prob_y1)

alpha2 <- -0.5
beta2 <- 6
prob_y2 <- inv.logit(alpha2 + beta2*x + rnorm(length(time_index)))
y2 <- rbinom(length(time_index), 1, prob=prob_y2)

alpha3 <- 1.5
beta3 <- 6
prob_y3 <- inv.logit(alpha3 + beta3*x + rnorm(length(time_index)))
y3 <- rbinom(length(time_index), 1, prob=prob_y3)

alpha4 <- 2.5
beta4 <- 6
prob_y4 <- inv.logit(alpha4 + beta4*x + rnorm(length(time_index)))
y4 <- rbinom(length(time_index), 1, prob=prob_y4)

additive_scale <- y1 + y2 + y3 + y4

plot(additive_scale ~ x)

par(mfrow=c(1,2), mar=c(4,4,1,1))
plot(additive_scale, type="l")
plot(x, type="l")

cor(additive_scale,x)

table(additive_scale)

model <- "

  data{
    int n;
    int k;
    int<lower=0, upper=1> y1[n];
    int<lower=0, upper=1> y2[n];
    int<lower=0, upper=1> y3[n];
    int<lower=0, upper=1> y4[n];
  }
  
  parameters{
    real theta[n];
    real alpha[k];
    real<lower=0> beta[k];
    real<lower=0> sigma;
  }
  
  transformed parameters{
    real theta_star[n];
    real sigma_star[n];
    
    // alternative dynamic prior on theta
    // this part is only necessary for alternartive prior below in the model{} block
    for(i in 1:n){
      if(i==1){
        theta_star[i]=0;
        sigma_star[i]=1;
      }
      else{
        theta_star[i]=theta[i-1];
        sigma_star[i]=sigma;
      }
    }
  }
  
  model{
    //priors
    alpha ~ normal(0,10);
    beta ~ normal(0,10);
    sigma ~ normal(0,1);
    
    // dynamic prior on theta (see part01 program lesson for more on this)
    //theta[1] ~ std_normal();
    //for(i in 2:n){
    //  theta[i] ~ normal(theta[i-1], sigma);
    //}
    
    // alternative dynamic prior on theta
    theta ~ normal(theta_star, sigma_star);
    
    // likelihood
    for(i in 1:n){
      y1[i] ~ bernoulli_logit(alpha[1] + beta[1] * theta[i]);
      y2[i] ~ bernoulli_logit(alpha[2] + beta[2] * theta[i]);
      y3[i] ~ bernoulli_logit(alpha[3] + beta[3] * theta[i]);
      y4[i] ~ bernoulli_logit(alpha[4] + beta[4] * theta[i]);
    }
  }

"

data_list <- list(n=length(time_index), k=4, y1=y1, y2=y2, y3=y3, y4=y4)
data_list

fit <- stan(model_code=model, data=data_list, iter=2000, chains=4, pars=c("theta_star", "sigma_star"), include=FALSE, cores = 4)
fit

output <- extract(fit)
dim(output)
names(output)

dim(output$theta)
names(output$theta)

theta_hat <- apply(output$theta, MARGIN=2, FUN=mean)
theta_hat

par(mfrow=c(1,1))
plot(x=x, y=theta_hat, xlab="true theta", ylab="estiamted theta of theta")
abline(reg=lm(theta_hat~x),col=2)
cor(x, theta_hat)
cor(additive_scale, theta_hat)

apply(output$alpha, MARGIN=2, FUN=mean)
c(alpha1, alpha2, alpha3, alpha4)


apply(output$beta, MARGIN=2, FUN=mean)
c(beta1, beta2, beta3, beta4)

alpha_hat <- apply(output$alpha, MARGIN=2, FUN=mean)
beta_hat <- apply(output$beta, MARGIN=2, FUN=mean)

## inflection points in the latent space
inflection_points <- - alpha_hat / beta_hat

x_seq <- seq(-4,4,.1)
prob_y1_hat <- inv.logit(alpha_hat[1] + beta_hat[1] * x_seq)
prob_y2_hat <- inv.logit(alpha_hat[2] + beta_hat[2] * x_seq)
prob_y3_hat <- inv.logit(alpha_hat[3] + beta_hat[3] * x_seq)
prob_y4_hat <- inv.logit(alpha_hat[4] + beta_hat[4] * x_seq)

par(mfrow=c(2,2))
plot(x=x_seq, y=prob_y1_hat, type="l")
abline(v=inflection_points[1], col=2); abline(h=.5, lty=2)

plot(x=x_seq, y=prob_y2_hat, type="l")
abline(v=inflection_points[2], col=2); abline(h=.5, lty=2)

plot(x=x_seq, y=prob_y3_hat, type="l")
abline(v=inflection_points[3], col=2); abline(h=.5, lty=2)

plot(x=x_seq, y=prob_y4_hat, type="l")
abline(v=inflection_points[4], col=2); abline(h=.5, lty=2)


#apply(output$sigma, MARGIN=2, FUN=mean)
mean(output$sigma)
