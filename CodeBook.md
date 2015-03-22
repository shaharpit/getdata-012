# Getting and Cleaning Data - Class Project - CODE BOOK
Description: This document describes the variables, the data, and transformations that were performed to clean up the data.

## DATA

The features selected in this project come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

## TRANSFORMATIONS

1. The feature names were first read into R.
2. The raw training and test data was then read in to R, while applying the feature names from (1).
3. The training and test data sets were merged (column bound) with their respective subject and activity data points.
4. The training and test data sets were then merged (row bound) with each other.
5. The variables containing the words "mean" or "std" were extracted for further transformation. In this case, only variables with "mean" or "std" at the END of the variable name were chosen. Per the "features_info.txt" file provided, these variables corresponded to the mean and standard deviations estimated from the raw signals.
6. The Activity variable was converted to factors, and renamed to correspond to the activity mapping provided in "activity_labels.txt".
7. The numeric variables in the resulting data were averaged by Subject ID and Activity, such that an average was calculated for each variable corresponding to a particular Subject performing a particular Activity.
8. The resulting data set was exported as the final output tidy data set.

## VARIABLES

'X/Y/Z' is used to denote 3-axial signals in the X, Y and Z directions.

* SubjectID - ID of the subject
* Activity - Activity being performed by the subject

Variables starting with 't' refer to time domain signals. These are transformed with a Fast Fourier Transform, producing similar variables starting with an 'f'. Each of these variables has been averaged across all observations for a particular subject performing a particular activity.

### Time domain variables

* tBodyAcc.mean...X/Y/Z - Mean body acceleration signal
* tGravityAcc.mean...X/Y/Z - Mean gravity acceleration signal
* tBodyAccJerk.mean...X/Y/Z - Mean body acceleration jerk signal
* tBodyGyro.mean...X/Y/Z - Mean body gyroscope signal
* tBodyGyroJerk.mean...X/Y/Z - Mean body gyroscope jerk signal
* tBodyAccMag.mean.. - Mean magnitude of body acceleration signal
* tGravityAccMag.mean.. - Mean magnitude of gravity acceleration signal
* tBodyAccJerkMag.mean.. - Mean magnitude of body acceleration jerk signal
* tBodyGyroMag.mean.. - Mean magnitude of body gyroscope signal
* tBodyGyroJerkMag.mean.. - Mean magnitude of body gyroscope jerk signal
* tBodyAcc.std...X/Y/Z - Average standard deviation of body acceleration signal
* tGravityAcc.std...X/Y/Z - Average standard deviation of gravity acceleration signal
* tBodyAccJerk.std...X/Y/Z - Average standard deviation of body accleration jerk signal
* tBodyGyro.std...X/Y/Z - Average standard deviation of body gyroscope signal
* tBodyGyroJerk.std...X/Y/Z - Average standard deviation of body gyroscope jerk signal
* tBodyAccMag.std.. - Average standard deviation of magnitude of body acceleration signal
* tGravityAccMag.std.. - Average standard deviation of magnitude of gravity acceleration signal
* tBodyAccJerkMag.std.. - Average standard deviation of magnitude of body acceleration jerk signal
* tBodyGyroMag.std.. - Average standard deviation of magnitude of body gyroscope signal
* tBodyGyroJerkMag.std.. - Average standard deviation of magnitude of body gyroscope jerk signal


### FFT output variables
For a description of each variable, see the description of the time domain variables above.

* fBodyAcc.mean...X/Y/Z
* fBodyAccJerk.mean...X/Y/Z
* fBodyGyro.mean...X/Y/Z
* fBodyAccMag.mean..
* fBodyBodyAccJerkMag.mean..
* fBodyBodyGyroMag.mean..
* fBodyBodyGyroJerkMag.mean..
* fBodyAcc.std...X/Y/Z
* fBodyAccJerk.std...X/Y/Z
* fBodyGyro.std...X/Y/Z
* fBodyAccMag.std..
* fBodyBodyAccJerkMag.std..
* fBodyBodyGyroMag.std..
* fBodyBodyGyroJerkMag.std..