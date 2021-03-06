library(reshape2)
library(data.table)

## DOWNLOAD DATA AND UNZIP IT *************************************************
link <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(link, "UCI_Dataset" )
unzip("UCI_Dataset")

## READING FILES **************************************************************
# The work repository is the same repository where we find our data (inside)
# the unzipped file
repository <- getwd()
repository <- paste(repository, "/UCI HAR Dataset", sep = "")
setwd(repository)

# Train and Test data are in different repositories 
repository_train <- paste(repository, "/train", sep = "")
repository_test <- paste(repository, "/test", sep = "")

# Name of different accelerations (vector of length 562)
data_feature <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")

# Listing files of test and train repositories
files_train <- list.files(repository_train, pattern = "txt", full.names = TRUE)
files_test <- list.files(repository_test, pattern = "txt", full.names = TRUE)

# Reading files from those repositories
data_train <- sapply(files_train, read.table, simplify = FALSE)
data_test <- sapply(files_test, read.table, simplify = FALSE)

# ****************************** ITEM 1 ******************************
# Merging both data, train and test.
data_both <- mapply(rbind, data_train, data_test)
data_both <- do.call(cbind, data_both)

## RENAMING COLUMNS ***********************************************************
# the first and the last one represent the candidate
# and the activity. The 2nd - 562th containing the
# accelerations (data from feature.txt)

# 1 to 30
names(data_both)[1] <- "candidate" 

# 1 to 6
names(data_both)[length(data_both)] <- "activity"

# Using "feature.txt" file we can rename data_both with the
# acceleration names
setnames(data_both, c(2:(length(data_both)-1)),data_feature[[2]])

# Finding the position of mean/std accelerations in "feature.txt" file
mean_values_pos <- grep("mean|std", data_feature[[2]])+1

# ****************************** ITEM 2 ******************************
# Cut data_both in mean/std values
mean_values <- data_both[,c(1,mean_values_pos,length(data_both))]

# ****************************** ITEM 3 and 4 ************************
# Using descriptive activity names
# activity_labels -> 1st column: number id, 2nd column: name of activity
mean_values$activity <- activity_labels[,2][match(mean_values$activity, activity_labels[,1])]

# ****************************** ITEM 5 ******************************
tidy_data <- aggregate(mean_values[,2:80], by = list(mean_values$candidate, mean_values$activity), FUN = mean, na.rm = TRUE)
View(tidy_data)
names(tidy_data)[1:2] <- c("candidate", "activity")
write.table( tidy_data, "average_tidy_data.txt", row.names = FALSE )