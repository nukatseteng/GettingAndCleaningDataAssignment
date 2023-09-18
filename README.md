# Getting and Cleaning Data - Project Assessment

This is a repository for Project Assessment of Getting and Cleaning Data

Data description: [link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
Data Zip File: [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Files
1. run_analysis.R, data cleaning script
2. CodeBook.md, description to files data, variables, and transformations
3. tidy_data.txt, result/output from script 


## R Script
- The script first check if data existed. If data unavaible, we should download it first.
- Load data from train and test data set
- Load features and activities data
- Merge training and test data set into one data set
- Select or extract only the measurements on the mean and standard deviation
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names
- Result from previous step then group by subject and activity, then we calculate the average for each measurement
- Write the data set into tidy_data.txt