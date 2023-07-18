#This is the code book for the project

##How to get to the tiny.txt:


About R script
File with R code "run_analysis.R" performs the 5 following steps (in accordance assigned task of course work):
  
  Reading in the files and merging the training and the test sets to create one data set.
1.1 Reading files

2. Extracting only the measurements on the mean and standard deviation for each measurement
3. Use descriptive activity names

4. Appropriately labels the data set with descriptive variable names. 
This is already done in the previous steps

5. Creating a second tidy data set with the avg of each variable for each activity and subject

About variables:
  x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
x_data, y_data and subject_data merge the previous datasets to further analysis.
