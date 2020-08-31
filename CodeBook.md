# UCI HAR Dataset

* The original files can be founded on: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

* There we find the files:
  - activity_labels.txt
  - features.txt
  - subject_test.txt
  - X_test.txt
  - y_test.txt
  - subject_train.txt
  - X_train.txt
  - y_train.txt
  
* "activity_labels" contains 6 differents activities (1 WALKING to 6 LAYING) performed by the candidates. The left number is also used by "y_test/train" file;

* In "features" we find the line names of "X_test/train" and "y_test/train" files. Each line corresponds to a different acceleration measured by the phone;

# Data manipulation

* The "run_analysis.R" code starts reading all variables described above. The acceleration names are saved in "data_feature" variable (a 561x2 data frame) and all activities names in "activity_lables" (a 6x2 data frame, where in the first columns there are the number labels and in the second one, the name). 

* By using sapply, "X_test/train", "y_test/train" and "subject_train" are read and written in "data_test" and "data_train" variables. With mapply and do.call, we can assembly those datas (in "data_both" variable), where X_test/train file represents the entire table, y_test/train the candidate column and subject_train, the activity column.

* Using "data_feature" we renamed some columns of data_both variable.

* Finally we cut "data_both" in a new variable, "mean_values", containing only variables with "mean/std" in their name using "grep" function.

* The tidy data is obtained by averaging each columns in groups of candidates. The "aggregate" function can easily do that.



