# Programming-and-Simulation-Methods-for-Computational-Social-Science

## Introduction
Course Title: *Programming and Simulation Methods for Computational Social Science* (2W)

Course Date: Monday 22 July – Friday 3 August 2024

Key Course Objective: **Learn to program. Program to learn.**

Essex Course Website: https://essexsummerschool.com/summer-school-facts/courses/ess-2024-course-list/2w/

### Past Course Syllabi 
- [Current Syllabus](https://github.com/CJFariss/Programming-and-Simulation-Methods-for-Computational-Social-Science)
- [2022/2023 Syllabus](https://github.com/CJFariss/Advanced-Computational-Methods-for-Social-Media-and-Text-Data)
- [2021/2020 Syllabus](http://cfariss.com/documents/Essex_Advanced_Computaitonal_Methods_2020_Syllabus.pdf)
- [2019/2018 Syllabus](http://cfariss.com/documents/Essex_2F_2019_Syllabus.pdf)
- [2017/2016 Syllabus](http://cfariss.com/documents/Essex_Exploration_Analysis_Social_Media_Data.pdf)
- [2015 Syllabus](http://cfariss.com/documents/Essex_Analyzing_Big_Data.pdf)

## Information about the Course 
### Course Content
This course focuses on the research design and data analysis tools used to explore and understand social media and text data using computational and simulation based methods in R. The fundamentals of research design are the same throughout the social sciences, however the topical focus of this class is on computationally intensive data generating processes and the research designs used to understand and manipulate such data at scale. 

By massive or large scale, I mean that there are lots of subjects/connections/units/rows in the data (e.g., social network data like the kind available from twitter), or there are lots of variables/items/columns in the data (e.g., image or text data with many thousands of columns that represent the words in the document corpus), or the selected analytical tool is a computationally complex algorithm (e.g., a Bayesian simulation for modeling a latent variable, a random forest model for exploratory data analysis, or a neural network for automatically classifying new observations), or finally some combination of these three issues. The course will provide students with the tools to design observational studies and experimental interventions into large and unstructured data sets at increasingly massive scales and at different degrees of computational complexity. 

How will we go about learning these tools? In this class, we will learn to program and program to learn. What do I mean? First, we will use the R program environment to learn the building blocks of programming. These skills are essential for managing the increasingly large and complex datasets of interest to social scientists (e.g., image data, text data).

As we develop programming skills in R, we will use them to help us understand how different types of data analysis tools work. For example, by the end of the course, students will be able to program and evaluate their own neural network or structural topic model from scratch. 

We will start very small and learn how to scale up. In the beginning of the course, we will not make use of many packages other than the base packages available by default in R. As we proceed, we will learn how models for data work before then investigating the functions that exist in the large, always increasing catalogue of packages available for you to use in R. The development of new functions in R is advancing rapidly. The tools you learn in this class will help you improve as a programmer and a data scientists but learning how to program and using your programming skills to learn how to analyze data.

### Course Objectives
Students will learn how to design models for data that take advantage of the wealth of information contained in new massive scale online datasets such as data available from twitter, images, and the many newly digitized document corpuses now available online. The focus of the course is on learning to program in R with special attention paid to designing studies in such a way as to maximize the validity of inferences obtained from these complex datasets. 

1. Learn to program models in R at a small scale using the base package and a minimal number of other packages.
2.  Use the tools from research design to assist in model development
3. Validate models of observational data in comparison to an appropriate baseline model
4. Develop simulation based models for large scale, observational data
5. Develop and validate measurement (e.g., latent variable models, structural topic models) and classification models (e.g., neural networks) of text and image based data

### Course Prerequisites
Students should have some familiarity with concepts from research design and statistics. Generally, exposure to these concepts occurs during the first year course at a typical PhD program in political science. Students should also have familiarity with the R computing environment. The more familiarity with R the better. 

### Course Details
1. We will begin each class period with a ``programming challenge'' (approximately 20-25 minutes). 
2. I will then give a short lecture over the class material (approximately 30-45 minutes). 
3. On the first day of class, I will introduce students to two large scale datasets. Students will use these data for applied examples over the 10 days of the course. 
4. The remaining portion of class (approximately 1.5-2 hours) will be devoted to hands on learning with R, simulated data, and the large scale datasets provided by the instructor. 
5. The course schedule section, which is below, provides even more details about the topic of the lecture for each class day, citations for the discussion readings, and chapter entries from the text books for the programming and data analysis tools covered in the class.
<br/>

## Install R and Rstudio
1. R: https://cran.r-project.org/
2. Rstudio: https://posit.co/download/rstudio-desktop/

## Folder Descriptions
- [R-Program-Lessons](./R-Program-Lessons): contains 10 folders with R programming lessons designed for each day of the course. More details about each lesson are contained in the schedule of classes descriptions below.
    - [Day01_Intro_programs](./R-Program-Lessons/Day01_Intro_programs)
    - [Day02_Data_Analysis_Managment](./R-Program-Lessons/Day02_Data_Analysis_Managment)
    - [Day03_Simulation_Learning](./R-Program-Lessons/Day03_Simulation_Learning)
    - [Day04_Simulation_Inference](./R-Program-Lessons/Day04_Simulation_Inference)
    - [Day05_Measurement_Intro](./R-Program-Lessons/Day05_Measurement_Intro)
    - [Day05_Measurement_RSTAN](./R-Program-Lessons/Day05_Measurement_RSTAN)
    - Day06
    - Day07
    - Day08
    - Day09
    - Day10
 <br/>
   
## Required Readings
There are no *required* books in this course. Rather, I will make reference to material listed below in rough proportion to the *suggested books* > *additional suggested books* > *other related readings*. There are also a set of applied articles that I will make reference to as well in the *other related readings* subsections. Think of these as useful references and places to find examples. The primary course content will be the R programing lessons.

### Suggested Books
1. Jones, Owen, Robert Maillardet, and Andrew Robinson. 2014. *Introduction to Scientific Programming and Simulation Using R.* Second Edition. CRC Press. https://nyu-cdsc.github.io/learningr/assets/simulation.pdf
2. Matloff, Norman. 2011. *Art of R Programming: A Tour of Statistical Software Design.* no starch press. https://nostarch.com/artofr.htm


### Additional Suggested Books
1. Bolker, Ben. 2007. *Ecological Models and Data in R* Princeton NJ: Princeton University Press. https://press.princeton.edu/books/hardcover/9780691125220/ecological-models-and-data-in-r
2. Davies, Tilman M. 2016. *The Book of R: A First Course in Programming and Statistics.* no starch press. https://nostarch.com/bookofr
3. Efron, Bradley and Trevor Hastie. 2016. *Computer Age Statistical Inference* Cambridge University Press. https://web.stanford.edu/~hastie/CASI/
4. Gelman,Andrew and Jennifer Hill. 2007. Data Analysis Using Regression and Multilevel/Hierarchical Models. Cambridge: Cambridge University Press. http://www.stat.columbia.edu/~gelman/arm/
5. Matloff, Norman. 2024. *The Art of Machine Learning: A Hands-On Guide to Machine Learning with R* no starch press. https://nostarch.com/art-machine-learning

### Suggested User Guides and Reference Manuals.
1. Stan Development Team. 2024. *Stan Modeling Language: User's Guide and Reference Manual. Version 2.35.* https://mc-stan.org/docs/stan-users-guide/index.html
2. Wickham, Hadley. “The tidyverse style guide” https://style.tidyverse.org 
3. R graph gallery. http://r-graph-gallery.com/
<br/>


# Class Schedule and Content links

## Day 1: Introduction to Learning and Inference making using Simulation and Programming
Introduction to the simulation and research design tools used to explore and understand various kinds of simulated and observed data (e.g., survey data, human rights data, social media data, text data, etc). We will also begin working with the program challenges, many of which are available here: https://github.com/CJFariss/R-Program-Challenges

#### Program Lessons
- [R-Program-Lessons/Day01_Intro_programs](./R-Program-Lessons/Day01_Intro_programs)

#### Program Challenges
- [R_Demo_Intro_Program_Challenge_two_sum.R](https://github.com/CJFariss/Programming-and-Simulation-Methods-for-Computational-Social-Science/blob/main/R-Program-Lessons/Day01_Intro_programs/R_Demo_Intro_Program_Challenge_two_sum.R)

#### Suggested Readings:
1. Jones, Maillardet, and Robinson 2014. (Ch.1 *Setting up*, Ch2. *R as a calculating environment*). 
2. Matlofff 2011. (Ch.2: *Getting Started*).

#### Additional Suggested Readings:
3. Borsboom, Denny, Gideon J. Mellenbergh, and Jaap van Heerden. 2004. “The Concept of Validity” *Psychological Review* 111(4):1061-71. https://doi.org/10.1037/0033-295X.111.4.1061

<br/>

## Day 2: Data Management and Analysis for Large Scale Data Structures
Introduction to the R programming environment. We will review the various data and programming structures that are available for use in R. We will pay particular attention to vectorization and parallelization. Though we will begin with very small programs for learning, we also need to remember that the massive scale datasets that are increasingly available need optimized programs designed to manage and analyze these massive scale data structures.

#### Program Lessons
- [R-Program-Lessons/Day02_Data_Analysis_Managment](./R-Program-Lessons/Day02_Data_Analysis_Managment)

#### Program Challenges
- [R_Challenge_vector_1max_2max_3max_nmax.R](https://github.com/CJFariss/R-Program-Challenges/blob/main/R-Program-Challenges/R_Challenge_vector_1max_2max_3max_nmax.R)
- [R_Challenge_vector_matrix_array_coordinate_distances.R](https://github.com/CJFariss/R-Program-Challenges/blob/main/R-Program-Challenges/R_Challenge_vector_matrix_array_coordinate_distances.R)

#### Suggested Readings:
1. Jones, Maillardet, and Robinson 2014. (Ch.3: *Basic programming*, Ch.4: *I/O Input and output*, Ch.5: *Programming with functions*, Ch.6: *Sophisticated data structures*, Ch.7: *Better graphics*, Ch.8 *Points to further programming techniques*). 
2. Matlofff 2011. (Ch.2: *Vectors*, Ch.3: *Matrices and Arrays*, Ch.4: *Lists*, Ch.5: *Data Frames*, Ch.6: *Factors and Tables*, Ch.7: *R Programming Structures*, Ch.14: *Performance Enhancement: Speed and Memory*, Ch.16: *Parallel R*).

#### Additional Suggested Readings:
3. Bolker (Ch.2, *Exploratory data analysis and graphics*)
4. Matlofff 2011 (Ch.9: *Object-Oriented Programming*, Ch.13: *Debugging*).
5. Wickham, Hadley. “The tidyverse style guide” https://style.tidyverse.org 
6. R graph gallery. http://r-graph-gallery.com/
<br/>

## Day 3: Simulation Based Programming and Inference
We will develop and implement simulations in R to accomplish two learning goals. For the first learning goal, we will develop simulations in R to help us practice all of the programming and data structures that are available in R. For the second learning goal, we will use our programming knowledge in R to create simple step-by-step programs that showcase how a specific statistical or algorthmic tool works. 

#### Program Lessons
- [R-Program-Lessons/Day03_Simulation_Learning](./R-Program-Lessons/Day03_Simulation_Learning)

#### Program Challenges
- [R_Challenge_matrix_Sudoku_check.R](https://github.com/CJFariss/R-Program-Challenges/blob/main/R-Program-Challenges/R_Challenge_matrix_Sudoku_check.R)
- [R_Challenge_simulation_shuffle_index.R](https://github.com/CJFariss/R-Program-Challenges/blob/main/R-Program-Challenges/R_Challenge_simulation_shuffle_index.R)
- [R_Challenge_vector_sqrt_search.R](https://github.com/CJFariss/R-Program-Challenges/blob/main/R-Program-Challenges/R_Challenge_vector_sqrt_search.R)

#### Suggested Readings:
1. Rubin, Donald B. 2008. “For Objective Causal Inference, Design Trumps Analysis.” *Annals of Applied Statistics* 2(3):808-840. https://doi.org/10.1214/08-AOAS187

#### Additional Suggested Readings:
2. Efron and Hastie (Ch.1 *Algorithms and Inference*, Ch.3 *Bayesian Inference*, Ch.4, *Fisherian Inference and Maximum Likelihood Estimation*).
3. Gelman and Hill (Ch.2 *Concepts and methods from basic probability and statistics*, Ch.7 *Simulation of probability models and statistical inferences*).
4. Jones, Maillardet, and Robinson 2014. (Ch.14: *Probability*, Ch.15: *Random variables*, Ch.16: *Discrete random variables*, Ch.17 *Continuous random variables*, Ch.18 *Parameter estimation*). 
5. Shadish, William R. 2010. “Campbell and Rubin: A Primer and Comparison of Their Approaches to Causal Inference in Field Settings.” *Psychological Methods* 15(1):3-17. https://doi.org/10.1037/a0015916
6. Shmueli, Galit. 2010. “To Explain or to Predict?” *Statistical Science* 25(3):289-310. http://dx.doi.org/10.1214/10-STS330
<br/>

## Day 4: Simulation Based Programming for Model Comparison and Selection
In this section, we will program and learn several simulation based validation tools for assessing a model of observational data in comparison to an appropriate baseline model. Specifically, we will learn to evaluate model performance using in-sample and out-of-sample data.

#### Program Lessons
- [R-Program-Lessons/Day04_Simulation_Inference](./R-Program-Lessons/Day04_Simulation_Inference)

#### Program Challenges
- [R_Challenge_simulation_weather_forecast.R](https://github.com/CJFariss/R-Program-Challenges/blob/main/R-Program-Challenges/R_Challenge_simulation_weather_forecast.R)
- [R_Challenge_probability_distributions.R](https://github.com/CJFariss/R-Program-Challenges/blob/main/R-Program-Challenges/R_Challenge_probability_distributions.R)

#### Suggested Readings:
1. Matlofff 2011 (Ch.8: *Doing Math and Simulations in R*)

#### Additional Suggested Readings:
2. Bolker (Ch.5, *Stochastic simulation and power analysis*)
3. Efron and Hastie (Ch.7 *James-Stein Estimation and Ridge Regression*, Ch.10, *The Jackknife and Bootstrap*, Ch.11, *Bootstrap Confidence Intervals*, Ch.12, *Cross-Validation and Cp Estimate of Prediction Error*)
4. Gelman and Hill (Ch.8 *Simulation for checking statistical procedures and model fits*).
5. Jones, Maillardet, and Robinson 2014. (Ch.20: *Simulation*, Ch.21: *Monte Carlo Integration*, Ch.22: *Variance reduction*). 


<br/>


## Day 5: Applied Simulation to Measure and Validate Latent Variable Models
Measurement, as a scientific process, should accomplish two related tasks. First, link a theoretical concept to a data generating procedure. Second, link the data generating procedure to observed information. In this section we continue our focus on text as data, which is almost always found and not generated explicitly by a researcher. This means that we need to consider both the concept and the data generating process as part of our research program. What does this mean?
 
Social scientists are often interested in explaining concepts that are difficult or impossible to observe. Examples of unobservable concepts include political knowledge, political ideology, democracy, respect for human rights, or inequality. Even concepts that are based on directly observable information such as the number of individuals that reside in a state, the number of individuals killed during a conflict, or the level of economic output are often not easily observed. A key challenge for political scientists and social scientists generally, is creating models that can measure these concepts while also capturing the uncertainty associated with the processes by which they are measured. 

This sections provide an introduction to measurement models generally with specific focus on Bayesian measurement models and measurement models that make use of text data. We will emphasize the use of construct validity to assess new and existing measures in applied research. We will motivate the development of these models with a discussion of the Bayesian perspective on the relationship between data and model parameters. This perspective is useful because it shifts the burden of validity from the primary source documentation and raw data to the model parameters that bind these diverse pieces of information together.

#### Program Lessons
- [R-Program-Lessons/Day05_Measurement_Intro](./R-Program-Lessons/Day05_Measurement_Intro)
- [R-Program-Lessons/Day05_Measurement_RSTAN](./R-Program-Lessons/Day05_Measurement_RSTAN)

#### Program Challenges
- []()

#### Suggested Readings:
1. Fariss, Christopher J., Michael R. Kenwick, and Kevin Reuning "Measurement Models", in *SAGE Handbook of Research Methods is Political Science & International Relations*, edited by Luigi Curini and Robert J. Franzese, Jr., SAGE Press (May 2020). http://cfariss.com/documents/FarissKenwickReuning2020_MesurementModels.pdf 

#### Additional Suggested Readings:
2. Adcock, Robert, and David Collier. 2001. “Measurement Validity: A Shared Standard for Qual- itative and Quantitative Research.” American Political Science Review 95(3):529-546. https: //doi.org/10.1017/S0003055401003100
3. Jones, Maillardet, and Robinson 2014. (Ch.19: *Markov chains*). 
4. Efron and Hastie (Ch.13, *Objective Bayes Inference and MCMC*).
5. Gelman and Hill (Ch.13, *Multilevel linear models: varying slopes, non-nested models, and other complexities*, Ch.14, *Multilevel logistic regression*, Ch.16, *Multilevel modeling in Bugs and R: the basics*, Ch.25, *Missing-data imputation*).

<br/>


## Day 6: Bayesian Latent Variable Models 
Under construction

<br/>

## Day 7: Measurement Models for Reducing High Dimensional Data
Introduction to Regular Expressions, Document-by-Term matrices, and Construct Validity. We will continue to use simple R programs to help us understand some of the common and important text and image processing steps. Much of the work involved in using text as data is in the processing of the character/string information. Regular expressions are the key functions that we will use. These key functions are embedded in many many R packages. We will start with the basics before move to more efficient libraries, again with the idea that we will learn the nuts and bolts of these critical tools.

#### Program Lessons

#### Program Challenges
1. [R_Challenge_text_character_graph.R](https://github.com/CJFariss/R-Program-Challenges/blob/main/R-Program-Challenges/R_Challenge_text_character_graph.R)


<br/>

## Day 8: Automating Classification with Neural Networks and Large Language Models (LLMs)
Neural Networks are a powerful tool for automated classification and any other predictive task. The main hurdle to understanding how these models work is the terminology associated with their implementation and use. During this section, we will see that a neural network is simply a linear model at its core and a set of liner transformations in the more exotic varieties of these models. Once we understand the basic building blocks of these models, we will see that neural networks are straight forward to implement but computationally quite expensive when implementing them on massive scale datasets. As usual, we will start with very simple models to learn. We will then apply this learning to more complex implementations of these models. We will use all of the tools developed during prior class periods to evaluate the performance of these models relative to a substantively meaningful baseline model.

#### Program Lessons

#### Program Challenges
1. [R_Challenge_matrix_MNIST_images.R](https://github.com/CJFariss/R-Program-Challenges/blob/main/R-Program-Challenges/R_Challenge_matrix_MNIST_images.R)
<br/>

## Day 9: False Discovery and Inference After the Design and Selection of a Model
Techniques for selecting a substantively meaningful model.

<br/>

## Day 10:
Under construction
