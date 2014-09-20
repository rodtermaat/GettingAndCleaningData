## Getting Data Class Project

## Step 0 install the needed packages
install.packages("dplyr", dependencies=TRUE)
library(dplyr)

## Step 1 Download, unzip, and create directories for storage.
## assumes the data has been downloaded to the working directory where the R scrip is running
## assumes the zipped data has been unzipped into a directory called data in the working directory
## assumes that within the directory data the file structure contined w/in the zipped file is persisted

##------------------------------------------
##If any of STEP 1 is not true you can uncomment and fun the following code as part of the 
##entire R script
##------------------------------------------
##if(!file.exists("./data")){ dir.create("./data")}
##url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
##download.file(url, dest="./data/fuci_dataset.zip", method="curl")
##unzip("./data/fuci_dataset.zip",exdir = "./data" )
##------------------------------------------
##
## Step 2 Read the column names and clean up the variable names for later processing
names <- read.delim("./data/UCI HAR Dataset/features.txt", sep=" ", header=F)
names2 <- names[-1]  ##remove the first column
names3 <- as.character(unlist(names2))  ## convert the list to a character vector for use below
## work on cleaning up the variable names to make then more descriptive
names4 <- gsub("-", "_", names3)
names5 <- gsub("\\()", "", names4)
names6 <- gsub("\\,", "_", names5)
names7 <- gsub("\\(", "_", names6)
names8 <- gsub("\\)", "", names7)


## Step 3 Assemble the train data
## 3a. read in the train data and add the colunm headers
train_dat <- read.table("./data/UCI HAR Dataset/train/x_train.txt", 
                        colClasses = "double", 
                        col.names = names8)

## 3b. read in the subjects and activties for the train data and append it
activity <- read.table("./data/UCI HAR Dataset/train/y_train.txt", col.names="activity")
subjects <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", col.names="subject")
train_master <- cbind(subjects, activity, train_dat)


## Step 4 Assemble the test data
## 4a. read in the test data and add the colunm headers
test_dat <- read.table("./data/UCI HAR Dataset/test/x_test.txt", 
                       colClasses = "double", 
                       col.names = names8)

## 4b. read in the subjects and activties for the test data and append it
activity <- read.table("./data/UCI HAR Dataset/test/y_test.txt", col.names="activity")
subjects <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", col.names="subject")
test_master <- cbind(subjects, activity, test_dat)

## Step 5 combine the train and test data into 1 data set
train_test_master <- rbind(test_master, train_master)

## Step 6 use grepl to subset the data  with only mean and std variables
train_test_small <- train_test_master[,grepl("subject|activity|mean|std|Mean", colnames(train_test_master))]
train_test_final <- train_test_small[,!grepl("meanFreq", colnames(train_test_small))]

## Step 7 make the headers more descriptive
## 7a. change activity
## 1 WALKING, 2 WALKING_UPSTAIRS, 3 WALKING_DOWNSTAIRS, 4 SITTING, 5 STANDING, 6 LAYING
train_test_final$activity[train_test_final$activity==1] <- "walking"
train_test_final$activity[train_test_final$activity==2] <- "walking_upstairs"
train_test_final$activity[train_test_final$activity==3] <- "walking_downstairs"
train_test_final$activity[train_test_final$activity==4] <- "sitting"
train_test_final$activity[train_test_final$activity==5] <- "standing"
train_test_final$activity[train_test_final$activity==6] <- "laying"

## 7b. update the column header to add "Avg_ to indicate the average of each measure
colnames(train_test_final) <- paste("Avg", colnames(train_test_final), sep="_")
colnames(train_test_final)[1] <- "subject"
colnames(train_test_final)[2] <- "activity"

## Step 8  Create the output dataset  
## 8a. group by activity and subject
train_test_summary <- group_by(train_test_final, activity, subject)
## 8b. calculate the mean of each variable
final_final <- summarise_each(train_test_summary, funs(mean))
## 7c. write the output to disk
write.table(final_final, "./data/final_extract.txt", row.name=FALSE)





