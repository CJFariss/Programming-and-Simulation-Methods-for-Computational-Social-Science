## https://tensorflow.rstudio.com/install/

# Install devtools
install.packages("devtools")

# Install tensorflow:
devtools::install_github("rstudio/tensorflow")

# install reticulate:
install.packages("reticulate")

# Load library
library(reticulate)

# Python version
use_python("/usr/local/bin/python3")

# Python environment:
#use_virtualenv("myenv")

library(tensorflow)

# Install tensorflow
install_tensorflow()

library(tensorflow)
install_tensorflow(envname = "r-tensorflow")

install.packages("keras")
library(keras)
install_keras()

library(tensorflow)

tf$constant("Hello TensorFlow!")
