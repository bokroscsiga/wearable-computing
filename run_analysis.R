#downloading and unzipping raw data into the folder "data" within the working directory
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("./data")){dir.create("./data")}
download.file(url, "./rawData.zip")
unzip("./rawData.zip")

library(dplyr)

#reading in the names of the variables from "features.txt"
names <- scan("./UCI HAR Dataset/features.txt", what = character())
names <- names[seq(2, 1123, 2)] #we need to get rid of the numbers before the variablenames

#reading in training and test data; naming variables; keeping only measurments on the mean 
#and standard deviation for each measurement
trainData <- select(read.table("./UCI HAR Dataset/train/X_train.txt", col.names = names),
                    contains("mean"), contains("std"), -contains("meanFreq"),
                    -contains("Mean", ignore.case = FALSE))

testData <- select(read.table("./UCI HAR Dataset/test/X_test.txt", col.names = names),
                   contains("mean"), contains("std"), -contains("meanFreq"),
                   -contains("Mean", ignore.case = FALSE))

#merging training and test datasets
ttData <- rbind(trainData, testData)

#reading in subject and activity datasets for both training and test; merging datasets
subTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt" , col.names = "Subject")
subTest <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")
sub <- rbind(subTrain, subTest)

actTrain <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "Activity")
actTest <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "Activity")
act <- rbind(actTrain, actTest)

#using descriptive activity names to name the activities in the dataset
#reading in activity labels from text file; eliminating numbers before the labels
labels <- scan("./UCI HAR Dataset/activity_labels.txt",what=character())
labels <- labels[seq(2,12,2)]

act[act==1] <- labels[1]
act[act==2] <- labels[2]
act[act==3] <- labels[3]
act[act==4] <- labels[4]
act[act==5] <- labels[5]
act[act==6] <- labels[6]

#merging datasets
mData <- cbind(ttData, sub, act)

#creating a tidy dataset with the average of each variable for each activity and each subject
tidy <- aggregate(mData[ ,1:66], list(Subject=mData$Subject, Activity=mData$Activity),
                  data = mData, FUN = mean)

#reordering dataset
tidy <- tidy[order(tidy$Subject),]
rownames(tidy) <- NULL

write.table(tidy, "./data/tidy.txt", sep = ",", quote = FALSE)
T <- read.table("./data/tidy.txt", sep = ",")