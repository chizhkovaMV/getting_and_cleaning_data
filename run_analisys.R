# 1/24/2015 Coursera/Data Science/Getting and Cleaning Data/Course Project
# Script for processing Human Activity Recognition Using Smartphones Dataset
# Script will attempt to load data from "UCI HAR Dataset/" folder. If your dataset is in diferent path, 
# you can use argument <data_path> and specify path to dataset.
########################################################################################
## TASK.You should create one R script called run_analysis.R that does the following. 
##1.Merges the training and the test sets to create one data set.
##2.Extracts only the measurements on the mean and standard deviation for each measurement. 
##3.Uses descriptive activity names to name the activities in the data set
##4.Appropriately labels the data set with descriptive variable names. 
##5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
########################################################################################
##Reading data

##Connecting up required libraries 
library(dplyr)

##Forming variables contained names and directories of data files
url_features<-"./UCI HAR Dataset/features.txt"
url_activity_labels<-"./UCI HAR Dataset/activity_labels.txt"
url_X_test<-"./UCI HAR Dataset/test/X_test.txt"
url_y_test<-"./UCI HAR Dataset/test/y_test.txt"
url_subject_test<-"./UCI HAR Dataset/test/subject_test.txt"
url_X_train<-"./UCI HAR Dataset/train/X_train.txt"
url_y_train<-"./UCI HAR Dataset/train/y_train.txt"
url_subject_train<-"./UCI HAR Dataset/train/subject_train.txt"

##Reading tables from X_test and Y_test files
Xtest<-read.table(url_X_test,stringsAsFactors=F)
Xtrain<-read.table(url_X_train,stringsAsFactors=F)

##Reading feature names - variable names for 561 columns
features<-read.table(url_features,stringsAsFactors=F)

##Reading subjects(volunteers ID) for train and test parts as vectors "numeric"
subjectTest<-scan(url_subject_test,what="numeric")
subjectTrain<-scan(url_subject_train,what="numeric")

##Reading ytest и ytrain datasets as vectors "numeric"
ytest<-scan(url_y_test,what="numeric")
ytrain<-scan(url_y_train,what="numeric")

##Adding new columns - volunteer ID and activities for each parts (test &train)

datasetTest<-mutate(Xtest,volunteerId=subjectTest,activity=ytest)
datasetTrain<-mutate(Xtrain,volunteerId=subjectTrain,activity=ytrain)
#################################################################################
##Point 1. Merging data frames into 1

dataset<-rbind(datasetTest,datasetTrain)

##Point 2. Looking for variables from features which contained mean() и std() and leave them in data set

features<-features[(grepl("-std()",features[,2],fixed=TRUE)|grepl("-mean()",features[,2],fixed=TRUE)),1:2]
tidydata<-cbind(dataset[c("volunteerId","activity")],dataset[,features[,1]])

##Point 3-4. Cleaning variable names from wasted simbols and appropriately label the data set 

newfeatures<-data.frame()
newfeatures[1,1]<-"volunteerId"
newfeatures[2,1]<-"activity"

for (i in 3:(length(features[,2])+2))
newfeatures[i,1]<-features[i-2,2]

for (i in 1:length(newfeatures[,1])) { 
	newfeatures[i,1]<-gsub("-","",newfeatures[i,1])
	newfeatures[i,1]<-gsub("mean()","Mean",newfeatures[i,1],fixed=TRUE)
	newfeatures[i,1]<-gsub("std()","Std",newfeatures[i,1],fixed=TRUE)
	newfeatures[i,1]<-gsub("X","Xacis",newfeatures[i,1],fixed=TRUE)
	newfeatures[i,1]<-gsub("Y","Yacis",newfeatures[i,1],fixed=TRUE)
	newfeatures[i,1]<-gsub("Z","Zacis",newfeatures[i,1],fixed=TRUE)
	newfeatures[i,1]<-gsub("Acc","Accelerometer",newfeatures[i,1],fixed=TRUE)
	newfeatures[i,1]<-gsub("Gyro","Gyroscope",newfeatures[i,1],fixed=TRUE)
			}

##Giving new column names for data set
names(tidydata)<-newfeatures[,1]

##Identifieng activity names 

tidydata[tidydata$activity==1,2]="WALKING"
tidydata[tidydata$activity==2,2]="WALKING_UPSTAIRS"
tidydata[tidydata$activity==3,2]="WALKING_DOWNSTAIRS"
tidydata[tidydata$activity==4,2]="SITTING"
tidydata[tidydata$activity==5,2]="STANDING"
tidydata[tidydata$activity==6,2]="LAYING"

##Applying mean function to dataset, forming tidy data and writing it into output file

X_final_tidied<-aggregate(x=tidydata[,3:68], by = tidydata[,1:2], FUN = "mean")

write.table(X_final_tidied,row.names = FALSE, "Output.txt")
##Extremely appologise for my english in advance.
