---
title: "Human Activity Recognition Using Smartphones Dataset Code Book"
output: github_document
author: "Vincent Roy"
date: "July 18, 2016"
output: html_document
---
           

Introduction:

  Human Activity Recognition Using Smartphones Dataset (Version 1.0) from
  Samsung Galaxy S smartphones while subjects performed various activities
  (listed activities below). For the particulars of the measurements
  recorded and their derivation, refer to the documentation of the dataset
  location in features_info.txt)

  This package contains two datasets. The first is a merge of both the testing 
  and training measurements datasets then filtered to include only the variables
  related to mean and standard deviation measurements including both the 
  frquency and time measurements.The second is the raw file dataset.The 
  following variables are loaded from the dataset
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  

    X_train
    X_test
    features


subject [ "subjectID" "subject"]
subjectID [1:30]

 
activities [ "activityId" "activity"]
activityID [1:6]
activity ["WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"]


features_mean_std(extracted from larger population of 561 features based on mean, std only)

tBodyAcc-mean-X
tBodyAcc-mean-Y
tBodyAcc-mean-Z
tBodyAcc-std-X
tBodyAcc-std-Y
tBodyAcc-std-Z
tGravityAcc-mean-X
tGravityAcc-mean-Y
tGravityAcc-mean-Z
tGravityAcc-std-X
tGravityAcc-std-Y
tGravityAcc-std-Z
tBodyAccJerk-mean-X
tBodyAccJerk-mean-Y
tBodyAccJerk-mean-Z
tBodyAccJerk-std-X
tBodyAccJerk-std-Y
tBodyAccJerk-std-Z
tBodyGyro-mean-X
tBodyGyro-mean-Y
tBodyGyro-mean-Z
tBodyGyro-std-X
tBodyGyro-std-Y
tBodyGyro-std-Z
tBodyGyroJerk-mean-X
tBodyGyroJerk-mean-Y
tBodyGyroJerk-mean-Z
tBodyGyroJerk-std-X
tBodyGyroJerk-std-Y
tBodyGyroJerk-std-Z
tBodyAccMag-mean
tBodyAccMag-std
tGravityAccMag-mean
tGravityAccMag-std
tBodyAccJerkMag-mean
tBodyAccJerkMag-std
tBodyGyroMag-mean
tBodyGyroMag-std
tBodyGyroJerkMag-mean
tBodyGyroJerkMag-std
fBodyAcc-mean-X
fBodyAcc-mean-Y
fBodyAcc-mean-Z
fBodyAcc-std-X
fBodyAcc-std-Y
fBodyAcc-std-Z
fBodyAccJerk-mean-X
fBodyAccJerk-mean-Y
fBodyAccJerk-mean-Z
fBodyAccJerk-std-X
fBodyAccJerk-std-Y
fBodyAccJerk-std-Z
fBodyGyro-mean-X
fBodyGyro-mean-Y
fBodyGyro-mean-Z
fBodyGyro-std-X
fBodyGyro-std-Y
fBodyGyro-std-Z
fBodyAccMag-mean
fBodyAccMag-std
fBodyBodyAccJerkMag-mean
fBodyBodyAccJerkMag-std
fBodyBodyGyroMag-mean
fBodyBodyGyroMag-std
fBodyBodyGyroJerkMag-mean:
fBodyBodyGyroJerkMag-std


features_mean_std  (extracted feature original position)
 1   2   3   4   5   6  41  42  43  44  45  46  81  82  83  84  85  86 121 122 123
125 126 161 162 163 164 165 166 201 202 214 215 227 228 240 241 253 254 266 267
268 269 270 271 345 346 347 348 349 350 424 425 426 427 428 429 503 504 516 517 529
530 542 543

Methods:
  Functionality of run_analysis.R: 1. Merge the training and the test sets to 
  create one data set of entire observation of the subjects activities observation
  uning rbind (dplyr package 2. Extracts only the measurements on the mean and 
  standard deviation for each measurement by u. 3. Uses descriptive activity names
  to name the activities in the data set 4. Appropriately labels the data set with
  descriptive activity names. 5  Creates a second, independent tidy data set with 
  the average of each variable for each activity and each subject.

Prototype of run_analysis.R
# Download data, unpack, list files "UCI HAR Dataset.zip unzip(destfile) and list files recursively
    
# Install & Load packages
      library(data.table)
      library(reshape2)
      library(plyr)
      library(knitr)
      library(tidyr)
  
# Read UCI HAR Dataset text files (X are features obs. and y are activity obs.): 
    x_test 
    x_train 
    y_test 
    y_train 

# Merge test and training using rbind
    X <- rbind(x_test, x_train)
    Y <- rbind(y_test, y_train)
  
# Load column features and subset only -mean() and -std() 
    features from features.txt
    features_mean_std using grep
    
# Clean
    features_tidy <- gsub("\\()","",features_mean_std[,2])
    features_tidy[1:66]

# Subset X observations to mean and std related and label columns
    X_subset
    rename using features_tidy

# Load activities and rename labels based on activityID
    activities from activity_labels.txt", 
    rename "activityId","activity"))
    Y[,1] <- activities[Y[, 1], 2]
    rename column "activity"
    
# Subjects and add label
    subject_test from ./test/subject_test.txt")
    subject_train from ./train/subject_train.txt")
    rbind(subject_test, subject_train)
    rename column "subjectId"

# Merge Subjects, Activities (Y), Observations (X_subset)
    DT using cbind(subject, Y, X_subset)
    
# Reshape (reshape2 package) to DT (long form) and average by subject and activity
    Tidy_DT_long using melt on DT by keys "subjectId", "activity" 
    Tidy_DT (wide form and mean on subjectId + activity using dcast on Tidy_DT_long

# Save copy of Tidy 
    create filename HAR<System datetime>.txt
    write.table Tidy_DT to file comma delimited.