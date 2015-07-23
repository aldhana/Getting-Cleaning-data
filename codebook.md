Download the file from the link provided
The file is unzipped and stored in the specified folder
THe following 6 files that are required for the project are read in the variables

test/subject_test.txt
test/X_test.txt
test/y_test.txt
train/subject_train.txt
train/X_train.txt
train/y_train.txt

Activity, Subject and Features  are the descriptive variable names for data (variables 
created are, dataActivityTest, dataActivityTrain, dataSubjectTrain, dataSubjectTest and dataFeaturesTest, dataFeaturesTrain 

THe training and the test data sets are merged  creating one data set. 
The data tables are concatenate  by rows

Names are set to the variables and colums merged to get one dataframe  called data

Mean and standared deviation for the measurements are extracted by subsetting 

THe descriptive activity names are added to the dataframe by reading the information from the activity labels text file. 
The descriptions are here below:

t is replaced by time
Acc is replaced by Accelerometer
Gyro is replaced by Gyroscope
f is replaced by frequency
Mag is replaced by Magnitude
BodyBody is replaced by Body

The tidy data set is created
