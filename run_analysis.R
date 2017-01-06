## Steps performed by run_analysis.R
## Merge train and test data set
## Retained only those measurements that that had mean and standard deviation
## measurements
## Appended activity label (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING,
## STANDING and LAYING) and subject (integer 1 to 30) to the merged data set. This
## created the first tidy data set
## The second tidy data set was obtained by averaging the mean and stand deviation
## variable measurements for each subject and activity label name

## read column names
features <- read.table("UCI HAR Dataset/features.txt",
                                colClasses = c("integer", "character"))
features <- as.vector(features[, 2])

## read train data set
train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features,
                    colClasses = c(rep("numeric", 561)))

## read train subject
train$subject <- read.table("UCI HAR Dataset/train/subject_train.txt")[, 1]

## read train activity labels
train$activity.label.id <- read.table("UCI HAR Dataset/train/y_train.txt")[, 1]

## read test data set
test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features,
                    colClasses = c(rep("numeric", 561)))

## read train subject
test$subject <- read.table("UCI HAR Dataset/test/subject_test.txt")[, 1]

## read train activity labels
test$activity.label.id <- read.table("UCI HAR Dataset/test/y_test.txt")[, 1]

## MERGE Data - row bind train and test data set
mergedData <- rbind(train, test)

## include only columns for mean and standard deviation
mergedMeanStdData <- mergedData[, grepl("mean|std", names(mergedData))]

## read activity_labels.txt
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt",
                             colClasses = c("integer", "character"))

## add activity label name corresponding to activity label id
mergedMeanStdData$activity.label.name <- sapply(mergedData$activity.label.id,
        function(argu) activityLabels[grep(argu, activityLabels[, 1]), 2])

## add subject
mergedMeanStdData$subject <- mergedData$subject

## sort the data set by subject and activity label name, and create the first
## tidy data set
library(dplyr)
mergedMeanStdData <- arrange(mergedMeanStdData, subject, activity.label.name)
write.csv(mergedMeanStdData, "./tidy_dataset_1.csv")

## create the second tidy data set
library(reshape2)
meltData <- melt(mergedMeanStdData, id=c("subject", "activity.label.name"))
dcastMean <- dcast(meltData, formula = subject + activity.label.name ~ variable,
                   mean, na.rm = TRUE)
write.csv(dcastMean, "./tidy_dataset_2_summarymean.csv")
