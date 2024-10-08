## R_Demo_text_as_data_package_description.R
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
## text adapted from these references:
## https://hub.packtpub.com/9-useful-r-packages-for-nlp-text-mining/
## https://analyticsindiamag.com/top-10-r-packages-for-natural-language-processing-nlp/
##
## koRpus
## koRpus is an R package for analysing texts. 
## It includes a diverse collection of functions for automatic language detection. 
## It also includes indices of lexical diversity, such as type token ratio, MTLD, etc. 
## koRpus’ also provides a plugin for R GUI as well as IDE RKWard that assists in providing graphical dialogs for its basic features. 
##
## lsa
## Latent Semantic Analysis or lsa is an R package that provides routines for performing a latent semantic analysis with R. 
## The basic idea of this package is that text do have a higher-order or latent semantic structure which is obscured by word usage e.g. through the use of synonyms or polysemy.
#3
## OpenNLP
## OpenNLP provides an R interface to Apache OpenNLP, which is a collection of natural language processing tools written in Java. 
## OpenNLP supports common natural language processing tasks such as tokenisation, sentence segmentation, part-of-speech tagging, named entity extraction, chunking, parsing and coreference resolution.
##
## Quanteda
## Quanteda is an R package for managing and analysing text. 
## It is a fast, flexible, and comprehensive framework for quantitative text analysis in R. 
## Quanteda provides functionality for corpus management, creating and manipulating tokens and ngrams, exploring keywords in context, forming and manipulating sparse matrices of documents by features and more.
##
## RWeka
## RWeka is an interface to Weka, which is a collection of machine learning algorithms for data mining tasks written in Java. 
## It contains tools for data pre-processing, clustering, association rules, visualisation and more. 
## This package contains an interface code, known as the Weka jar that resides in a separate package called ‘RWekajars’.
##
## Spacyr
## Spacyr is an R wrapper to the Python spaCy NLP library. 
## The package is designed to provide easy access to the functionality of spaCy library in a simple format. 
## One of the easiest methods to install spaCy and spacyr is through the spacyr function spacy_install(). 
##
## Stringr
## Stringr is a consistent, simple and easy to use R package that provides consistent wrappers for the string package and therefore simplifies the manipulation of character strings in R. 
## It includes a set of internally consistent tools for working with character strings, i.e. sequences of characters surrounded by quotation marks.  
##
## Text2vec 
## Text2vec is an R package which provides an efficient framework with a concise API for text analysis and natural language processing (NLP). 
## Some of its important features include allowing users to easily solve complex tasks, maximise efficiency per single thread, transparently scale to multiple threads on multicore machines, use streams and iterators, among others.
##
## TM
## TM or Text Mining Package is a framework for text mining applications within R. 
## The package provides a set of predefined sources, such as DirSource, 
## DataframeSource, etc. which handle a directory, a vector interpreting each component as a document, or data frame like structures (such as CSV files), and more.
##
## Wordcloud
## Wordcloud is an R package that creates pretty word clouds, visualises differences and similarity between documents, and avoids overplotting in scatter plots with text. 
## The word cloud is a commonly used plot to visualise a speech or set of documents in a clear way.
##
## STM
## STM is an R package that efficiently estimates the Latent Diriclet Allocation model (LDA) and the related Structural Topic model (STM).
##
## maxent
## maxent is an R package with tools for low-memory multinomial logistic regression, also known as maximum entropy. The focus of this maximum entropy classifier is to minimize memory consumption on very large datasets, particularly sparse document-term matrices represented by the tm package. The classifier is based on an efficient C++ implementation written by Dr. Yoshimasa Tsuruoka.
##
## RKEA
## RKEA: An R interface to KEA (Version 5.0). KEA (for Keyphrase Extraction Algorithm) allows for extracting keyphrases from text documents. It can be either used for free indexing or for indexing with a controlled vocabulary.
##
## languageR
## languageR: Data sets exemplifying statistical methods, and some facilitatory utility functions used in ``Analyzing Linguistic Data: A practical introduction to statistics using R'', Cambridge University Press, 2008.
##
## RcmdrPlugin.temis
## RcmdrPlugin.temis: An 'R Commander' plug-in providing an integrated solution to perform a series of text mining tasks such as importing and cleaning a corpus, and analyses like terms and documents counts, vocabulary tables, terms co-occurrences and documents similarity measures, time series analysis, correspondence analysis and hierarchical clustering. Corpora can be imported from spreadsheet-like files, directories of raw text files, 'Twitter' queries, as well as from 'Dow Jones Factiva', 'LexisNexis', 'Europresse' and 'Alceste' files.
##
##########################################################################


