## RSTAN_Demo_Measurement_logit_transformation_guessing_latent_variable_beta_simulation.R

theta <- seq(-50,5,.0001)
n <- length(theta)
n

beta <- c(seq(0.01, 0.1, .01), seq(0.2, 1, .1), 2:10, 25, 100, 1000, 100000)
beta

guessing_parameter <- 0.2 ## assumes a multiple choice question with one correct answer and 5 possible choices 

out_p <- list()

for(j in 1:length(beta)){
  ## set intercepts * an expansion factor, which is the item discrimination from above
  ## values correspond exactly to the position along the standard normal x variable
  ## specifically, these are the position along x at which point at which Pr(y=1)=.5
  alpha <- beta[j]*c(-3,-.5,0,2) ## the difficulty-position is scaled by beta into the difficulty parameter 
  
  # linear terms of the model
  # transform the linear xb terms using the logit function into a probability
  xb <- p <- y <- matrix(NA, nrow=n, ncol=length(alpha))
  for(i in 1:length(alpha)){
    xb[,i] <- alpha[i] + beta[j] * theta
    #p[,i] <- 1 / (1 + exp(-xb[,i]))
    p[,i] <- guessing_parameter + ((1-guessing_parameter) / (1 + exp(-xb[,i])))
    #p[,i] <- guessing_parameter + (1-guessing_parameter)*(1 / (1 + exp(-xb[,i]))) ## equivalent to the above
    #y[,i] <- rbinom(n, size=1, prob=p[,i])
  }
  
  out_p[[j]] <- p
}

mat <- do.call("cbind", out_p)
head(mat)

foo <- function(x){
  return(which.min(sqrt((.5 - x)^2)))
}

INDEX <- apply(mat,MARGIN=2, FUN=foo)
INDEX

matrix(theta[INDEX], ncol=4, byrow = T)

