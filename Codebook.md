Code Book
================
Philip Muojekwu
9/9/2020


## Project Description

The goal of this project is to prepare a tidy data that can be used for
later analysis.

## Data Processing

The `run_analysis.R` script gets the data and processses it as described
in the course project instruction.

## Getting Raw Data

  - The data worked with in this project was gotten from the url:
    <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>
  - A `data` directory was created (if it didn’t already exist). The
    file was downlaoded and stored stored in the `Dataset.zip` file in
    the `data` folder.
  - This zip file is then unzipped.

## Cleaning Data

The unzipped file contains the `UCI HAR Dataset` folder. From this
folder, the .txt files containing the `features`, `activity_labels`,
`train`, and `test` datasets are read and assigned to variables.

### Object Variables

  - `features` \<- `features.txt` : 561 rows, 2 columns Dataset of all
    features
  - `activity_labels` \<- `activity_labels.txt` : 6 rows, 2 columns
    Dataset that links the class labels with their activity name
  - `subject_train` \<- `subject_train.txt` : 7352 rows, 1 columns Each
    row identifies the subject who performed the activity for each
    window sample. Its range is from 1 to 30
  - `X_train` \<- `X_train.txt` : 7352 rows, 561 columns Training set
  - `y_train` \<- `y_train.txt` : 7352 rows, 1 column Training labels
  - `subject_test` \<- `subject_test.txt` : 2947 rows, 1 column Each row
    identifies the subject who performed the activity for each window
    sample. Its range is from 1 to 30
  - `X_test` \<- `X_test.txt` : 2947 rows, 561 columns Test set
  - `y_test` \<- `y_test.txt` : 2947 rows, 1 column Test labels

### Merging the training and test sets to create one data set (using the **rbind()** and **cbind()** functions)

  - `subject` (10299 rows, 1 column) is created by merging
    `subject_train` and `subject_test`
  - `X` (10299 rows, 561 columns) is created by merging `X_train` and
    `X_test`
  - `activity` (10299 rows, 1 column) is created by merging `y_train`
    and `y_test`
  - `train_test` (10299 rows, 563 columns) is created by merging
    `subject`, `activity`, and `X`

### Extracting only the measurements on the mean and standard deviation for each measurement

  - Subset and replace `train_test` by selecting only the columns
    corresponding to the subject, activity, and measurements on the mean
    and standard deviation for each measurement. `train_test` now has
    10299 rows, 88 columns.

### Naming the activities in the data set with descriptive activity names

  - The activity column of `train_test` is coerced to a factor variable,
    and the levels are given descriptive activity names corresponding to
    the second column of `activity_labels`

### Labelling the dataset with appropriate descriptive variable names in `train_test`, (using the **gsub()** function)

  - all `BodyBody` is replaced by `Body`
  - all `tBody` is replaced by `TimeBody`
  - all `fBody` is replaced by `frequencyBody`
  - all `BodyBody` is replaced by `Body`
  - all `tGravity` is replaced by `TimeGravity`
  - all `BodyBody` is replaced by `Body`
  - all `Acc` is replaced by `Acceleration`
  - all `BodyBody` is replaced by `Body`
  - all `Mag` is replaced by `Magnitude`
  - all `Gyro` is replaced by `Gyroscope`
  - all `angle` is replaced by `Angle`
  - all `gravity` is replaced by `Gravity`
  - all `BodyBody` is replaced by `Body`
  - all `mean` is replaced by `Mean`
  - all `std` is replaced by `STD`
  - and all `.` are removed

### Creating an independent tidy dataset

  - A second tidy dataset, `tidy_data` (180 rows, 88 columns), with the
    average of each variable for each subject and activity, is created.
  - `tidy_data` is exported into `tidyData.txt` file
