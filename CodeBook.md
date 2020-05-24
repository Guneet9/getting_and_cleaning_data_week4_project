#This is the code book for the course getting and cleaning data peer graded assignment

## Source data and libraries required
The libraries used are dplyr and data.table, while the source data are from the Human Activity Recognition Using Smartphones Data Set. 
Source data - https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Description of the source data - http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## About the R code
File with R code "run_analysis.R" performs the following steps in accordance to the assignment 
1. Downloading the files and unzipping them.
2. Reading datasets. This can be further classified into reading feature files, activity files, subject files, feature names and activity labels. 
3. Assigning variable names
4. Merging all data sets in one set
5. Extracting only the measurements on the mean and standard deviation for each measurement
6. Using descriptive activity names
7. Creating a second, independent tidy data set with the avg of each variable for each activity and subject. This can be further classified into making a second tidy dataset and writing the second tidy dataset into a txt file.
The code assumes all the data is present in the same folder, un-compressed and without names altered.

## About variables
1. features_train, activity_train, features_test, activity_test, subject_train and subject_test contain the data from the downloaded files.
2. x_data, y_data and subject_data merge the previous datasets to further analysis.
3. features contains the correct names for the x_data dataset, which are applied to the column names stored in
