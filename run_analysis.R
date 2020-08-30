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

data_feature <- read.table("features.txt")

files_train <- list.files(repository_train, pattern = "txt", full.names = TRUE)
files_test <- list.files(repository_test, pattern = "txt", full.names = TRUE)


data_train <- sapply(files_train, read.table, simplify = FALSE)
data_test <- sapply(files_test, read.table, simplify = FALSE)

data_both <- mapply(rbind, data_train, data_test)
data_both <- do.call(cbind, data_both)

names(data_both)[1] <- "candidate"
names(data_both)[length(data_both)] <- "activity"

setnames(data_both, c(2:(length(data_both)-1)),data_feature[[2]])

mean_values_pos <- grep("mean|std", data_feature[[2]])+1
mean_values <- data_both[,c(1,mean_values_pos,length(data_both))]

