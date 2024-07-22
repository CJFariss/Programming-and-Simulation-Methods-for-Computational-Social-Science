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

## Course Content
This course focuses on the research design and data analysis tools used to explore and understand social media and text data using computational and simulation based methods in R. The fundamentals of research design are the same throughout the social sciences, however the topical focus of this class is on computationally intensive data generating processes and the research designs used to understand and manipulate such data at scale. 

By massive or large scale, I mean that there are lots of subjects/connections/units/rows in the data (e.g., social network data like the kind available from twitter), or there are lots of variables/items/columns in the data (e.g., image or text data with many thousands of columns that represent the words in the document corpus), or the selected analytical tool is a computationally complex algorithm (e.g., a Bayesian simulation for modeling a latent variable, a random forest model for exploratory data analysis, or a neural network for automatically classifying new observations), or finally some combination of these three issues. The course will provide students with the tools to design observational studies and experimental interventions into large and unstructured data sets at increasingly massive scales and at different degrees of computational complexity. 

How will we go about learning these tools? In this class, we will learn to program and program to learn. What do I mean? First, we will use the R program environment to learn the building blocks of programming. These skills are essential for managing the increasingly large and complex datasets of interest to social scientists (e.g., image data, text data).

As we develop programming skills in R, we will use them to help us understand how different types of data analysis tools work. For example, by the end of the course, students will be able to program and evaluate their own neural network or structural topic model from scratch. 

We will start very small and learn how to scale up. In the beginning of the course, we will not make use of many packages other than the base packages available by default in R. As we proceed, we will learn how models for data work before then investigating the functions that exist in the large, always increasing catalogue of packages available for you to use in R. The development of new functions in R is advancing rapidly. The tools you learn in this class will help you improve as a programmer and a data scientists but learning how to program and using your programming skills to learn how to analyze data.

## Course Objectives
Students will learn how to design models for data that take advantage of the wealth of information contained in new massive scale online datasets such as data available from twitter, images, and the many newly digitized document corpuses now available online. The focus of the course is on learning to program in R with special attention paid to designing studies in such a way as to maximize the validity of inferences obtained from these complex datasets. 

1. Learn to program models in R at a small scale using the base package and a minimal number of other packages.
2.  Use the tools from research design to assist in model development
3. Validate models of observational data in comparison to an appropriate baseline model
4. Develop simulation based models for large scale, observational data
5. Develop and validate measurement (e.g., latent variable models, structural topic models) and classification models (e.g., neural networks) of text and image based data

## Course Prerequisites
Students should have some familiarity with concepts from research design and statistics. Generally, exposure to these concepts occurs during the first year course at a typical PhD program in political science. Students should also have familiarity with the R computing environment. The more familiarity with R the better. 

## Course Details
1. We will begin each class period with a ``programming challenge'' (approximately 20-25 minutes). 
2. I will then give a short lecture over the class material (approximately 30-45 minutes). 
3. On the first day of class, I will introduce students to two large scale datasets. Students will use these data for applied examples over the 10 days of the course. 
4. The remaining portion of class (approximately 1.5-2 hours) will be devoted to hands on learning with R, simulated data, and the large scale datasets provided by the instructor. 
5. The course schedule section, which is below, provides even more details about the topic of the lecture for each class day, citations for the discussion readings, and chapter entries from the text books for the programming and data analysis tools covered in the class.

## Folder Descriptions
- [R-Program-Lessons](./R-Program-Lessons): contains 10 folders with R programming lessons designed for each day of the course. More details about each lesson are contained in the schedule of classes descriptions below.
    - [Day01_Intro_programs](./R-Program-Lessons/Day01_Intro_programs)
    - [Day02_Data_Analysis_Managment](./R-Program-Lessons/Day02_Data_Analysis_Managment)
    - [Day03_Simulation_Learning](./R-Program-Lessons/Day03_Simulation_Learning)
    - [Day04_Simulation_Inference](./R-Program-Lessons/Day04_Simulation_Inference)
    - [Day05_Measurement_Intro](./R-Program-Lessons/Day05_Measurement_Intro)
    - [Day05_Measurement_RSTAN](./R-Program-Lessons/Day05_Measurement_RSTAN)
    
## Required Readings
There are no *required* books in this course. Rather, I will make reference to material listed below in rough proportion to the suggested books > additional suggested books. There are also a set of applied articles that I will make reference to as well. Think of these as useful references and places to find examples. The primary course content will be the R programing lessons.

## Suggested Books
1. Jones, Owen, Robert Maillardet, and Andrew Robinson. 2014. *Introduction to Scientific Programming and Simulation Using R.* Second Edition. CRC Press. https://nyu-cdsc.github.io/learningr/assets/simulation.pdf
2. Matloff, Norman. 2011. *Art of R Programming: A Tour of Statistical Software Design.* no starch press. https://nostarch.com/artofr.htm


## Additional Suggested Books
1. Bolker, Ben. 2007. *Ecological Models and Data in R* Princeton NJ: Princeton University Press. https://press.princeton.edu/books/hardcover/9780691125220/ecological-models-and-data-in-r
2. Davies, Tilman M. 2016. *The Book of R: A First Course in Programming and Statistics.* no starch press. https://nostarch.com/bookofr
3. Efron, Bradley and Trevor Hastie. 2016. *Computer Age Statistical Inference* Cambridge University Press. https://web.stanford.edu/~hastie/CASI/
4. Gelman,Andrew and Jennifer Hill. 2007. Data Analysis Using Regression and Multilevel/Hierarchical Models. Cambridge: Cambridge University Press. http://www.stat.columbia.edu/~gelman/arm/
5. Matloff, Norman. 2024. *The Art of Machine Learning: A Hands-On Guide to Machine Learning with R* no starch press. https://nostarch.com/art-machine-learning

## Suggested User Guides and Reference Manuals.
1. Stan Development Team. 2024. *Stan Modeling Language: User's Guide and Reference Manual. Version 2.35.* https://mc-stan.org/docs/stan-users-guide/index.html


# Class Schedule and Content links

## Day 1: Introduction to Learning and Inference making using Simulation and Programming
Introduction to the simulation and research design tools used to explore and understand various kinds of simulated and observed data (e.g., survey data, human rights data, social media data, text data, etc). We will also begin working with the program challenges, many of which are available here: https://github.com/CJFariss/R-Program-Challenges

- [R-Program-Lessons/Day01_Intro_programs](./R-Program-Lessons/Day01_Intro_programs): Introductory program lesson and program challenge.


## Day 2: Data Management and Analysis for Large Scale Data Structures
Introduction to the R programming environment. We will review the various data and programming structures that are available for use in R. We will pay particular attention to vectorization and parallelization. Though we will begin with very small programs for learning, we also need to remember that the massive scale datasets that are increasingly available need optimized programs designed to manage and analyze these massive scale data structures.

- [R-Program-Lessons/Day02_Data_Analysis_Managment](./R-Program-Lessons/Day02_Data_Analysis_Managment): More introductory programs.

### Day 2 Suggested Readings:
1. Matlofff 2011 (Ch.2: “Vectors”).
2. Matlofff 2011 (Ch.3: “Matrices and Arrays”).
3. Matlofff 2011 (Ch.4: “Lists”).
4. Matlofff 2011 (Ch.5: “Data Frames”).
5. Matlofff 2011 (Ch.6: “Factors and Tables”).
6. Matlofff 2011 (Ch.7: “R Programming Structures”).
7. Matlofff 2011 (Ch.14: “Performance Enhancement: Speed and Memory”).
8. Matlofff 2011 (Ch.16: “Parallel R”).


## Day 3: Simulation Based Programming and Inference
We will develop and implement simulations in R to accomplish two learning goals. For the first learning goal, we will develop simulations in R to help us practice all of the programming and data structures that are available in R. For the second learning goal,

- [Day03_Simulation_Learning](./R-Program-Lessons/Day03_Simulation_Learning)

## Day 4: Simulation Based Programming for Model Comparison and Selection
In this section, we will program and learn several simulation based validation tools for assessing a model of observational data in comparison to an appropriate baseline model.

- [R-Program-Lessons/Day04_Simulation_Inference](./R-Program-Lessons/Day04_Simulation_Inference)

## Day 5: Applied Simulation to Measure and Validate Latent Variable Models
Measurement, as a scientific process, should accomplish two related tasks. First, link a theoretical concept to a data generating procedure. Second, link the data generating procedure to observed information. In this section we continue our focus on text as data, which is almost always found and not generated explicitly by a researcher. This means that we need to consider both the concept and the data generating process as part of our research program. What does this mean?
 
Social scientists are often interested in explaining concepts that are difficult or impossible to observe. Examples of unobservable concepts include political knowledge, political ideology, democracy, respect for human rights, or inequality. Even concepts that are based on directly observable information such as the number of individuals that reside in a state, the number of individuals killed during a conflict, or the level of economic output are often not easily observed. A key challenge for political scientists and social scientists generally, is creating models that can measure these concepts while also capturing the uncertainty associated with the processes by which they are measured. 

This sections provide an introduction to measurement models generally with specific focus on Bayesian measurement models and measurement models that make use of text data. We will emphasize the use of construct validity to assess new and existing measures in applied research. We will motivate the development of these models with a discussion of the Bayesian perspective on the relationship between data and model parameters. This perspective is useful because it shifts the burden of validity from the primary source documentation and raw data to the model parameters that bind these diverse pieces of information together.

- [R-Program-Lessons/Day05_Measurement_Intro](./R-Program-Lessons/Day05_Measurement_Intro)
- [R-Program-Lessons/Day05_Measurement_RSTAN](./R-Program-Lessons/Day05_Measurement_RSTAN)



## Day 6 - Day 10
Under construction
