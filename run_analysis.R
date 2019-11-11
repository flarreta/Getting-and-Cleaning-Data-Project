# Getting and Cleaning Data Project
# Peer-graded Assignment
# Francisco Larreta

# The purpose of this project is to work with, and clean a data set from data collected from the 
# accelerometers from the Samsung Galaxy S smartphone.

# Loading the needed packages

library(dplyr)

# Setting the filename

filename <- "Getting and Cleaning Data Final Project.zip"

# Checking if the file already exists
if (!file.exists(filename)){
  URL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(URL, filename, method="curl")
}  

# Checking if the folder exists
if (!file.exists("Final Project Dataset")) { 
  unzip(filename) 
}

# Reading and setting names to the files in folder

features <- read.table("Final Project Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("Final Project Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("Final Project Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("Final Project Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("Final Project Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("Final Project Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("Final Project Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("Final Project Dataset/train/y_train.txt", col.names = "code")

# Step 1: Merges the training and the test sets to create one data set.

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.

Tidy_Data <- Merged_Data %>% 
  select(subject, code, contains("mean"), contains("std"))

# Step 3: Uses descriptive activity names to name the activities in the data set.

Tidy_Data$code <- activities[Tidy_Data$code, 2]

# Step 4: Appropriately labels the data set with descriptive variable names.

names(Tidy_Data)[2] = "activity"
names(Tidy_Data) <- gsub("Acc", "Accelerometer", names(Tidy_Data))
names(Tidy_Data) <- gsub("Gyro", "Gyroscope", names(Tidy_Data))
names(Tidy_Data) <- gsub("BodyBody", "Body", names(Tidy_Data))
names(Tidy_Data) <- gsub("Mag", "Magnitude", names(Tidy_Data))
names(Tidy_Data) <- gsub("^t", "Time", names(Tidy_Data))
names(Tidy_Data) <- gsub("^f", "Frequency", names(Tidy_Data))
names(Tidy_Data) <- gsub("tBody", "TimeBody", names(Tidy_Data))
names(Tidy_Data) <- gsub("-mean()", "Mean", names(Tidy_Data), ignore.case = TRUE)
names(Tidy_Data) <- gsub("-std()", "STD", names(Tidy_Data), ignore.case = TRUE)
names(Tidy_Data) <- gsub("-freq()", "Frequency", names(Tidy_Data), ignore.case = TRUE)
names(Tidy_Data) <- gsub("angle", "Angle", names(Tidy_Data))
names(Tidy_Data) <- gsub("gravity", "Gravity", names(Tidy_Data))

# Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Final_Data <- Tidy_Data %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))

# Final step: data set as a text file

write.table(Final_Data, "Final_Data.txt", row.name=FALSE)

# Final Data

View(Final_Data)
