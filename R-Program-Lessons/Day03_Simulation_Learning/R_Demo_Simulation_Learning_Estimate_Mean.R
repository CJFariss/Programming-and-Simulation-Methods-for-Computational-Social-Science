## R_Demo_Simulation_Learning_Estimate_Mean.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Programming and Simulation Methods for Computational Social Science (2W)
## University of Essex Summer School 2023
##
## Date: 2024-07-22
##
## Please e-mail me if you find any errors or have and suggestions (either email is fine)
## e-mail: cjf0006@gmail.com
## e-mail: cjfariss@umich.edu
##
##########################################################################
## Introduction to tutorial:
##
## (1a) Use the normal density function to see that it is useful for many applications
## (1b) Specifically, we will estimate a mean instead of calculating it directly using a combination of values from the normal density function
## (1c) Use a normal density function to construct a likelihood function or loss function to evaluate how well/close the estimate mean is to the observed data values
## (2) Observe that calculating the true mean is very simple so it is easy to verify that the combination of density functions gives the same answer as the simple calculation
## (3) Note that there are more complicated models where estimating the best set of parameters is not as easy as simply calculating the mean. We will use this combination of density function values to find the best set of parameters. Sometimes this is called maximum likelihood estimation or MLE for short
##
##########################################################################
##
## This tutorial estimates the mean value from a vector of numeric data using the notion of distance.
## 
## Instead of calculating the mean directly, we will estimate the mean by minimizing a function that compares a range of possible estimates of the mean to the data we obtained in the vector (i.e., distance between possible estimate and each of the data points).
##
## The program below finds a range of possible values.
## These values include the maximum value of the log-likelihood which summarizes the disagreement/distance between a potential estimate of the mean and each of the observed data points in the data vector.
##
## This algorithm will provide the same answer as the algorithm for finding the average, which is taught to each of us in grade school.
##
## We will consider several loss-statistics. 
##
## These loss-statistics simply calculate the distance between a parameter estimate or our best guess AND a set of data points. 
##
## We are calculating distances for each observation in a dataset and summarizing these distances. 
## Sometimes we will call these distances something else: usually error or sometimes difference. 
## We will consider another loss function, gradient descent, later in the course.
##
##########################################################################

## install the library if necessary
## load packages
pkgs <- c("MASS")
invisible(sapply(pkgs, require, character.only = TRUE))

## create sequence of real numbers
#x <- seq(-3,3,.1)
x <- 1:5
x
mean(x)

## set mean and variance parameters
mu <- 0
sigma <- 1
sigma_pow2 <- sigma^2

## calculate the density using the normal distribution function
x_density <- 1/(sigma*sqrt(2*pi)) * exp(-(x - mu)^2/2*sigma^2)
x_density

## plot the two estimated densities to verify that they are the same
plot(x, x_density)

## calculate the density using the normal distribution function built into R
x_dnorm <- dnorm(x, mean=mu, sd=sigma)
x_dnorm

## plot the two estimated densities to verify that they are the same
plot(x, x_dnorm)

## program a function
normal_density <- function(data, mu, sigma){
  1/(sigma*sqrt(2*pi)) * exp(-(data - mu)^2/2*sigma^2)
}

## let's change the mean
normal_density(data=x, mu=3, sigma=1)

## plot the two estimated densities to verify that they are the same
par(mfrow=c(1,1), mar=c(4,4,1,1))
plot(x, normal_density(data=x, mu=0, sigma=1))
plot(x, normal_density(data=x, mu=1, sigma=1))
plot(x, normal_density(data=x, mu=2, sigma=1))
plot(x, normal_density(data=x, mu=3, sigma=1))
plot(x, normal_density(data=x, mu=4, sigma=1))
plot(x, normal_density(data=x, mu=5, sigma=1))

## data (we want the mean estimate for this numeric vector)
x <- c(1,2,3,4,5)
x

mean(x)
sum(x)/length(x)

## fix sigma to 1
sigma <- 1

## let's check to see if the best estimate for the mean is 1
mu <- 1
sum(log(1/(sigma*sqrt(2*pi)) * exp(-(x - mu)^2/2*sigma^2)))
prod(1/(sigma*sqrt(2*pi)) * exp(-(x - mu)^2/2*sigma^2))

prod(1:3)

## let's check to see if the best estimate for the mean is 2
mu <- 2
sum(log(1/(sigma*sqrt(2*pi)) * exp(-(x - mu)^2/2*sigma^2)))

## let's check to see if the best estimate for the mean is 3
mu <- 3
sum(log(1/(sigma*sqrt(2*pi)) * exp(-(x - mu)^2/2*sigma^2)))

## let's check to see if the best estimate for the mean is 4
mu <- 4
sum(log(1/(sigma*sqrt(2*pi)) * exp(-(x - mu)^2/2*sigma^2)))

## let's check to see if the best estimate for the mean is 5
mu <- 5
sum(log(1/(sigma*sqrt(2*pi)) * exp(-(x - mu)^2/2*sigma^2)))

## is there any value of mu that generates a larger sum of logged values than 3?


## data (we want the mean estimate for this numeric vector)
x <- c(1,2,3,4,5)
x

#x <- runif(100)
truehist(x)

## vector to keep track of the loss function values
sum_log_dens <- NA
sum_log_dens_dnorm <- NA
sum_dens_ssqd <- NA
min_sum_dens_ssqd <- NA

## candidate values for our estimate of mu, which is the mean value we are trying to estimate
mu_hat <-seq(-10,10,.5)
mu_hat

## loop through all the mu_hat values to determine which one is the best using the sum of the logged densities
for(i in 1:length(mu_hat)){
  
  ## set mu_hat value to mu for the loss evaluation (mu is different for each iteration of the loop)
  mu <- mu_hat[i]
  
  ## normal density loss function
  sum_log_dens[i] <- sum(log(1/(sigma*sqrt(2*pi)) * exp(-(x - mu)^2/2*sigma^2)))
  
  ## dnorm loss function
  sum_log_dens_dnorm[i] <- sum(log(dnorm(x=x,mean=mu,sd=sigma)))
  
  ## ssdq sum of squared differences loss function (maximize)
  sum_dens_ssqd[i] <- sum((x-mu)^2)
  
  ## negative ssdq sum of squared differences loss function (minimize)
  min_sum_dens_ssqd[i] <- -sum((x-mu)^2)
  
}

par(mfrow=c(2,2), mar=c(4,4,2,.5))

## plot the normal density loss function
plot(mu_hat, sum_log_dens, main="normal density loss function")
abline(v=mean(x), col=2, lwd=3)

## plot the dnorm loss function
plot(mu_hat, sum_log_dens_dnorm, main="normal density loss function")
abline(v=mean(x), col=2, lwd=3)

## plot the ssdq sum of squared differences loss function
plot(mu_hat, sum_dens_ssqd, main="minimized squared differences loss function")
abline(v=mean(x), col=2, lwd=3)

## plot the ssdq sum of squared differences loss function
plot(mu_hat, min_sum_dens_ssqd, main="squared differences loss function")
abline(v=mean(x), col=2, lwd=3)

##########################################################################
## apply the density function and the equation for the log-likelihood, which is a loss function
##########################################################################

## make a very simple dataset
simple_data <- 1:5

## print the data
simple_data


##########################################################################
## what is the density for each value in the dataset if we assume mu, the average, is 1?
normal_density(data=simple_data, mu=1, sigma=1)

## what is the density for each value in the dataset if we assume mu, the average, is 2?
normal_density(data=simple_data, mu=2, sigma=1)

## what is the density for each value in the dataset if we assume mu, the average, is 3?
normal_density(data=simple_data, mu=3, sigma=1)

## what is the density for each value in the dataset if we assume mu, the average, is 4?
normal_density(data=simple_data, mu=4, sigma=1)

## what is the density for each value in the dataset if we assume mu, the average, is 4?
normal_density(data=simple_data, mu=4, sigma=1)

##########################################################################
## note: we can summarize these values by using the loss function defined above, which we called the log-likelihood
##########################################################################

## we can multiple all the densities together to get the likihood statistic
prod(normal_density(data=simple_data, mu=1, sigma=1))
prod(normal_density(data=simple_data, mu=2, sigma=1))
prod(normal_density(data=simple_data, mu=3, sigma=1))
prod(normal_density(data=simple_data, mu=4, sigma=1))
prod(normal_density(data=simple_data, mu=5, sigma=1))

## we can take the sum of the all the logged densities to get the log-likihood statistic (we usually multiply by -1 so the we mind the min instead of the max. consistent with the likihood function)
-sum(log(normal_density(data=simple_data, mu=1, sigma=1)))
-sum(log(normal_density(data=simple_data, mu=2, sigma=1)))
-sum(log(normal_density(data=simple_data, mu=3, sigma=1)))
-sum(log(normal_density(data=simple_data, mu=4, sigma=1)))
-sum(log(normal_density(data=simple_data, mu=5, sigma=1)))

## we can transform the log-likelihood into the likelihood statistic by using the exponentiation function exp()
exp(sum(log(normal_density(data=simple_data, mu=1, sigma=1))))
exp(sum(log(normal_density(data=simple_data, mu=2, sigma=1))))
exp(sum(log(normal_density(data=simple_data, mu=3, sigma=1))))
exp(sum(log(normal_density(data=simple_data, mu=4, sigma=1))))
exp(sum(log(normal_density(data=simple_data, mu=5, sigma=1))))

## another commonly used loss statistic is the root-mean-squared-error which we use in later programs because it is a bit easier to think about
sqrt(mean((simple_data-1)^2))
sqrt(mean((simple_data-2)^2))
sqrt(mean((simple_data-3)^2))
sqrt(mean((simple_data-4)^2))
sqrt(mean((simple_data-5)^2))

##########################################################################
## note: that all of these statistics are in agreement that our best guess at the values of the dataset, in terms of the ability of our single guess to reduce the distance between the guess of the single parameter and each data point is the simple average
##########################################################################

##########################################################################
## let's do this via a simulation now
##########################################################################

## specify the number of units
sample_size <- 2000
sample_size

## take a random draw of units given a mean that we as the researcher/programmer/data-scientist
## let's use pi for fun but it can be any number (note that we are not estimating the variance for this exercise)
x <- rnorm(sample_size, mean=pi, sd=1)

truehist(x)


## specify values of mu to check (what happens as we decrease the distance between guesses?)
mu_hat <- seq(0,5,0.001)

## loop through all values of mu_hat and calculate the loglik statistic for each
loglik <- c()
for(i in 1:length(mu_hat)){
    loglik[i] <- -sum(log(normal_density(data=x, mu=mu_hat[i], sigma=1)))
}

plot(mu_hat, loglik, type="l", lwd=2)

## which value is the minimum?
coordinate <- which(loglik==min(loglik))
coordinate

## which coordinate minimizes the loglik for the best mu_hat value?
mu_hat[coordinate]

## what is the calculated average?
mean(x)

# pass function to optim with initial values
loglik_func <- function(par, data){
    -sum(log(normal_density(data=data, mu=par, sigma=1)))
}

optim.out <- optim(par = c(0), fn=loglik_func, data=x, method="BFGS")
optim.out

## estimate mean from the optim function
optim.out$par

## empirical mean
mean(x)

## the difference between the estimated parameter and the empirical mean is vanishingly small
optim.out$par - mean(x)

##########################################################################
## Question: what if we repeated this process over and over again? 
## Would the average of the simulations coverage towards the true value of pi?
##
## Notes: The Central Limit Theorem (CLT) establishes that when independently generated variables (iid: independent and identically distributed random variables) are added together, the sums or averages of these variables (when normalized) converge towards a normal distribution. 
## This property emerges even if the original variables are not individually normally distributed, as with the roll of a die. 
## The probability of any value from the single roll of die is equivalent to any other value for the same-sided die in the limit (when the number of rolls approaches infinity).
##
##########################################################################



