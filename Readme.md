## Readme for project - getting and cleaning data

### Steps to run run_analysis.R are
* Download data from link
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Extract the zip file. The root folder will be UCI HAR Dataset
* Ensure that dplyr and reshape2 packages are installed
* Run run_analysis.R from folder UCI HAR Dataset
* It will generate following two dataset and one output file:
1. tidy dataset1: data set containing mean and standard deviation measurement of
   variables along with subject and activity label name
2. tidy_dataset_2_summarymean.txt: data set containing mean of all variables for each
   subject and activity label name


### Steps performed by run_analysis.R
* Merge train and test data set
* Retained only those measurements that that had mean and standard deviation
  measurements
* Appended activity label (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING,
  STANDING and LAYING) and subject (integer 1 to 30) to the merged data set. This
  created the first tidy data set
* The second tidy data set was obtained by averaging the mean and stand deviation
  variable measurements for each subject and activity label name
