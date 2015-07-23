
#To download the file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")
#unzip the file
unzip(zipfile="./data/Dataset.zip",exdir="./data")
#list of files in the folder
path_rf <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)
#files
#Read files in the variables
dataActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)
#reead suject files
dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)
#read feature files
dataFeaturesTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)
#merging trainig and data sets
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)
#naming the column
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2
#merging columns to get all data in one dataframe
dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)
#gettign the mean and std deviation
subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)

#Getting the activity labels from the activity  text file
for(i in 1:nrow(Data)){
  if(Data$activity[i]==as.integer(1)){
  Data$activity[i]<- "WALKING"
  }
  else if(Data$activity[i]==as.integer(2)){
    Data$activity[i]<- "WALKING_UPSTAIRS"
  }
  else if(Data$activity[i]==as.integer(3)){
    Data$activity[i]<- "WALKING_DOWNSTAIRS"
  }
  else if(Data$activity[i]==as.integer(4)){
    Data$activity[i]<- "SITTING"
  }
  else if(Data$activity[i]==as.integer(5)){
    Data$activity[i]<- "STANDING"
  }
  else if(Data$activity[i]==as.integer(6)){
    Data$activity[i]<- "LAYING"
  }
}
# making headers discriptive
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
# to get the tidy data set
library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)

# to make the code book
library(knitr)
knit2html("codebook.Rmd");
