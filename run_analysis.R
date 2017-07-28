library(plyr)
#*******************************************************************************
# 1.Merges the training and the test sets to create one data set.
# test_sets
x_test<-read.table("test/X_test.txt")
y_test<-read.table("test/y_test.txt")
subject_test<-read.table("test/subject_test.txt")
#train_sets
x_train<-read.table("train/X_train.txt")
y_train<-read.table("train/y_train.txt")
subject_train<-read.ftable("train/subject_train.txt")
#X data set
x_data<-rbind(x_train,x_test)
# Y data set
y_data<-rbind(y_train,y_test)
# subject data set
subject_data<-rbind(subject_train,subject_test)
#********************************************************************************
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("features.txt")
mean_&std<-grep("-(mean|std)\\(\\)",features,2)
x_data <- x_data[, mean_&std]
names(x_data)<-features[mean_&std,2]
#*********************************************************************************
# Uses descriptive activity names to name the activities in the data set
activities <- read.table("activity_labels.txt")
y_data[, 1] <- activities[y_data[, 1], 2]
names(y_data) <- "activity"
#**********************************************************************************
# Appropriately labels the data set with descriptive variable names.
  names(subject_data) <- "subject"
all_data <- cbind(x_data, y_data, subject_data)
#*************************************************************************************
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(averages_data, "averages_data.txt", row.name=FALSE)