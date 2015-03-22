getCleanData <- function() {
  # This function prepares tidy data set for data collected 
  # from the accelerometers from the Samsung Galaxy S smartphone.
  #
  # Args:
  #   none
  #
  # Returns:
  #   The data frame of tidy data set
  
  # Load used libraries
  library(plyr)
  library(dplyr)
  
  # Check if Samsung data is present in working directory
  if (file.exists("./UCI HAR Dataset")) {
    # Read labels for features and activites 
    features <- read.table("./UCI HAR Dataset/features.txt", sep = " ", header = FALSE, col.names = c("id", "featureName"), stringsAsFactors = FALSE)
    activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", sep = " ", header = FALSE, col.names = c("activityId", "activityName"))
    
    # Prepare training data set
    trainingDS <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
    names(trainingDS) <- features$featureName
    trainingActivities <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE, col.names = c("activityId"))
    trainingDS <- cbind(trainingDS, activityId = trainingActivities$activityId)
    trainingDS <- join(trainingDS, activityLabels)
    trainingSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE, col.names = c("subjectId"))
    trainingDS <- cbind(trainingDS, subjectId = trainingSubjects$subjectId)
    
    # Prepare test data set
    testDS <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features$featureName, header = FALSE)
    names(testDS) <- features$featureName
    testActivities <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE, col.names = c("activityId"))
    testDS <- cbind(testDS, activityId = testActivities$activityId)
    testDS <- join(testDS, activityLabels)
    testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE, col.names = c("subjectId"))
    testDS <- cbind(testDS, subjectId = testSubjects$subjectId)
    
    # Merge two data sets in one
    completeDS <- rbind(trainingDS, testDS)
    
    # Remove unused duplicate columns like "fBodyAcc-bandsEnergy()-1,8"
    completeDS <- completeDS[!duplicated(names(completeDS))]
    
    # Select only the measurements on the mean and standard deviation
    completeDS <- select(completeDS, subjectId, activityName, matches("(mean|std)\\(\\)"))
    
    # Prepare tidy data set
    by_subject_activity <- completeDS %>% group_by(subjectId, activityName)
    by_subject_activity <- by_subject_activity %>% summarise_each(funs(mean))
    return(by_subject_activity)
  }
  else {
    stop("Samsung data is not in your working directory")
  }
}