##RSTAN_Demo_categorical_softmax_simulation_part1.R


## -------------------------------------------------- ##
## define STAN model
## -------------------------------------------------- ##
model <- "
data {
    // declared the data in memory
    int n;
    int<lower=1, upper=3> y[n];
}
parameters {
    // declared the parameters in memory
    vector[3] eta;
}
transformed parameters {
    vector[3] csum_eta; 
    vector[3] prob_eta;
    csum_eta = cumulative_sum(eta);
    //prob_eta = softmax(csum_eta);
    prob_eta = softmax(cumulative_sum(eta));
}
model {
    // priors (these are variances not precision)
    eta ~ std_normal();
    
    for(i in 1:n){  
      y[i] ~ categorical(prob_eta);
    }
}
"
## -------------------------------------------------- #

# Load packages
library(rstan)

y <- sample(1:3, size=1000, replace=TRUE, prob=c(.1,.25,.65))
n <- length(y)

## tell us how many items are binary and ordered respectively
data_list <- list(y=y, n=n)

## fit stan model
fit <- stan(model_code = model, data = data_list, iter = 1000, chains = 4, cores = 4)

## extract draws from stan model object
output <- extract(fit, permuted = TRUE)


apply(output$eta, 2, mean)

apply(output$csum_eta, 2, mean)

apply(output$prob_eta, 2, mean)


cbind(apply(output$eta, 2, mean), apply(output$csum_eta, 2, mean), apply(output$prob_eta, 2, mean))


exp((apply(output$csum_eta, 2, mean))) / sum(exp(apply(output$csum_eta, 2, mean)))

