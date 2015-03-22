## INITIALIZE ENVIRONMENT. CHECK IF "dplyr" PACKAGE IS ALREADY INSTALLED. IF NOT, INSTALL IT.
if (!"dplyr" %in% installed.packages()) install.packages("dplyr")
library(dplyr)

## STEP 0: READ IN ALL DATA

## a) Read in feature names
features <- read.table("features.txt",stringsAsFactors=FALSE,col.names=c("Num","FeatureName"))

## b) Read in training data sets
##    - X_train.txt = Training data set (assigned to variable "train_data")
##    - y_train.txt = Training labels (assigned to variable "train_labels")
##    - subject_train.txt = Subject performing activity (assigned to variable "train_subj")

train_data <- read.table("train\\X_train.txt",stringsAsFactors=FALSE,col.names=features$FeatureName)
train_labels <- read.table("train\\y_train.txt",stringsAsFactors=FALSE,col.names=c("Activity"))
train_subj <- read.table("train\\subject_train.txt",stringsAsFactors=FALSE,col.names=c("SubjectID"))

## c) Read in test data sets
##    - X_test.txt = Test data set (assigned to variable "test_data")
##    - y_test.txt = Test labels (assigned to variable "test_labels")
##    - subject_test.txt = Subject performing activity (assigned to variable "test_subj")

test_data <- read.table("test\\X_test.txt",stringsAsFactors=FALSE,col.names=features$FeatureName)
test_labels <- read.table("test\\y_test.txt",stringsAsFactors=FALSE,col.names=c("Activity"))
test_subj <- read.table("test\\subject_test.txt",stringsAsFactors=FALSE,col.names=c("SubjectID"))

## STEP 1: MERGE TRAINING AND TEST DATA SETS TO CREATE ONE DATA SET

## a) Column bind training data sets with train_subj and train_labels to the left. Assign to "train_compl"
train_compl <- cbind(train_subj,train_labels,train_data)

## b) Column bind test data sets with test_subj and test_labels to the left. Assign to "test_compl"
test_compl <- cbind(test_subj,test_labels,test_data)

## c) Row bind training and test data. Assign to "data_compl"
data_compl <- rbind(train_compl,test_compl)

## STEP 2: EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT

## a) Use the grep function to subset columns with ".mean." or ".std." in their names.
##    - Pick only the data points in data_compl that have ".mean." or ".std." in their name (using grep function to subset columns)
##    - Organize such that SubjectID and Activity columns remain to the left, followed by the subsetted data_compl
##    - Assign bound data back to variable "data_compl"

data_compl <- cbind(SubjectID=data_compl[,"SubjectID"], 
                      Activity=data_compl[,"Activity"],
                      data_compl[,grep(".mean.",names(data_compl),fixed=TRUE)],
                      data_compl[,grep(".std.",names(data_compl),fixed=TRUE)])

## STEP 3: USE DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET

## a) Convert the Activity field in data_compl to factors

data_compl$Activity <- as.factor(data_compl$Activity)

## b) Rename factor levels of Activity field to descriptive activity names based on "activity_labels.txt" file provided

levels(data_compl$Activity)[levels(data_compl$Activity) == "1"] <- "WALKING"
levels(data_compl$Activity)[levels(data_compl$Activity) == "2"] <- "WALKING_UPSTAIRS"
levels(data_compl$Activity)[levels(data_compl$Activity) == "3"] <- "WALKING_DOWNSTAIRS"
levels(data_compl$Activity)[levels(data_compl$Activity) == "4"] <- "SITTING"
levels(data_compl$Activity)[levels(data_compl$Activity) == "5"] <- "STANDING"
levels(data_compl$Activity)[levels(data_compl$Activity) == "6"] <- "LAYING"

## STEP 4: LABEL THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES
##  This step was completed as part of the Read process in STEP 0

## STEP 5: CREATE INDEPENDENT TIDY DATA SET WITH AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT
## a) Group data frame "data_compl" by Subject ID and Activity to prepare for the summarize function of dplyr package. Assign value to "data_compl_grp".

data_compl_grp <- group_by(data_compl,SubjectID,Activity)

## b) Summarize each column in grouped data to obtain mean and tidy the data set. Assign to data frame "data_tidy".
data_tidy <- summarise_each(data_compl_grp,funs(mean))

## c) Use write.table to output tidy dataset from data_tidy to file
write.table(data_tidy,file="getdata-012-proj-tidydata.txt",row.names=FALSE)