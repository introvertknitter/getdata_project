The repository includes run_analysis.R script which reads training and test data collected from the accelerometers from the Samsung Galaxy S smartphone and transforms it into a simplified and tidy dataset. 

To run the analysis:
- download data from this source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
- unzip it in you R working directory
- run the run_analysis.R script

The script performs the following operations:

1) Reads the activity labels dictionary (activity_labels.txt) containing activity codes (from 1 to 6) and descriptions of corresponding activities (WALKING, WALKING_UPSTAIRS
, WALKING_DOWNSTAIRS
, SITTING
, STANDING
, LAYING
)

2)Reads features dictionary (features.txt), which describe measurements and will be the names for columns of data used in the next steps.

3)Reads ids of subjects for train and test dataset (subject_train.txt,  subject_test.txt) who took part in the research and merges them into one dataframe. The values give information which subject should be attributed to each row of the measurement dataset.

4) Reads activity labels ids for train and test dataset (y_train.txt,  y_test.txt) and merges them into one dataframe. The values give information which activity should be attributed to each row of the measurement dataset.

5) Reads train and test dataset (X_train.txt, X_test.txt), which contain actual measurement values for subjects performing activities and mergest them into one data frame (called set)

6) Labels set from step 5 with column names from step 2

7) Extracts from the set only columns referring to mean and standard deviation for each measurement

8) Adds to the set activity codes from step 4, replaces them with activity descriptions using dictionary from step 1.

9) Adds to the set subject ids from step 3

10) Moves subject ids and activity description columns to the beginning of the set (as column 1 and 2 respectively)

11) Aggregates set by calculating mean for each measurement variable for each activity and each subject making new data frame aggrdata

11) Transforms variable names of aggrdata to easily interprettable ones

12) Exports aggrdata to txt file "tidydata.txt". You will find descriptions of the final daset in file "CODEBOOK.MD" available in this repository.

