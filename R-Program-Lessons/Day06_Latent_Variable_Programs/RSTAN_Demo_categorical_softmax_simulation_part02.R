## RSTAN_Demo_categorical_softmax_simulation_part2.R

## -------------------------------------------------- ##
## define STAN model
## -------------------------------------------------- ##
model <- "
data {
    // declared the data in memory
    int n;
    int<lower=1, upper=3> y[n];
    vector[n] x;
}
parameters {
    // declared the parameters in memory
    vector[3] alpha;
    real beta;
}
transformed parameters {
    vector[3] eta;
    matrix[3,n] prob_eta;
    
    //eta = alpha;
    
    for(i in 1:n){
        //eta = alpha + beta*x[i];
        //prob_eta[,i] = softmax(cumulative_sum(eta));
        prob_eta[,i] = softmax(cumulative_sum(alpha + beta*x[i]));
    }
}
model {
    // priors (these are variances not precision)
    alpha ~ normal(0,10);
    beta ~ normal(0,10);
    
    for(i in 1:n){  
      y[i] ~ categorical(prob_eta[,i]);
    }
}
"
## -------------------------------------------------- #

# Load packages
library(rstan)

n <- 1000
x <- rnorm(n,0,1)

## discrimination parameters
beta1 <- 3.000000

## cutpoint parameters
alpha1.1 <- -2.000000
alpha1.2 <- 2.000000

# linear terms of the model
xb1.1 <- alpha1.1 + beta*x
xb1.2 <- alpha1.2 + beta*x

# transform the linear xb terms using the logit function
# so that theta is bound from 0 to 1
eta1.1 <- 1 / (1 + exp(-xb1.1))
eta1.2 <- 1 / (1 + exp(-xb1.2))

P1.1 <- eta1.1
P1.2 <- eta1.2 - eta1.1
P1.3 <- 1 - eta1.2

# generate the items with theta and measurement error
y <- NA
for(i in 1:n){
  y[i] <- sample(c(1,2,3), size=1, replace=T, prob=c(P1.1[i],P1.2[i],P1.3[i]))
}

table(y)

boxplot(x ~ y)

## tell us how many items are binary and ordered respectively
data_list <- list(y=y, x=x, n=n)

## fit stan model
fit <- stan(model_code = model, data = data_list, iter = 1000, chains = 4, cores = 4)

## extract draws from stan model object
output <- extract(fit, permuted = TRUE)


mean(output$beta)

apply(output$prob_eta, 2, mean)
dim(output$prob_eta)

p1_hat <- apply(output$prob_eta[,1,], MARGIN=2, FUN=mean)
p2_hat <- apply(output$prob_eta[,2,], MARGIN=2, FUN=mean)
p3_hat <- apply(output$prob_eta[,3,], MARGIN=2, FUN=mean)

boxplot(p1_hat ~ y)
boxplot(p2_hat ~ y)
boxplot(p3_hat ~ y)
