Getting-and-Cleaning-Data-Course-Project
========================================
GOAL:  

The data analysis project requires getting data, transform, and produced the a tidy data set that gives summary of an experiment.

ABOUT THE DATA:

a. Where to download data
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip?

b. Brief description of the experiment that generates the data: 
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.  The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window).

More detail description can be found in the file README.text after downloading and un-zip the dataset.
c. Data organization:

The data set is divided into test and train data folder.  In both test and train folder one will find the following files:

./subject_<test or train>.txt  -- contains the code of the subject
./y_<test or train>.txt ? contains the code of the activity when the data points are collected.    
./X_<test or train>.txt ? contains the data points.  


The code and descriptive name  for the activities in y_<test or train>.txt  are found in activity_labels.txt 

The descriptive name for the data points (or variables) are found in the file features.text

For the purpose of this project, data in the folder ?inertials signals? are not concerned.


PROCESS

Data analysis is implemented in R-progamming language; the file run_analysis.R.  
The output is written to the file name myLittleTidy.txt text file


Task 1:  read in subject, y, and X files in each test and train folders.  Concatenate the data in subject, y, X of the training folder to those data elements of test, respectively.    It is found that there are 563 data points (or measurements, or variables) for each observation.

Task 2:  Extract out the data points (or variables) that indicates the measurements of mean or standard deviation (std) 

Task 3 and 4: matching the code for activity to descriptive name, and label the merged dataset from step 1 with descriptive name

Task 5:  
For each unique subject (s_i)
       Collect all activities and their corresponding measurements
       For each unique set of activity (s_i_a_j)
                      For each variable (var_k)
                                  Calculate the mean of the variable measurement
                                  Add the mean data point to the subject (i), activity (j), variable (k)
                      End for
      End for
End for

Data set name myLittleTidy; it is written to a file by the name myLittleTidy.txt
