run_analysis <- function() {
  # This project is based on the Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and 
  # Jorge L. Reyes-Ortiz publication 
  # "Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine".
  # International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
  
  
  # Download data, unpack, list files:
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    destfile <- "UCI HAR Dataset.zip"
    ext <- ".zip"
    
    if (!file.exists(destfile)){
      download.file(fileURL, destfile) # for MAC  method="curl"
      unzip(destfile)
    }
    path_raw <- file.path(gsub(ext,"",destfile))
    files<-list.files(path_raw, recursive=TRUE)
    files
    
  # Load packages
    if (!require("data.table")) {
      install.packages("data.table")
      library(data.table)
    }
    if (!require("reshape2")) {
      install.packages("reshape2")
      library(reshape2)
    }
    if (!require("plyr")) {
      install.packages("plyr")
      library(plyr)
    }
    if (!require("knitr")) {
      install.packages("knitr")
      library(knitr)
    }  
    if (!require("tidyr")) {
      install.packages("tidyr")
      library(tidyr)
    }
  
    # Load test set and training
    
    x_test = read.table("UCI HAR Dataset/test/X_test.txt")
    x_train = read.table("UCI HAR Dataset/train/X_train.txt")
    
    y_test = read.table("UCI HAR Dataset/test/Y_test.txt")
    y_train = read.table("UCI HAR Dataset/train/Y_train.txt")

    # Merge test and training,
    
    X <- rbind(x_test, x_train)
    Y <- rbind(y_test, y_train)
  
    # Load column features and subset only -mean() and -std()
    
    features <- read.table("UCI HAR Dataset/features.txt")
    features_mean_std <- features[grep("-mean\\(\\)|-std\\(\\)", features[,2]),]
    
    # Clean
    
    features_tidy <- gsub("\\()","",features_mean_std[,2])
    features_tidy[1:66]
    # Subset X observations to mean and std related and label columns
    
    X_subset <- X[,features_mean_std[,1]]
    colnames(X_subset) <- features_tidy
    
    # Load activities and rename labels
    
    activities <- read.table("UCI HAR Dataset/activity_labels.txt", 
                             col.names = c("activityId","activity"))
    Y[,1] <- activities[Y[, 1], 2]
    colnames(Y) <- "activity"
    # Subjects and add label
    
    subject_test = read.table("UCI HAR Dataset/test/subject_test.txt")
    subject_train = read.table("UCI HAR Dataset/train/subject_train.txt")
    subject <- rbind(subject_test, subject_train)
    colnames(subject) <- ("subjectId") 

    # Merge Subjects, Activities, Observations
    
    DT <- cbind(subject, Y, X_subset)
    
    # Apply Reshape to DT to average over by subject and activity
    
    Tidy_DT_long <- melt(DT, id.vars = c("subjectId", "activity"), na.rm = TRUE)
    Tidy_DT <- dcast(Tidy_DT_long, subjectId + activity ~ variable, mean)
    
    # Save copy of Tidy DT
    filename  <- paste0("HAR ", gsub("[:lower:]","-", toString(Sys.time())), ".txt")
    write.table(Tidy_DT, file = filename, row.names = FALSE, sep = ",")
} 
    