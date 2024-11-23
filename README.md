# Getting-and-Cleaning-Data-Course-Project

# UCI HAR Dataset Analysis

This repository contains the script and related documentation for analyzing the UCI HAR Dataset.

## Files

- **run_analysis.R**: The script to perform the data analysis.
- **CodeBook.md**: Describes the variables and transformations in the tidy dataset.
- **tidy_dataset.txt**: The output of the analysis, created by `run_analysis.R`.

## Instructions

1. Download the UCI HAR Dataset from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and unzip it into your working directory.
2. Ensure the `run_analysis.R` script is in the same directory.
3. Run the script in R:
   ```R
   source("run_analysis.R")


#### `CodeBook.md`
This file describes the variables in the dataset and any transformations. Example:

```markdown
# CodeBook

## Source Data
The dataset originates from the Human Activity Recognition (HAR) dataset available [here](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Variables in the Tidy Dataset

1. **Subject**: The ID of the participant (integer, 1-30).
2. **Activity**: The activity performed (e.g., WALKING, SITTING).
3. **Feature Variables**: Averages of measurements for each subject and activity, such as:
   - `TimeBodyAccelerometerMeanX`
   - `TimeBodyAccelerometerMeanY`
   - `TimeBodyAccelerometerStdZ`
   - And so on...
4. All variable names are transformed for clarity:
   - `t` -> `Time`
   - `f` -> `Frequency`
   - `Acc` -> `Accelerometer`
   - `Gyro` -> `Gyroscope`

## Transformations
1. Merged training and test datasets.
2. Extracted only mean and standard deviation measurements.
3. Applied descriptive names for activities and variables.
4. Created a tidy dataset with averages for each subject and activity.
