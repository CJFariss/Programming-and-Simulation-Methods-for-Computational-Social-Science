## RSTAN_dynamic_IRT_simulation_part05.R
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
## adds missingness
## also explores using the student's t-distribution instead of the normal density for the latent trait parameter

##
library(boot)
library(rstan)

time_index <- 1:30
time_index

unit_index <- 1:10
unit_index

# simulation for checking the distribution of correlations
#value <- NA
#for(j in 1:1000){

x <- matrix(NA, nrow=length(time_index), ncol=length(unit_index))

x[1,] <- rnorm(length(unit_index), mean=0, sd=1)
x[1,]

for(i in 2:length(time_index)){
  x[i,] <- rnorm(length(unit_index), mean=x[i-1,], sd=.25)
}
x

par(mfrow=c(1,1))
plot(x[,1], type="n", ylim=c(-3,3))
for(i in 1:10){
  lines(x[,i], col=i)
}
#MASS::truehist(x)

#cbind(x[2:length(time_index)], x[1:(length(time_index)-1)])

#value[j] <- cor(x[2:length(time_index)], x[1:(length(time_index)-1)])
#}
#MASS::truehist(value)

## stack the columns of x
x_column <- c(x)
length(x_column)


unit_column <- rep(unit_index, each=30)
time_column <- rep(time_index, 10)

cbind(x_column, unit_column, time_column)


alpha1 <- -2.5
beta1 <- 2
prob_y1 <- inv.logit(alpha1 + beta1*x_column + rnorm(length(x_column)))
y1 <- rbinom(length(x_column), 1, prob=prob_y1)
#y1 <- alpha + beta*x + 

alpha2 <- -.75
beta2 <- 2
prob_y2 <- inv.logit(alpha2 + beta2*x_column + rnorm(length(x_column)))
y2 <- rbinom(length(x_column), 1, prob=prob_y2)

alpha3 <- 0.75
beta3 <- 2
prob_y3 <- inv.logit(alpha3 + beta3*x + rnorm(length(x_column)))
y3 <- rbinom(length(x_column), 1, prob=prob_y3)

alpha4 <- 2.5
beta4 <- 5
prob_y4 <- inv.logit(alpha4 + beta4*x_column + rnorm(length(x_column)))
y4 <- rbinom(length(x_column), 1, prob=prob_y4)

additive_scale <- y1 + y2 + y3 + y4

plot(additive_scale ~ x_column)

## create column vectors
y_column <- c(y1,y2,y3,y4)
item_column <- rep(1:4, each=300)
cbind(y_column, item_column)
unit_column <- rep(unit_column, 4)
time_column <- rep(time_column, 4)

## check that all the column vector ids are lining up
cbind(y_column, item_column, unit_column, time_column)[1:100,]
cbind(y_column, item_column, unit_column, time_column)[301:400,]

unit_time_column <- rep(1:300, times=4)
length(unit_time_column)

## randomly generate some missingness for the model, which we also need to track with another column (just a column in R and not in Stan)
missing_ids <- sample(1:length(y_column), size=10, replace=FALSE)
missing_ids

y_column[missing_ids] <- NA
summary(y_column)

y_column <- y_column[-missing_ids]
summary(y_column)


item_column <- item_column[-missing_ids]
unit_column <- unit_column[-missing_ids]
time_column <- time_column[-missing_ids]
unit_time_column <- unit_time_column[-missing_ids]

## define the stan model
model <- "

  data{
    int n_t;
    int n_t_k;
    int k;
    int<lower=0, upper=1> y[n_t_k];
    int<lower=1> item_column[n_t_k];
    int<lower=1> unit_column[n_t_k];
    int<lower=1> time_column[n_t_k];
    int<lower=1> unit_time_column[n_t_k];
  }
  
  parameters{
    real theta[n_t];
    real alpha[k];
    real<lower=0> beta[k];
    real<lower=0> sigma;
  }
  
  transformed parameters{
    real theta_star[n_t];
    real sigma_star[n_t];
    real theta_star_df[n_t];
    real xb[n_t_k];
    
    for(i in 1:n_t){
      if(time_column[i]==1){
        theta_star[i]=0;
        sigma_star[i]=1;
        theta_star_df[i]=1000;
      }
      else{
        theta_star[i]=theta_star[i-1];
        sigma_star[i]=sigma;
        theta_star_df[i]=5;
      }
    }
    for(i in 1:n_t_k){
      xb[i] = alpha[item_column[i]] + beta[item_column[i]] * theta[unit_time_column[i]];
    }
  }
  
  model{
    // priors
    //theta ~ normal(theta_star, sigma_star);
    theta ~ student_t(theta_star_df, theta_star, sigma_star);
    alpha ~ normal(0,10);
    beta ~ normal(0,10);
    sigma ~ normal(0,1);
    
    // likelihood
    //for(i in 1:n_t_k){
    //  y[i] ~ bernoulli_logit(alpha[item_column[i]] + beta[item_column[i]] * theta[unit_time_column[i]]);
    //}
    y ~ bernoulli_logit(xb);
  }

"

data_list <- list(n_t=300, n_t_k=length(unit_column), k=4, y=y_column, item_column=item_column, unit_column=unit_column, time_column=time_column, unit_time_column=unit_time_column)
data_list

fit <- stan(model_code=model, data=data_list, iter=2000, chains=4, pars=c("theta_star", "sigma_star", "xb"), include=FALSE, cores = 4)
fit

output <- extract(fit)
dim(output)
names(output)

dim(output$theta)
names(output$theta)

theta_hat <- apply(output$theta, MARGIN=2, FUN=mean)
theta_hat

par(mfrow=c(1,1))
plot(x=x, y=theta_hat, xlab="true x", ylab="estiamted theta of x")
abline(reg=lm(theta_hat~x_column),col=2)
cor(x_column, theta_hat)
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


boxplot(theta_hat~y1)
boxplot(theta_hat~y2)
boxplot(theta_hat~y3)
boxplot(theta_hat~y4)

par(mfrow=c(1,1))
boxplot(theta_hat~additive_scale)

MASS::truehist(theta_hat)
MASS::truehist(x)
