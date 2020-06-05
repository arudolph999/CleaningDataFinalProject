# CleaningDataFinalProject
Cleaning Data Final Project

The input data for this project was:
•	'features.txt': List of all features.
•	'activity_labels.txt': Links the class labels with their activity name.
•	subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
•	X_train.txt': Training set of measurements
•	y_train.txt': Training labels.
•	subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
•	X_test.txt': Test set of measurements
•	y_test.txt': Test labels.

These should all be included in the input directory for anyone running the code.

The tables that I created (in order to form the final table) were:
•	‘train_full’: Collates the subject, y and X train tables in 1 table.
•	‘test_full’: Collates the subject, y and X test tables in 1 table.
•	‘df_full’: Binds together the test and train data.
•	‘df’: Keeps only the variables that have mean or standard deviation, renames the variables to the feature names and changes the activities from number to name.

The final table is:
•	‘tidy_data’: Averages each of the variables per subject and per activity.
The final table is the document ‘tidy_data_table.txt’. 
