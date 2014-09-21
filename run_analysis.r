## Assumption
## Work directory is
## ./<your directory/UCI HAR Dataset  (where work directory is set)
## -----> test
## -----> train
## -----> merge

## =================================================================
## Test dataset, reading in: y_test.txt, Y_test.txt, subject_test.txt
## =================================================================
## Set up file path
testy_path <- file.path(getwd(), "test", "y_test.txt" )
testX_path <- file.path(getwd(), "test", "X_test.txt" )
testS_path <- file.path(getwd(), "test", "subject_test.txt")
## read in data
## X_test.txt contains numeric data in scientific notation
## Note: must use fill = TRUE to fill missing column data
colsFormat <- c('numeric')
testy <- read.table(testy_path, header=FALSE)
testX <- read.table(testX_path, fill=TRUE, colClasses=colsFormat)
testS <- read.table (testS_path, header=FALSE)

## convert data into data frame
dfTesty <- data.frame(testy)
dfTestX <- data.frame(testX)
dfTestS <- data.frame(testS)

## =================================================================
## TRAIN dataset, reading in: y_train.txt, X_train.txt, subject_train.txt
##       perform the above steps for train data set
## =================================================================
## Set up file path
trainy_path <- file.path(getwd(), "train", "y_train.txt" )
trainX_path <- file.path(getwd(), "train", "X_train.txt" )
trainS_path <- file.path(getwd(), "train", "subject_train.txt")
## read in data
## X_test.txt contains numeric data in scientific notation
## Note: must use fill = TRUE to fill missing column data
colsFormat <- c('numeric')
trainy <- read.table(trainy_path, header=FALSE)
trainX <- read.table(trainX_path, fill=TRUE, colClasses=colsFormat)
trainS <- read.table (trainS_path, header=FALSE)
## convert data into data frame
dfTrainy <- data.frame(trainy)
dfTrainX <- data.frame(trainX)
dfTrainS <- data.frame(trainS)
## ===============================================
## Task 1:  Merge the Train and Test datasets
## ===============================================
dfMerge <- rbind(dfTrainX, dfTestX)
dfMergeActivity <- rbind(dfTrainy,dfTesty )
dfMergeSubject <- rbind(dfTrainS,dfTestS )

## ==============================================
## Reading in features.txt and activity_label.txt
## ==============================================
act_path <- file.path(getwd(), "activity_labels.txt")
fea_path <- file.path(getwd(), "features.txt")
dfActivity <- data.frame(read.table(act_path))
dfFeature  <- data.frame(read.table(fea_path))
## ==============================================
## Task 2: Extract the variables (columns) 
##       relating to mean and standard deviation
## grepl is used to achieve this task
## -- set up the pattern that are sought after 
##     "mean" "standard deviation", which happens
##     to be "std"
## ==============================================
look4Mean <- "mean"
look4Std  <- "std"
dfMeanFeature <- subset (dfFeature, grepl (look4Mean, dfFeature[,2]))
dfStdFeature  <- subset (dfFeature, grepl (look4Std,  dfFeature[,2]))

dfMean <- dfMerge[, dfMeanFeature[,1]]
dfStd <- dfMerge[, dfStdFeature[,1]]

## ==============================================
## Task 3: name activity with descriptive name
##    Match the code in dfActivity$V1 to the merge activity code
##    If found then add the label
## ==============================================
dfMergeActivity$Activity.Label <- dfActivity$V2[match(dfMergeActivity$V1, dfActivity$V1)]
names(dfMergeActivity) <- c("Activity.Code", "Activity.Label")
activity <- data.frame(dfMergeActivity$Activity.Label)
names(activity) <- c ("Activity.Label")
## ================================================
## Task 4: labeling the merge data set with descriptive name
## ================================================
featureName <- dfFeature[,2]
names(dfMerge) <- featureName
names(dfMergeSubject) <- c ("Subject")
dfMerge <- cbind(dfMergeSubject, activity, dfMerge)

## ================================================
## Task 5:  For each subject
##              For each variables
##                  Calculate average of each variables
##              end for
##          End for
## Report tidy data set
## Use library("dplyr")
## ================================================

myLittleTidy <- ddply(dfMerge, .(Subject, Activity.Label), numcolwise(mean))

write.table(myLittleTidy,"myLittleTidy", row.names=FALSE)
