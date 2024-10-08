#### R_Demo_text_as_data_DTM_stm_package.R
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
## This tutorial replicates the processes demonstrated in the R_Demo_text_as_data_DTM.R file.
##
## This code uses functions available in the tm package.
##
## The code is much much faster at processing the text data though some of the steps are difficul to lean from these functions.
##
##########################################################################


## load libraries
library(stm)
library(tm)
library(SnowballC)

## load data
data <- read.csv("Datasets/SIMpoliticalTweets.txt", header=FALSE)
data
names(data) <- "text"
data

#trumptweets <- fromJSON("trump_json_files_20190707.txt")
#data <- trumptweets

##
#data <- data[1:1000,]


## preprocess the documents
## This function uses function from the tm package (see the tm Demo for more details)
## stem words and remove stop words
prep <- textProcessor(documents=data$text, meta=data)

## list attributes
attributes(prep)

## inspect
head(prep$documents)
head(prep$vocab)
head(prep$meta)
prep$docs.removed


## pre Documents
## additional processing (removes some documents because of word frequencies greater than .99 or less than .01)
out <- prepDocuments(prep$documents, prep$vocab, prep$meta)
out

## inspect
head(out$documents)
head(out$vocab)
head(out$meta)

## fit a structural topic model
fit <- stm(documents=out$documents, vocab=out$vocab, data=out$meta, K=3)

## inspect attributes
attributes(fit)

dim(fit$theta)

## display topic probabilities
fit$theta

apply(fit$theta, 1, sum)

out$meta

data.frame(text = out$meta$text, topic1=fit$theta[,1], topic2=fit$theta[,2], topic3=fit$theta[,3])


