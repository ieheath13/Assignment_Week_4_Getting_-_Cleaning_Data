#Create name vector for combined data frame
features_names <- read.table("/Users/ianheath/Desktop/UCI HAR Dataset/features.txt", sep =" ")
features_names <- features_names[,-1]

#import Training data & make combined training dataframe
training_activity <- read.table("/Users/ianheath/Desktop/UCI HAR Dataset/train/y_train.txt", sep = "", col.names = "activity")
training_measures <- read.table("/Users/ianheath/Desktop/UCI HAR Dataset/train/X_train.txt", sep = "", col.names =  features_names)
training_subject <- read.table("/Users/ianheath/Desktop/UCI HAR Dataset/train/subject_train.txt", sep = "", col.names = "subject")
training_df <- cbind(training_subject, training_activity, training_measures)


#import test data & make combined test data frame
test_activity <- read.table("/Users/ianheath/Desktop/UCI HAR Dataset/test/y_test.txt", sep = "", col.names = "activity")
test_measures <- read.table("/Users/ianheath/Desktop/UCI HAR Dataset/test/x_test.txt", sep = "", col.names =  features_names)
test_subject <- read.table("/Users/ianheath/Desktop/UCI HAR Dataset/test/subject_test.txt", sep = "", col.names = "subject")
test_df <- cbind(test_subject, test_activity, test_measures)

#created combined training & test dataframe containing only means and standard deviations
combined_run_data <- rbind(training_df, test_df)
mean_std_columns <- grep('(mean|std)', names(combined_run_data))
mean_std_columns <- gsub(" ", "", mean_std_columns)
mean_std_columns <- as.numeric(mean_std_columns)
combined_run_data <- combined_run_data[ ,mean_std_columns]

#create vector of activity names for recoding activity column
activity_labels <- read.table("/Users/ianheath/Desktop/UCI HAR Dataset/activity_labels.txt", sep = " ")
activity_labels <- activity_labels[,-1]
# set activity column to be a factor
combined_run_data$activity <- as.factor(combined_run_data$activity)
levels(combined_run_data$activity) <- activity_labels
