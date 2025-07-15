## RSTAN_Demo_ordered_logistic_regression_simulation.R
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
## For this R tutorial we will simulate an ordered dependent variable and then estimate the parameters that generate the variable. These parameters will be estimated based on the likelihood function that links them to the data contained in the y and x variables that are simulated observed data. The model produces the slope and intercept from a standard ordered logistic regression model, which is also estimated using polr() in R.
##
##########################################################################

## load library
library(rstan) # load rstan library
library(MASS) # loaed library with truehist function

## -------------------------------------------------- ##
## define STAN model
## -------------------------------------------------- ##
model <- "
    data {
        // declared the data in memory
        int<lower=0> n;
        int<lower=1, upper=3> y[n];
        vector[n] x;
    }
    // declared the parameters in memory
    parameters {
        ordered[2] cut_points;
        //real alpha1[2];
        real beta;
    }
    transformed parameters{
    
    }
    model {
        // priors (these are variances not precision)
        //alpha ~ normal(0,10);
        beta ~ normal(0,10);
        cut_points ~ normal(0,10);

        // likelihood (link data to some combination of parameters and more data)
        y ~ ordered_logistic(beta * x, cut_points);
    }
    generated quantities {
    // posterior predictions
    vector[n] y_predict;
    
    // the loop is necessary within the generated quantities block
    for(i in 1:n){
        y_predict[i] = ordered_logistic_rng(beta * x[i], cut_points);
    }
 
}

"
## -------------------------------------------------- ##


## simulate x1 and set the "true" population values alpha and beta
n <- 100
x <- rnorm(n,0,1)

beta1 <- 3.000000

## cutpoint parameters
alpha1.1 <- -4.000000
alpha1.2 <- -1.000000

# linear terms of the model
xb1.1 <- alpha1.1 - beta1 * x
xb1.2 <- alpha1.2 - beta1 * x

# transform the linear xb terms using the logit function
# so that theta is bound from 0 to 1
eta1.1 <- 1 / (1 + exp(-xb1.1))
eta1.2 <- 1 / (1 + exp(-xb1.2))

P1.1 <- eta1.1
P1.2 <- eta1.2 - eta1.1
P1.3 <- 1 - eta1.2

# generate the items with theta and measurement error
y <- c()
for(i in 1:n){
  y[i] <- sample(c(0,1,2), size=1, replace=TRUE, prob=c(P1.1[i],P1.2[i],P1.3[i]))
}
table(y)

## inspect the y matrix
head(y, 10)

## no matter the scale is, we need the min of the scale to be 1 for the Stan program
y <- y+1

## inspect 1 more time 
head(y, 10)
table(y)

## create data list
data_list <- list(y = y, x=x, n=n)

## fit linear model
summary(polr(as.factor(y)~x))

## fit stan model
fit <- stan(model_code = model, data = data_list, iter = 1000, chains = 4, cores=4)

fit

## extract draws from stan model object
output <- extract(fit, permuted = TRUE)

## print names
names(output)

## there are number of methods to subset and summarize parameters
## keep in mind that the output object is a list that contains vectors or matrices of of posterior estimates for each of the named parameter defined in the model statement above
## lapply (list-apply) a function to all of the objects in the list
lapply(output, mean)
lapply(output, sd)

## tabulate the simulated binary dependent variable it should be very close to the mean value of the predicted y
table(y)

## create a matrix using some of the named slots in the list
model_parameters <- as.matrix(fit, pars = c("cut_points", "beta"))
model_predictions <- as.matrix(fit, pars = "y_predict")

## check the dimensions (they should be the same)
dim(model_predictions)
dim(output$y_predict)

## plot the simulated y variable and the estimated posterior means
plot(apply(model_predictions,2,mean), y)


apply(model_parameters, 2, mean)


boxplot(model_parameters)

par(mfrow=c(1,2))
truehist(model_parameters[,1])
truehist(model_parameters[,2])
truehist(model_parameters[,3])

