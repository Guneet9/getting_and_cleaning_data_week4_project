library(plyr)
library(data.table)

# Download the UCI datafiles and unzip them

if(!file.exists("./getcleandata")){dir.create("./getcleandata")}
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "./getcleandata/projectdataset.zip")
unzip(zipfile = "./getcleandata/projectdataset.zip", exdir = "./getcleandata")

# Reading datasets

      ## Reading features files 
      
        features_train <- read.table("./getcleandata/UCI HAR Dataset/train/X_train.txt")
        features_test <- read.table("./getcleandata/UCI HAR Dataset/test/X_test.txt")
      

      ## Reading activities files
        activity_train <- read.table("./getcleandata/UCI HAR Dataset/train/y_train.txt")
        activity_test <- read.table("./getcleandata/UCI HAR Dataset/test/y_test.txt")

       
      ## Reading subject files
        subject_train <- read.table("./getcleandata/UCI HAR Dataset/train/subject_train.txt")
        subject_test <- read.table("./getcleandata/UCI HAR Dataset/test/subject_test.txt")

       
      ## Reading feature names
        featuresnames <- read.table("./getcleandata/UCI HAR Dataset/features.txt")
        
      ## Reading activity labels
        activityLabels = read.table("./getcleandata/UCI HAR Dataset/activity_labels.txt")
        
# Assigning variable names
        
        colnames(features_train) <- featuresnames[,2]
        colnames(features_test) <- featuresnames[,2]

        
        colnames(activity_train) <- "activityID"
        colnames(activity_test) <- "activityID"

        
        colnames(subject_train) <- "subjectID"
        colnames(subject_test) <- "subjectID"
        
        
        colnames(activityLabels) <- c("activityID", "activityType")
   
# Merging all datasets into one set

        alltrain <- cbind(activity_train, subject_train, features_train)
        alltest <- cbind(activity_test, subject_test, features_test)
        datasetf <- rbind(alltrain, alltest)
        
# Extracting only the measurements on the mean and sd for each measurement
      
      ## Reading column names
        colNames <- colnames(datasetf)
        
      ## Create vector for defining ID, mean, and sd
        mean_and_std <- (grepl("activityID", colNames) |
                         grepl("subjectID", colNames) |
                         grepl("mean..", colNames) |
                         grepl("std...", colNames)
        )
        
      ## Making nessesary subset
        setforMeanandStd <- datasetf[ , mean_and_std == TRUE]
        
# Use descriptive activity names
        
        setWithActivityNames <- merge(setforMeanandStd, activityLabels, by = "activityID", all.x = TRUE)
        
# Labelled the data set with descriptive variable names in the above steps
                
# Creating a second,  independent tidy data set with the avg of each variable for each activity and subject
        
      ## Making a second tidy data set
        
        tidySet <- aggregate(. ~subjectID + activityID, setWithActivityNames, mean)
        tidySet <- tidySet[order(tidySet$subjectID, tidySet$activityID), ]
        
     ## Writing second tidy data set into a txt file

        write.table(tidySet, "tidySet.txt", row.names = FALSE)

