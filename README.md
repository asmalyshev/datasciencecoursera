# Getting and Cleaning Data
Repo for Getting and Cleaning Data course on Coursera

The script **run_analysis.R** includes function *getCleanData()*. The main purpose of this function is to prepare tidy data set for data collected from the accelerometers from the Samsung Galaxy S smartphone. 
Function goes through these steps:
  1. Read labels for features and activites 
  2. Prepare training data set
  3. Prepare test data set
  4. Merge two data sets in one
  5. Remove unused duplicate columns like "fBodyAcc-bandsEnergy()-1,8"
  6. Select only the measurements on the mean and standard deviation
  7. Prepare tidy data set

The output of function is tidy data set. Use Code_Book.txt to get description of the data variables.
You can easily save result of running getCleanData() using  
`write.table(getCleanData(), "tidyData.txt", row.names = FALSE)`

Reading of prepared data set is also simple and can be done as follows:  
`dataSet <- read.table("tidyData.txt", header = TRUE)`
