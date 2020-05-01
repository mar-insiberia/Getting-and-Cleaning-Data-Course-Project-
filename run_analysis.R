library(tidyverse)
library(data.table)
library(reshape2)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "UCI_HAR.zip")
path <- getwd()
unzip(zipfile = "UCI_HAR.zip")
list.files()

# Read labels files 
labels <- fread(file.path(path,"activity_labels.txt"),
                col.names = c("ID", "Activities"))

features <- fread(file.path(path, "features.txt"), 
                  col.names = c("ID", "Measurements"))

# Subset label (select mean() and std() only)
data_features <- grep("(mean()|std())", features[, Measurements])
data_measurements <- features[data_features, Measurements]

# Read and subset train and test dataset
Train <- fread(file.path(path, "X_train.txt"))
sub_train <- Train [, data_features, with = FALSE]

Test <- fread(file.path(path, "X_test.txt"))
sub_test <- Test [, data_features, with = FALSE]

# Add labels to columns 
a <- setnames(sub_train, colnames(sub_train), data_measurements)
b <- setnames(sub_test, colnames(sub_test), data_measurements)

# Read train and test activities and subjects files
Activities_train <- fread(file.path(path, "y_train.txt"),
                          col.names = c("Activity"))
Subjects_train <- fread(file.path(path, "subject_train.txt"),
                        col.names = c("Subject"))

Activities_test <- fread(file.path(path, "y_test.txt"),
                         col.names = c("Activity"))
Subjects_test <- fread(file.path(path, "subject_test.txt"),
                       col.names = c("Subject"))

# Merge labels and data
train_bind <- cbind(Activities_train, Subjects_train, sub_train)
test_bind <- cbind(Activities_test, Subjects_test, sub_test)

# Merge train and test data
data_merged <- rbind(train_bind, test_bind)

# Group and average the mean
Data_merged <- data_merged %>%
        group_by(Subject, Activity) %>%
        summarise_all(funs(mean))

write.csv(Data_merged, "tidy_data.csv")
