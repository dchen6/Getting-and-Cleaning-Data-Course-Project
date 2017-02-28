# Install (if necessary) and load packages
install.packages("reshape2")
require(reshape2)

# create directory and set working path
getwd()
setwd("C:\\Users\\Chen De\\Desktop\\Coursera - DS\\Getting and Cleaning Data")

if(!dir.exists("./project")){dir.create("./project")}


# check all available datasets
list.files("./project/UCI HAR Dataset")
list.files("./project/UCI HAR Dataset/train")
list.files("./project/UCI HAR Dataset/test")

# read in activity labels and features data
activity_lables <- read.table("./project/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = F)
features <- read.table("./project/UCI HAR Dataset/features.txt", stringsAsFactors = F)

# measure meaningful variables
features_indices <- grep(".*mean.*|.*std.*", features[,2])
features_indexed <- features[features_indices, 2]
# clean the features - remove ()
features_indexed <- gsub('[-()]', '', features_indexed)

# load training data
train <- read.table("./project/UCI HAR Dataset/train/X_train.txt", stringsAsFactors = F)[features_indices]
train_activities <- read.table("./project/UCI HAR Dataset/train/Y_train.txt", stringsAsFactors = F)
train_subjects <- read.table("./project/UCI HAR Dataset/train/subject_train.txt", stringsAsFactors = F)
str(train)
str(train_activities)
str(train_subjects)
train_data <- cbind(train_subjects, train_activities, train)

# load test data
test <- read.table("./project/UCI HAR Dataset/test/X_test.txt", stringsAsFactors = F)[features_indices]
test_activities <- read.table("./project/UCI HAR Dataset/test/Y_test.txt", stringsAsFactors = F)
test_subjects <- read.table("./project/UCI HAR Dataset/test/subject_test.txt", stringsAsFactors = F)
str(test)
str(test_activities)
str(test_subjects)
test_data <- cbind(test_subjects, test_activities, test)

# stack train and test data
mdata <- rbind(train_data, test_data)
# rename column names to make them more descriptive
names(mdata) <- c("subject", "activity", features_indexed)
names(mdata)

# formate categorical variables
mdata$activity <- as.factor(mdata$activity)
unique(mdata$activity)
mdata$subject <- as.factor(mdata$subject)
unique(mdata$subject)

# summarize mdata into tidy data

# You need to tell melt which of your variables are id variables, and which are measured variables. 
# If you only supply one of id.vars and measure.vars, melt will assume the remainder of the variables in the data set belong to the other. 
# If you supply neither, melt will assume factor and character variables are id variables, and all others are measured.
mdata_melt <- melt(mdata, id = c("subject", "activity"))

# Cast functions Cast a molten data frame
mdata_cast <- dcast(mdata_melt, subject + activity ~ variable, mean)
str(mdata_cast)

# save tidy data in local repo
write.table(mdata_cast, "./project/Getting-and-Cleaning-Data-Course-Project/tidy_data.txt", row.names = F)

