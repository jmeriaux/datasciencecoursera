---
title: "README.Rmd"
author: "JC Meriaux"
date: "May 24, 2015"
output: html_document
---

#README.Rmd

This repository contains run_analysis.R, which is a script for extracting and cleaning up data - and generating a tidy data set.
See below for details on how to run the script and load data into R. 
Variable and transformations performed on the raw data are included in CookBook.md.

##Requirements

* R version 3.2
* The following library: data.table, devtools, plyr

##How to run the script

* Download run_analysis.R from github.
* Download the (dataset)[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ] 
* Extract data to the same directory as run_analysis.
* Open an R console or R Studio with a working directory set ot the locaiton where files are downloaded
* Run "run_analysis.R"
* Data is loaded in Mean_set
* Data is in file "Mean_set.txt" in the same working directory

