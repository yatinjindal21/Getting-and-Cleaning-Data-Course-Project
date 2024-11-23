# Load necessary library
library(dplyr)

# Download and unzip the dataset if not already done
zip_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zip_file <- "UCI_HAR_Dataset.zip"
data_dir <- "UCI HAR Dataset"

if (!file.exists(zip_file)) {
  download.file(zip_url, zip_file, mode = "wb")
}
if (!dir.exists(data_dir)) {
  unzip(zip_file)
}

# Step 1: Merging the training and test sets
# Load training data
train_subject <- read.table(file.path(data_dir, "train", "subject_train.txt"))
train_x <- read.table(file.path(data_dir, "train", "X_train.txt"))
train_y <- read.table(file.path(data_dir, "train", "y_train.txt"))

# Load test data
test_subject <- read.table(file.path(data_dir, "test", "subject_test.txt"))
test_x <- read.table(file.path(data_dir, "test", "X_test.txt"))
test_y <- read.table(file.path(data_dir, "test", "y_test.txt"))

# Combine the datasets
subject <- rbind(train_subject, test_subject)
x_data <- rbind(train_x, test_x)
y_data <- rbind(train_y, test_y)

# Assign column names to subject and activity data
colnames(subject) <- "Subject"
colnames(y_data) <- "Activity"

# Load feature names and assign them to the data
features <- read.table(file.path(data_dir, "features.txt"))
colnames(x_data) <- features$V2

# Merge all data into one dataset
merged_data <- cbind(subject, y_data, x_data)

# Step 2: Extract only the mean and standard deviation measurements
mean_std_features <- grep("-(mean|std)\\(\\)", features$V2)
selected_columns <- c(1, 2, mean_std_features + 2) # Including Subject and Activity
tidy_data <- merged_data[, selected_columns]

# Step 3: Use descriptive activity names
activity_labels <- read.table(file.path(data_dir, "activity_labels.txt"))
colnames(activity_labels) <- c("Activity", "ActivityName")
tidy_data <- merge(tidy_data, activity_labels, by = "Activity")
tidy_data$Activity <- tidy_data$ActivityName
tidy_data <- tidy_data[, -ncol(tidy_data)]

# Step 4: Appropriately label the dataset with descriptive variable names
colnames(tidy_data) <- gsub("^t", "Time", colnames(tidy_data))
colnames(tidy_data) <- gsub("^f", "Frequency", colnames(tidy_data))
colnames(tidy_data) <- gsub("Acc", "Accelerometer", colnames(tidy_data))
colnames(tidy_data) <- gsub("Gyro", "Gyroscope", colnames(tidy_data))
colnames(tidy_data) <- gsub("Mag", "Magnitude", colnames(tidy_data))
colnames(tidy_data) <- gsub("BodyBody", "Body", colnames(tidy_data))

# Step 5: Create a second, independent tidy dataset with the average of each variable for each activity and subject
final_data <- tidy_data %>%
  group_by(Subject, Activity) %>%
  summarise(across(everything(), mean))

# Write the final tidy dataset to a text file
write.table(final_data, "tidy_dataset.txt", row.name = FALSE)

