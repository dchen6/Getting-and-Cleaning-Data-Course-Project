Summary: this file describes the variables, the data, and any transformations or work to clean up the data.

Data source: collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data manipulation:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.