---
title: "README.md"
author: "rod termaat"
date: "September 19, 2014"
output: html_document
---

==================================================================

Getting and Cleaning Data: A study using Human Activity Recognition Using Smartphones Dataset
Version 1.0

==================================================================

Author:  Rod TerMaat



Original Study Authors:
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit‡ degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

This project is to access, assemble, format, and tidy the original study data described in detail below.


The data must first be downloaded at the following url:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 

The data is downloaded, unzipped, and stored locally.  This can be done manually, or using the included run_analysis.R script.  
The data must be stored on the working directory in a direcotry called data. Additionally the data directory structure of the original download must be perserved. 


The following instructions were given for the assignment:

You should create one R script called run_analysis.R that does the following. 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 



Initial assessment

- The Script named run_analysis.R contains all of the code needed to download, unzip, store, and analyze the data contained in the URL above.
- The data and subsequent working directories will be stored in the working directory of your R environment.
- The data is downloaded to a directory called data as fuci_dataset.zip
- The unzip process will create several subdirectories used in the process

UCI HAR Dataset

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels. Links the activity performed to the test set. Its range is from 1 to 6
- 'train/subject_train': Links the subject to the observation. Its range is from 1 to 30.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.Links the activity performed to the test set. Its range is from 1 to 6
- 'test/subject_test': Links the subject to the observation. Its range is from 1 to 30.

The following additional files are available for the train and test data. Their descriptions are equivalent. These files are not used in the class project.
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

==================================================================

Script description:  run_analysis.R

==================================================================

Step 0:
install the dplyr package used in step 8 of script

Step 1(optional):
commented out
used to download, unzip, and store the data in the working directory

Step 2:
Read the column names from features.txt for use in steps 3 and 4
These are the column names for the x_train.txt and x_test.txt data
This data is initially cleaned in the step and contributes to Step 7 later in the script

Step 3:
Assemble the train data
3a. Read the train data (x_train.txt) and add the column headers from features.txt
3b. add the subject (subject_train.txt) and the activities (y_train.txt) to the data set

Step 4:
Assemble the test data
3a. Read the test data (x_test.txt) and add the column headers from features.txt
3b. add the subject (subject_test.txt) and the activities (y_test.txt) to the data set

Step 5:
Combine the test and train data from steps 3 and 4.  
This satisfies assignment objective 1

Step 6: 
subset the data in step file to only include those values containing mean and standard deviation (std) measurements
This satisfies assignment objective 2

Note:
The subset only includes the variables with segments containing subject, activity, mean, std, and Mean
  It excludes the meanFreg values per the discussion thread on the course project
	https://class.coursera.org/getdata-007/forum/thread?thread_id=188
This is done for consistency since the mean is calculated on various measurements and the meanFreq is a derived field.
Step 7:
7a. coverts the activity number to a more descriptive text value
1 WALKING, 2 WALKING_UPSTAIRS, 3 WALKING_DOWNSTAIRS, 4 SITTING, 5 STANDING, 6 LAYING
7b. add the word Ave_ to the beginning of each field to make the measure values more descriptive
This satisfies assignment objective 3 and 4

Step 8: 
Group the data by activity and subject
Calculate the mean of each measure value
Write a file to provide as the output and testing of the script for the class
found in the data directory of the working directory: final_extract.txt
This satisfies assignment objective 5


==================================================================

Below are notes on the original study and included for reference and they provide some context to the class project described above

==================================================================
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:

======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

Notes:

======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:

========

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

