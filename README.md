# Getting-and-Cleaning-Data-Course-Project
Part of Getting and Cleaning Data Course Project
The goal is to prepare tidy data that can be used for later analysis.

A full description fo the original project is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Tasks to be performed:

Create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names. 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## Repeat the work done

1. Download and unzip data from the link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

2. Set your working directory to : \...\UCI HAR Dataset

3. Run the function 'run_analysis.R'

## How the function works

#### Step 1
Reads all files at once

#### Step 2        
Calculates the features to be included in the final result

#### Step 3
Process xtest data by removing all the columns that are not to be inclued, and introduces the subject and activities columns.

#### Step 4
Process xtrain data by removing all the columns that are not to be inclued, and introduces the subject and activities columns.
        
#### Step 5
Merge/union of xtest and xtrain data

#### Step6
Calculates the aggregates and write the table that cover the step 5 of the peer assessment and finally return the caculated data.
