## RSTAN_Demo_linear_latent_variable_model_simulation.R
##########################################################################
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
    real y1[n];
    real y2[n];
    real y3[n];
    real y4[n];
    real y5[n];
    real y6[n];
    real y7[n];
}
parameters {
    // declared the parameters in memory
    vector[j] alpha;
    real<lower=0> beta[j];
    real<lower=0> sigma[j];
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
    y1 ~ normal(alpha[1] + beta[1] * theta, sigma[1]);
    y2 ~ normal(alpha[2] + beta[2] * theta, sigma[2]);
    y3 ~ normal(alpha[3] + beta[3] * theta, sigma[3]);
    y4 ~ normal(alpha[4] + beta[4] * theta, sigma[4]);
    y5 ~ normal(alpha[5] + beta[5] * theta, sigma[5]);
    y6 ~ normal(alpha[6] + beta[6] * theta, sigma[6]);
    y7 ~ normal(alpha[7] + beta[7] * theta, sigma[7]);
}
"
## -------------------------------------------------- #

sim_n <- 1000
theta <- rnorm(sim_n,0,1)

linear_output <- function(size=1, intercept=0, slope=0, variable=1, error_term=FALSE, error_variance=1){
  if(error_term==FALSE){
    xb <- intercept + slope*variable
  } else{
    xb <- intercept + slope*variable + rnorm(n=size, mean=0, sd=sqrt(error_variance))
  }
  return(xb)
}
linear_output()
linear_output(error_term=TRUE) # defaults to draws from a random standard normal distribution

par(mfrow=c(1,1))
MASS::truehist(linear_output(size=1000, error_term=TRUE))

## generate simulated lienar data 
y1 <- linear_output(size=sim_n, intercept=0, slope=1, variable=theta, error_term=TRUE)
y2 <- linear_output(size=sim_n, intercept=1.5, slope=1, variable=theta, error_term=TRUE)
y3 <- linear_output(size=sim_n, intercept=-1.5, slope=1, variable=theta, error_term=TRUE)
y4 <- linear_output(size=sim_n, intercept=2.5, slope=2, variable=theta, error_term=TRUE)
y5 <- linear_output(size=sim_n, intercept=-2.5, slope=2, variable=theta, error_term=TRUE)
y6 <- linear_output(size=sim_n, intercept=-0.5, slope=4, variable=theta, error_term=TRUE)
y7 <- linear_output(size=sim_n, intercept=-0.5, slope=4, variable=theta, error_term=TRUE)

y <- cbind(y1,y2,y3,y4,y5,y6,y7)
cor(y)

par(mfrow=c(4,2))
plot(theta, y1, col=grey(.75)); abline(reg=lm(y1 ~ theta), col=2); abline(a=0,b=1, col=4)
plot(0,0,type="n");
plot(theta, y2, col=grey(.75)); abline(reg=lm(y2 ~ theta), col=2); abline(a=1.5,b=1, col=4)
plot(theta, y3, col=grey(.75)); abline(reg=lm(y3 ~ theta), col=2); abline(a=-1.5,b=1, col=4)
plot(theta, y4, col=grey(.75)); abline(reg=lm(y4 ~ theta), col=2); abline(a=2.5,b=2, col=4)
plot(theta, y5, col=grey(.75)); abline(reg=lm(y5 ~ theta), col=2); abline(a=-2.5,b=2, col=4)
plot(theta, y6, col=grey(.75)); abline(reg=lm(y6 ~ theta), col=2); abline(a=0.5,b=4, col=4)
plot(theta, y7, col=grey(.75)); abline(reg=lm(y7 ~ theta), col=2); abline(a=0.5,b=4, col=4)

##
data_list <- list(n=sim_n, j=ncol(y), y1=y1, y2=y2, y3=y3, y4=y4, y5=y5, y6=y6, y7=y7)

## fit stan model
fit <- stan(model_code = model, data = data_list, iter = 1000, chains = 4, cores=4)

## print fit object
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

boxplot(output$alpha, main="alpha parameters")
boxplot(output$beta, main="beta parameters")
boxplot(output$sigma, main="sigma parameters")


