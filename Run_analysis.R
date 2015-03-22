path <- file.path("~/Documents/A NEW BEGINING/STUDY/COURSERA/GettingandCleaningData", "UCI HAR Dataset")
files <- list.files(path, recursive = T)
files

ActivityTest  <- read.table(file.path(path, "test" , "Y_test.txt" ),header = F)
ActivityTrain <- read.table(file.path(path, "train", "Y_train.txt"),header = F)

SubjectTrain <- read.table(file.path(path, "train", "subject_train.txt"), header = F)
SubjectTest  <- read.table(file.path(path, "test" , "subject_test.txt"),header = F)

FeaturesTest  <- read.table(file.path(path, "test" , "X_test.txt" ),header = F)
FeaturesTrain <- read.table(file.path(path, "train", "X_train.txt"),header = F)

str(ActivityTest)
str(ActivityTrain)
str(SubjectTrain)
str(SubjectTest)
str(FeaturesTest)
str(FeaturesTrain)

Subject<- rbind(SubjectTrain, SubjectTest)
Activity<- rbind(ActivityTrain, ActivityTest)
Features<- rbind(FeaturesTrain, FeaturesTest)

names(Subject)<- c("subject")
names(Activity) <- c("activity")
FeaturesNames <- read.table(file.path(path, "features.txt"), header = F)
names(Features)<- FeaturesNames$V2

Combine <- cbind(Subject, Activity)
Data <- cbind(Features, Combine)

subdataFeaturesNames<- FeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)]

selectedNames<- c(as.character(subdataFeaturesNames, "subject", "activity"))
Data<-subset(Data,select=selectedNames)

str(Data)

activityLabels <- read.table(file.path(path, "activity_labels.txt"), header = F)

names(Data)<- gsub("^t", "time", names(Data))
names(Data)<- gsub("^f", "frequency", names(Data))
names(Data)<- gsub("Acc", "Accelerometer", names(Data))
names(Data)<- gsub("Gyro", "Gyroscope", names(Data))
names(Data)<- gsub("Mag", "Magnitude", names(Data))
names(Data)<- gsub("BodyBody", "Body", names(Data))
names(Data)

Data2 <- write.table(Data, row.name= F)


