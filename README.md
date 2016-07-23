---
title: "Getting and Cleaning Data Course Project
"Human Activity Recognition Using Smartphones""
output: github_document
---

Purpose:
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project.

Objective:
1. A tidy data set as described below
2. A link to a Github repository with your script for performing the analysis, and
3. A code book that describes the variables, the data, 
4. Any transformations or work that you performed to clean up the data called CodeBook.md. 5. You should also include a README.md in the repo with your scripts. This file explains how all of the scripts work and how they are connected.

Background and Dataset:
One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Dataset: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Functionality of run_analysis.R:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5  Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Repo:
CodeBook.md: information about raw and tidy data set and variable manipulation 
README.md: this file
run_analysis.R: R script to transform raw data set in a tidy one

How to recreate the tidy data set:
1. Clone this repository: git clone git@github.com:vincentroy/getting-cleaning-data-project.git
2. Download compressed raw data
3. Unzip raw data and copy the directory UCI HAR Dataset to the cloned repository root directory
4. Open a R console and set the working directory to the repository root (use setwd())
5. Source script (it requires the shape2 package): source('run_analysis.R')

In the repository working root directory you find the Tidy file: 
HAR < current date time > .txt (Note: which is a CSV file so rename the extension to .csv if you are read it into R with read.csv)
