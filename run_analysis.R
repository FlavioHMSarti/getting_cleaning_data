library(reshape2)
library(data.table)

link <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(link, "UCI_Dataset" )
unzip("UCI_Dataset")

repository <- getwd()
repository <- paste(repository, "/UCI HAR Dataset", sep = "")
setwd(repository)

repository_train <- paste(repository, "/train", sep = "")
repository_test <- paste(repository, "/test", sep = "")

files_train <- list.files(repository_train)
files_test <- list.files(repository_test)

setwd(repository_train)
data_train <- sapply(files_train, read.table, simplify = FALSE)
data_test <- sapply(files_test, read.table, simplify = FALSE)