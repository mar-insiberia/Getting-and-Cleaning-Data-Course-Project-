Code Book 

Getting and Cleaning Data Course Project

This repo explains how all of the scripts work and how they are connected.
Therefore, here it is discussed how the data was downloaded, cleaned and organized as a tidy dataset.
Dataset use in this project can be found here:
        https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Download  data
1. Download the UCI HAR zip file,
2. path <- getwd()
3. unzip(zipfile = "UCI_HAR.zip")

Reading files 
1. Read “activity_labels.txt” to labels 
2. Read "features.txt" column names to feature 
3. Read X_train data "X_train.txt" to Train
4. Read X_test data "X_test.txt" to Test
5. Read y_train data "y_train.txt" to Activities_train
6. Read subject_train data "subject_train.txt" to Subjects_train
7. Read y_test data "y_test.txt" to Activities_test
8. Read subject_test data "subject_test.txt" to Subjects_test

Tidying the data
Selecting mean() and std() from columns names 
1. select mean and std from features to data_features
2. subset data and renamed column to data_measurements 

Subset train and test data 
1. subset  Train to sub_train 
2. subset  Test to sub_test 

Merge labels and data
1. Merge Activities_train, Subject_train and sub_train data to train_bind 
2. Merge Activities_test, Subject_test and sub_test data to test_bind 
3. Merge the total train and test data to data_merged 
4. Group and average the mean to Data_merged 

Write data to "tidy_data.csv"
