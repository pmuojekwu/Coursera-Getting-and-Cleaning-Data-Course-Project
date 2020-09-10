if(!file.exists("data")){
  dir.create("data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/Dataset.zip", method = "curl")
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")

library(data.table)
library(dplyr)

list.files("./data")
list.files("./data/UCI HAR Dataset")

features <- read.table("./data/UCI HAR Dataset/features.txt")

activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")


list.files("./data/UCI HAR Dataset/train")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", 
                            col.names = "subject")
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", 
                      col.names = features$V2)
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", 
                      col.names = "activity")


list.files("./data/UCI HAR Dataset/test")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", 
                           col.names = "subject")
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", 
                     col.names = features$V2)
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", 
                     col.names = "activity")


subject <- rbind(subject_train, subject_test)
X <- rbind(x_train, x_test)  
activity <- rbind(y_train, y_test)

train_test <-  as_tibble(cbind(subject, activity, X))
train_test <- train_test %>%
  select(subject, activity, contains("mean"), contains("std"))

train_test$activity <- as.factor(train_test$activity)
levels(train_test$activity) <- activity_labels$V2
levels(train_test$activity)

names(train_test) <- gsub("BodyBody", "Body", names(train_test))
names(train_test) <- gsub("tBody", "TimeBody", names(train_test))
names(train_test) <- gsub("fBody", "FrequencyBody", names(train_test))
names(train_test) <- gsub("tGravity", "TimeGravity", names(train_test))
names(train_test) <- gsub("Acc", "Acceleration", names(train_test))
names(train_test) <- gsub("Mag", "Magnitude", names(train_test))
names(train_test) <- gsub("Gyro", "Gyroscope", names(train_test))
names(train_test) <- gsub("angle", "Angle", names(train_test))
names(train_test) <- gsub("gravity", "Gravity", names(train_test))
names(train_test) <- gsub("mean", "Mean", names(train_test))
names(train_test) <- gsub("std", "STD", names(train_test))
names(train_test) <- gsub("\\.", "", names(train_test))
names(train_test)

train_test

tidy_data <- train_test %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
tidy_data

write.table(tidy_data, "tidyData.txt", row.names = FALSE)


