# ProgAssignmentDataCleaning
Programming Assignment Coursera course Getting and Cleaning Data

As a first step the following files are loaded:
1. X_train.txt
2. X_test.txt
3. features.txt
4. activity_labels.txt
5. y_train.txt
6. y_test.txt

file 1,2,5,6 are the data files where files 3,4 are used to get dataset labels and activity names
The activity names that are extracted from file 4 are added as an extra column (at the beginning of the dataset) to the train and test datasets to add the sort of activity performed for each row.
Then the train and test data sets, including activity names, are combined (or appended) to get to a complete dataset.
The next step is to add the data labels to the complete dataset and from there the first 7 columns are extracted. these are the activities and the means and standard deviations for the main variables.
New, more descriptive, variable names are defined for the 7 columns that are used in the dataset, which results in the data.fram called "tidydata".
The next step is to create a second data.fram "tidydata2" where for each variable (excluding the activity) the mean by activity is calculdated and added as an extra column in "tidydata2". This results in a data.frame of 13 columns.
"tidydata2" output is then written to "tidy data.txt"
As a last step "Codebook.MD" which includes for all 13 variables in tidydata2 the summary and its class.
