# You should create one R script called run_analysis.R that does the following. 
# 1.Merges the training and the test sets to create one data set.
# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3.Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names. 
# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Set Working Directory
setwd("C:/Coursera/Data Scientists Toolbox/RProgramming/R_files")

## Merge Train and Test Data
# Read Training Data
train_data = read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
train_data[,562] = read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
train_data[,563] = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
# Read Test Data
test_data = read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
test_data[,562] = read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
test_data[,563] = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)
# Read Activity Labels
activityLabels = read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
# Read features and make the feature names better suited for R with some substitutions
feats = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
feats[,2] = gsub('-mean', 'Mean', feats[,2])
feats[,2] = gsub('-std', 'Std', feats[,2])
feats[,2] = gsub('[-()]', '', feats[,2])
# Merge training and test sets together
all_data = rbind(train_data, test_data)

## Get only the data on mean and standard deviation
relevantCols <- grep(".*Mean.*|.*Std.*", feats[,2])
# Clean the feats table with the requested columns only
feats <- feats[relevantCols,]
# Add the extra columns
relevantCols <- c(relevantCols, 562, 563)
# Remove the unwanted columns from all_Data
all_data <- all_data[,relevantCols]
# Add the column names (features) to allData
colnames(all_data) <- c(feats$V2, "Activity", "Subject")
colnames(all_data) <- tolower(colnames(all_data))

##Change names of the activities in the data set
currentActivity = 1
for (currentActivityLabel in activityLabels$V2) {
        all_data$activity <- gsub(currentActivity, currentActivityLabel, all_data$activity)
        currentActivity <- currentActivity + 1
}

all_data$activity <- as.factor(all_data$activity)
all_data$subject <- as.factor(all_data$subject)

## Crate Tidy data with Means
tidy_data = aggregate(all_data, by=list(activity = all_data$activity, subject=all_data$subject), mean)
# Remove the subject and activity column, since a mean of those has no use
tidy_data[,90] = NULL
tidy_data[,89] = NULL
# Write file
write.table(tidy_data, "tidy.txt", sep="\t", row.names = FALSE)
