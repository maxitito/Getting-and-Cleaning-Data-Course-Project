
# Download the dataset
if(!file.exists("./getcleandata")){dir.create("./getcleandata")}
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "./getcleandata/projectdataset.zip")

# Unzip the dataset
unzip(zipfile = "./getcleandata/projectdataset.zip", exdir = "./getcleandata")


## Merge the files

#Reading files



# Reading files

#  Reading training set
x_train <- read.table("./getcleandata/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./getcleandata/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./getcleandata/UCI HAR Dataset/train/subject_train.txt")

# Reading test sets
x_test <- read.table("./getcleandata/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./getcleandata/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./getcleandata/UCI HAR Dataset/test/subject_test.txt")

#  Reading feature vector
features <- read.table("./getcleandata/UCI HAR Dataset/features.txt")

# 
activityLabels = read.table("./getcleandata/UCI HAR Dataset/activity_labels.txt")

# Assigning variable names
#For training 
colnames(x_train) <- features[,2]
colnames(y_train) <- "activityID"
colnames(subject_train) <- "subjectID"

#For testing
colnames(x_test) <- features[,2]
colnames(y_test) <- "activityID"
colnames(subject_test) <- "subjectID"

colnames(activityLabels) <- c("activityID", "activityType")

# Merging  into one set
train_total <- cbind(y_train, subject_train, x_train)
test_total <- cbind(y_test, subject_test, x_test)
total  <- rbind(train_total, test_total)

# 2. Extracting only the measurements on the mean and sd for each measurement

# 
colNames <- colnames(total)

#  Create vector for defining ID, mean, and std deviation 
mean_and_std <- (grepl("activityID", colNames) |
                   grepl("subjectID", colNames) |
                  
                   grepl("mean..", colNames) |
                   grepl("std...", colNames)
)

# 2 Making subset
setforMeanStd <- total[ , mean_and_std == TRUE]

# 3. Use descriptive activity names
setWithActivityNames <- merge(setforMeanStd, activityLabels,
                              by = "activityID",
                              all.x = TRUE)

# 4. Appropriately labels the data set with descriptive variable names. 
# This is already done in the previous steps

# 5. Creating a second tidy data set with the avg of each variable for each activity and subject

# 
tidyData <- aggregate(. ~subjectID + activityID, setWithActivityNames, mean)
tidyData <- tidyData[order(tidyData$subjectID, tidyData$activityID), ]
write.table(tidyData, "tidy.txt", row.names = FALSE)
