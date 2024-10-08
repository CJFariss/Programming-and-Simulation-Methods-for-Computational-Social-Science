## R_Demo_Simulation_Learning_Probability_Continuous_Distributions.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Programming and Simulation Methods for Computational Social Science (2W)
## University of Essex Summer School 2023
##
## Date: 2024-07-22
##
## Please e-mail me if you find any errors or have and suggestions
## e-mail: cjf0006@gmail.com
## e-mail: cjfariss@umich.edu
##########################################################################
## Introduction to tutorial:
##
## For this R tutorial, we will learn about:
##
## (1) Discrete probability distributions for discrete events (e.g., a coin flip; rolling a 6-sided dice).
## (2) Continuous probability distributions (e.g., SAT, GRE or LSAT scores; human weight at birth; distance from the center of the board for the beanbag toss or cornhole game)
##
## Note: This lesson contains information you will use in a program challenge this week: select one continuous and/or one discrete probability distribution from below (not including Uniform, Normal, Bernoulli, or Binomial) and describe it in detail with ## comments and R code. See the examples for Uniform, Normal, Bernoulli, or Binomial distributions below. If you select 2 distributions, make sure one is continuous and the other is discrete.
##
##########################################################################

## Recall: probability mass or probability density: this is just how much probability does each event/outcome have and it all needs to sum to 1 to be a probability measure (see the less from last week)

## What is density? Density is the relative probability of sampling an event at a specific point along the range of possible values defined by the function.

##########################################################################
## continuous probability distributions usually called density functions
##########################################################################
##
## uniform distribution
##
## The uniform distribution is a continuous distribution
##
## The sample space S for the uniform distribution, is defined so that the density for any value is the same or uniform over the range of possible values that any one element can take. Instead of directly estimating probabilities as we did above, we will instead estimate density.
##
## What is density? Density is the relative probability of sampling an event a specific point along the range of possible values defined by the function.
##
## In other words, the uniform distribution with range a to b, denoted U (a, b), has a constant probability density of 1/(b-a) for a <= y <= b and zero probability elsewhere. The standard uniform is defined so that a=0 and b=1: U(0,1),
##
## range a <= y <= b
## distribution function: 1/(b - a)
## parameters: a and b
## R function names:
## dunif
## punif
## qunif
## runif
##
## parameters:
## formula for the mean: (a + b)/2
## formula for the variance: ((b - a)^2)/12
##
## let's define our own uniform function
uniform_function <- function(x,a,b){
  ifelse(x>=a & x<=b, 1/(b - a), 0)
}

## call our user defined function
uniform_function(1,0,1)
uniform_function(1,a=0,b=2)
uniform_function(1,-1,1)
uniform_function(1,-10,10)

uniform_function(-8,0,1)
uniform_function(-8,0,2)
uniform_function(-8,-1,1)
uniform_function(-8,-10,10)

## use R's based function for a uniform distribution
dunif(1,0,1)
dunif(1,0,2)
dunif(1,-1,1)
dunif(1,-10,10)

dunif(-8,0,1)
dunif(-8,0,2)
dunif(-8,-1,1)
dunif(-8,-10,10)

## we can use the p or probability version of the uniform function built into R to answer to the following question:
## What is the probability of observing a value between 0 and 0.5 for a uniform random variable that spans the range 0 to 1?
punif(0.5,0,1)

punif(0.25,0,1)

## What is the probability of observing a value between 0.25 and 0.5 for a uniform random variable that spans the range 0 to 1?
punif(0.5,0,1) - punif(0.25,0,1)

## Graph the Uniform density function using the curve() function
curve(expr=dunif, ylab="Pr(X=x)", type="l", xlim=c(0,1), ylim=c(0,1.05), lwd=3, col="navy", main="U(0,1) Density")

curve(expr=dunif, n=10001, from=-2,to=2, ylab="Pr(X=x)", type="l", xlim=c(-2,2), ylim=c(0,1.05), lwd=3, col="navy", main="U(0,1) Density")

curve(expr=dunif(x, min = 0, max = 1), n=10001, from=-2,to=2, ylab="Pr(X=x)", type="l", xlim=c(-2,2), ylim=c(0,1.05), lwd=3, col="navy", main="U(0,1) Density")

curve(expr=dunif(x, min = -1, max = 1), n=10001, from=-2,to=2, ylab="Pr(X=x)", type="l", xlim=c(-2,2), ylim=c(0,1.05), lwd=3, col="navy", main="U(-1,1) Density")

curve(expr=dunif(x, min = -2, max = 2), n=10001, from=-2,to=2, ylab="Pr(X=x)", type="l", xlim=c(-2,2), ylim=c(0,1.05), lwd=3, col="navy", main="U(-2,2) Density")

curve(expr=dunif(x, min = -2, max = 2), n=10001, from=-10,to=10, ylab="Pr(X=x)", type="l", xlim=c(-10,10), ylim=c(0,1.05), lwd=3, col="navy", main="U(-2,2) Density")

curve(expr=dunif(x, min = -2, max = 2), n=10001, from=-100,to=100, ylab="Pr(X=x)", type="l", xlim=c(-100,100), ylim=c(0,1.05), lwd=3, col="navy", main="U(-2,2) Density")


## how many of the draws are very close to the middle of the uniform distribution? (hint: what is the proportion)
sim_n <- 10000
random_draws <- runif(sim_n,0,1)
summary(random_draws)

## as a reminder 
length(unique(c(1,2,2)))

length(unique(random_draws))

table(random_draws>=0 & random_draws<=.25)

table(random_draws>=0 & random_draws<=.25)/sim_n

table(random_draws>=0 & random_draws<=.5)/sim_n

table(random_draws>=.4 & random_draws<=.5)/sim_n

table(random_draws>=0 & random_draws<=1)/sim_n

## we can calculate the above with the p-type function in R
## the p-type function for a density function tells us the density or probability of a function at a given value along the x-axis
## the p-type function turns density into probability by calculating the area under the curve at particular points along the real-number-line
punif(.25)

punif(.25) - punif(0)

punif(.5) - punif(0)

punif(1) - punif(0)

punif(1) - punif(-1)

punif(.5) - punif(.4)


## simulation using sample()

## set parameters
a <- 0
b <- 1

## let's approximate the normal distribution with a sample() function
x <- seq(from=a, to=b, by=.1)
x


## calculate the density using the normal distribution function dnorm() which is built into R
x_dunif <- dunif(x, min=a, max=b)
x_dunif

## simulate draws from a normal distribution
sim_size <- 1000000
x_samples <- sample(x, size=sim_size, replace=TRUE, prob=x_dunif)
w <- length(unique(x_samples)) * (1/(b-a))
w
x_dunif_estimate <- table(x_samples)/(sim_size / w) ## modify by the length() of the unique values in the x sequence
x_dunif_estimate
barplot(x_dunif_estimate, main="U() density approximated using sample()", ylim=c(0,1))
MASS::truehist(x_samples, main="U() density using sample()")

## simulate draws from the uniform distribution using runif()
x_samples <- runif(sim_size, min=a, max=b)
MASS::truehist(x_samples, main="U() density using runif()")
## more optional bonus problems



##########################################################################
##
## normal distribution
##
## The normal distribution is a continuous distribution
##
## The sample space S for the normal distribution, is defined so that the density for any value along the real number line from negative infinity to positive infinity. Instead of directly estimating probabilities as we did above, as with the uniform distribution we will instead estimate density.
##
## What is density? Density is the relative probability of sampling an event at a specific point along the range of possible values defined by the function.
##
## Unlike the uniform distribution the density value for a normal distribution varies (is not uniform) for different values along the real number line.
##
##
## range:
## distribution function: 1/(sigma*sqrt(2*pi)) * exp(-(y - mu)^2/2*sigma^2)
## parameters: the mean mu and the standard deviation sigma (or the variance sigma^2)
## R function names:
## dnorm
## pnorm
## qnorm
## rnorm
##
## parameters:
## formula for the mean: mu
## formula for the variance: sigma^2
##
## let's define our own uniform function
normal_density <- function(y, mu, sigma){
  1/(sigma*sqrt(2*pi)) * exp(-(y - mu)^2/2*sigma^2)
}

## call the user defined normal density function
normal_density(y=0, mu=0, sigma=1) ## standard normal density mu=0, sd=1
normal_density(y=0, mu=1, sigma=1)
normal_density(y=-1, mu=1, sigma=1)
normal_density(y=1, mu=1, sigma=1)
normal_density(y=1.5, mu=1, sigma=1)

## use R's based function for a normal distribution
dnorm(0, mean=0, sd=1)
dnorm(0, mean=1, sd=1)
dnorm(-1, mean=1, sd=1)
dnorm(1, mean=1, sd=1)
dnorm(1.5, mean=1, sd=1)

## Remember that for a normal distribution the probability of observing a specific event or value of a variable
## changes depending on where along the real number line the value resides.

## we can use the p or probability version of the normal function built into R to answer to the following question:

## What is the probability of observing a value between negative infinity and 0 for a normally distributed random variable with mean=0 and standard deviation=1 ?
pnorm(0, mean=0, sd=1)

pnorm(1, mean=0, sd=1)


## What is the probability of observing a value between -1 and 0 for a normally distributed random variable with mean=0 and standard deviation=1 ?
pnorm(0,0,1) - pnorm(-1,0,1)


pnorm(1,0,1) - pnorm(-1,0,1)

pnorm(2,0,1) - pnorm(-2,0,1)

pnorm(1.96,0,1) - pnorm(-1.96,0,1)


## Graph the Normal density function using the curve() function
curve(expr=dnorm, ylab="Pr(X=x)", type="l", xlim=c(-4,4), ylim=c(0,1), lwd=3, col="navy", main="N(0,1) Density")

curve(expr=dnorm, ylab="Pr(X=x)", type="l", xlim=c(-8,8), ylim=c(0,1), lwd=3, col="navy", main="N(0,1) Density")

curve(expr=dnorm(x, mean=0, sd=2), ylab="Pr(X=x)", type="l", xlim=c(-4,4), ylim=c(0,1.05), lwd=3, col="navy", main="N(0,2^2) Density")

curve(expr=dnorm(x, mean=0, sd=2), ylab="Pr(X=x)", type="l", xlim=c(-8,8), ylim=c(0,1.05), lwd=3, col="navy", main="N(0,2^2) Density")

curve(expr=dnorm(x, mean=0, sd=1/2), ylab="Pr(X=x)", type="l", xlim=c(-4,4), ylim=c(0,1.05), lwd=3, col="navy", main="N(0,.5^2) Density")

curve(expr=dnorm(x, mean=0, sd=1/2), ylab="Pr(X=x)", type="l", xlim=c(-8,8), ylim=c(0,1.05), lwd=3, col="navy", main="N(0,.5^2) Density")


## graph some randomly generated numbers

par(mfrow=c(2,2))

random_draws <- rnorm(10)
random_draws
truehist(random_draws)
curve(expr=dnorm, xlim=c(-3,3), col="darkorange", add=TRUE, lwd=2)

random_draws <- rnorm(100)
truehist(random_draws)
curve(expr=dnorm, xlim=c(-3,3), col="darkorange", add=TRUE, lwd=2)

random_draws <- rnorm(1000)
truehist(random_draws)
curve(expr=dnorm, xlim=c(-3,3), col="darkorange", add=TRUE, lwd=2)

random_draws <- rnorm(10000)
truehist(random_draws)
curve(expr=dnorm, xlim=c(-3,3), col="darkorange", add=TRUE, lwd=2)

## how many of the draws are very close to the middle of the uniform distribution?
## (hint: what is the proportion)
sim_n <- 100000
random_draws <- rnorm(sim_n)

table(random_draws>-1 & random_draws<1)/sim_n

table(random_draws>-1.96 & random_draws<1.96)/sim_n

table(random_draws>-2 & random_draws<2)/sim_n

table(random_draws>-3 & random_draws<3)/sim_n

## we can calculate the above with a p-type function in R
## the p-type function for a density function tells us the density or probability of a function at a given value along the x-axis
pnorm(1) - pnorm(-1)

pnorm(1.96) - pnorm(-1.96)

pnorm(2) - pnorm(-2)

pnorm(3) - pnorm(-3)




## let's graph this to see what is happening
## load packages
pkgs <- c("MASS")
invisible(sapply(pkgs, require, character.only = TRUE))

## create sequence of real numbers, these are a set of possible values that are estimate of the mean can take
x <- seq(-3,3,.1)
x
length(x)

## set mean and variance parameters
mu <- 0
sigma <- 1
sigma_pow2 <- sigma^2

## calculate the density using the normal distribution function
## density is a probability measure
x_density <- 1/(sigma*sqrt(2*pi)) * exp(-(x - mu)^2/2*sigma^2)

## calculate the density using the normal distribution function dnorm() which is built into R
x_dnorm <- dnorm(x, mean=mu, sd=sigma)

## plot the two estimated densities to verify that they are the same
par(mfrow=c(1,1))
plot(x_density, x_dnorm)

## plot the x_density variable along each value of x defined in the sequence above:
plot(x,x_density, xlab="random variable", ylab="density")

sum(x_density)/sum(x_density)  ## this should approach as we add more values to the sequence 1 either by decreasing the interval between values in the sequence or by increasing the total range of the sequence
sum(x_density[x<=0])/sum(x_density)
sum(x_density[x<=0 & x>=-1])/sum(x_density)

pnorm(0,0,1)
pnorm(0,0,1) - pnorm(-1,0,1)


## fill in the sequence more so that the values converge on the true values from the pnorm functions
x <- seq(-6,6,.001)
x_density <- 1/(sigma*sqrt(2*pi)) * exp(-(x - mu)^2/2*sigma^2)
sum(x_density)/sum(x_density)
sum(x_density[x<=0])/sum(x_density)
sum(x_density[x<=0 & x>=-1])/sum(x_density)

sum(x_density[x<=1 & x>=-1])/sum(x_density)
sum(x_density[x<=.1 & x>=-0.1])/sum(x_density)
sum(x_density[x<=.01 & x>=-0.01])/sum(x_density)
sum(x_density[x<=.001 & x>=-0.001])/sum(x_density)
sum(x_density[x<=.0001 & x>=-0.0001])/sum(x_density)


## simulation using sample()
## let's approximate the normal distribution with a sample() function
x <- -6:6
x

## set mean and variance parameters
mu <- 0
sigma <- 1
sigma_pow2 <- sigma^2

## calculate the density using the normal distribution function dnorm() which is built into R
x_dnorm <- dnorm(x, mean=mu, sd=sigma) ## N(0,1)
x_dnorm


## simulate draws from a normal distribution
sim_size <- 10000

## approximate normal distribution using sample() function
x_samples <- sample(x, size=sim_size, replace=TRUE, prob=x_dnorm)
table(x_samples)
prob_weigth <- sim_size/sum(x_dnorm) ## calculate a weight so that the densities integrate to 1
x_dnorm_estimate <- table(x_samples)/prob_weigth ## modify with the weight
x_dnorm_estimate[names(x_dnorm_estimate)=='0'] ## approximate density when x is the mean for N(0,1)

dnorm(0)

barplot(x_dnorm_estimate, main="N() density approximated using sample()")
truehist(x_samples, main="N() density approximated using sample()")


## update the sequence so it is more fine grained (more values to draw)
x <- seq(from=-6, to=6, by=.5)
x
x_dnorm <- dnorm(x, mean=mu, sd=sigma)
x_dnorm
sim_size <- 10000

## approximate normal distribution using sample() function
x_samples <- sample(x, size=sim_size, replace=TRUE, prob=x_dnorm)
prob_weigth <- sim_size/sum(x_dnorm) ## calculate a weight so that the densities integrate to 1
x_dnorm_estimate <- table(x_samples)/prob_weigth ## modify with the weight
x_dnorm_estimate[names(x_dnorm_estimate)=='0'] ## approximate density when x is the mean for N(0,1)

barplot(x_dnorm_estimate, main="N() density approximated using sample()")
truehist(x_samples, main="N() density approximated using sample()")

## update the sequence so it is more fine grained (more values to draw)
x <- seq(from=-6, to=6, by=.1)
#x
x_dnorm <- dnorm(x, mean=mu, sd=sigma)
sim_size <- 10000

## approximate normal distirbution using sample() function
x_samples <- sample(x, size=sim_size, replace=TRUE, prob=x_dnorm)
prob_weigth <- sim_size/sum(x_dnorm) ## calculate a weight so that the densities integrate to 1
x_dnorm_estimate <- table(x_samples)/prob_weigth ## modify with the weight
x_dnorm_estimate[names(x_dnorm_estimate)=='0'] ## approximate density when x is the mean for N(0,1)
barplot(x_dnorm_estimate, main="N() density approximated using sample()")
truehist(x_samples, main="N() density approximated using sample()")


## simulate draws from the normal distribution using rnorm()
x_samples <- rnorm(sim_size, mean=mu, sd=sigma)
MASS::truehist(x_samples, main="N() density using rnorm()")
## more optional bonus problems



## update the sequence so it is more fine grained (more values to draw)
x <- seq(from=-10, to=10, by=.001)
#x
x_dnorm <- dnorm(x, mean=mu, sd=sigma)


sim_size <- 10000000

## approximate normal distribution using sample() function
x_samples <- sample(x, size=sim_size, replace=TRUE, prob=x_dnorm)
prob_weigth <- sim_size/sum(x_dnorm) ## calculate a weight so that the densities integrate to 1
x_dnorm_estimate <- table(x_samples)/prob_weigth ## modify with the weight
x_dnorm_estimate[names(x_dnorm_estimate)=='0'] ## approximate density when x is the mean for N(0,1)
dnorm(0,mean=mu, sd=sigma)

barplot(x_dnorm_estimate, main="N() density approximated using sample()")
truehist(x_samples, main="N() density approximated using sample()")


##########################################################################
## additional continuous probability distributions usually called density functions
##########################################################################
##
## Student's t-distribution
##
## R function names:
## dt
## pt
## qt
## rt
##
##########################################################################
## exponential distribution
##
## R function names:
## dexp
## pexp
## qexp
## rexp
##
##########################################################################
## chi-squared distribution
##
## R function names:
## dchisq
## pchisq
## qchisq
## rchisq
##
##########################################################################
## f-distribution
##
## R function names:
## df
## pf
## qf
## rf
##
##########################################################################
## gamma distribution
##
## R function names:
## dgamma
## pgamma
## qgamma
## rgamma
##
##########################################################################
## beta distributions
##
## R function names:
## dbeta
## pbeta
## qbeta
## rbeta
