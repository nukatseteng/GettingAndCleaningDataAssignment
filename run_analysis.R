library(dplyr)

# Check if dataset exist
if (!file.exists('projectdataset.zip')) {
  # Download dataset
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url = url, destfile = 'projectdataset.zip')
  
  unzip(zipfile = 'projectdataset.zip')
}

# Load features and activity labels
features <- read.table('./UCI HAR Dataset/features.txt', col.names = c('index', 'featurenames'))
activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt', col.names = c('id', 'name'))

# Load train datasets
x_train <- read.table('./UCI HAR Dataset/train/X_train.txt')
y_train <- read.table('./UCI HAR Dataset/train/y_train.txt', col.names = c('activity'))
subject_train <- read.table('./UCI HAR Dataset/train/subject_train.txt', col.names = c('subjectid'))
colnames(x_train) <- features$featurenames
train <- cbind(subject_train, y_train, x_train)

# Load test datasets
x_test <- read.table('./UCI HAR Dataset/test/X_test.txt')
y_test <- read.table('./UCI HAR Dataset/test/y_test.txt', col.names = c('activity'))
subject_test <- read.table('./UCI HAR Dataset/test/subject_test.txt', col.names = c('subjectid'))
colnames(x_test) <- features$featurenames
test <- cbind(subject_test, y_test, x_test)

# Merge datasets
alldata <- rbind(train, test)

# Extracts only the measurements on the mean and standard deviation for each measurement
featuresMeasured <- grep("(subjectid|activity|((mean|std)\\(\\)))", colnames(alldata))
filtered <- alldata[, featuresMeasured]

filtered['activity'] <- factor(filtered$activity, levels = activity_labels$id, labels = activity_labels$name)

# Create independent tidy data,
# Calculate average for each subject and each activity,
# Order data
tidydata <- aggregate(. ~ subjectid + activity, filtered, mean) %>% arrange(subjectid, activity)

write.table(tidydata, "tidy_data.txt", row.names = FALSE)

