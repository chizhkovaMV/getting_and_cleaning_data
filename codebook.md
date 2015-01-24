Data
The data consist of the set of files described in the /UCI HAR Dataset/README.txt, UCI HAR Dataset/features.txt, and other accompanying files to the UCI HAR Dataset.
It was transformed as described below to become a set that gives the mean and std of the variable measurements for each study participant performing each activity.

Variables
volunteerId: An identifying number from 1 to 30 that signifies on which subject the measurements were taken
Activity: the activity, taken from the list in /UCI HAR Dataset/activity_labels.txt 

measurement:

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for each pattern:
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

where:

mean(): Mean value
std(): Standard deviation

Transformations
This is a description of exactly what process the script performs to the change the data to achieve the desired result:
1. Read the test and train data into R
2. Bind the test and train data together into one large, raw, all-inclusive data frame, add columns with volunteerId and activity
3. Extract the feature measurement names from the /UCI HAR Dataset/features.txt file,
5. Subset the large, messy dataframe to remove only the columns containing the mean or standard deviation of measurements, saving this information in a new data frame
6. Form a data frame,contained newfeatures - subsetted cleaned names from wasted simbols, append the names "volunteerID" and "activity"
6. Create a data frame containing the names of the activities performed, with indices matching their order, given by the /UCI HAR Dataset/activity_labels.txt file
7. Replace the numbers in the Activity column of the most recently created data frame
8. Aggregate the means of the measurement variables with relation to each volunteer ID on each activity
9. Create a text file in the working directory called "Output.txt" and write the final-tidied data to that file

The tidied data can be read using a simple read.table() call in R without any special parameters.
