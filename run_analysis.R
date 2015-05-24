#Call each dataset
features <- read.table("features.txt")
sub_train <- read.table("train//subject_train.txt")
x_train <- read.table("train//X_train.txt")
y_train <- read.table("train//y_train.txt")
sub_test <- read.table("test//subject_test.txt")
x_test <- read.table("test//X_test.txt")
y_test <- read.table("test//y_test.txt")

#Add the correct titles to dataset
features$V2 <- lapply(features$V2, as.character) #Changes factor into char
names(x_train)[1:561] <- c(features$V2)
names(x_test)[1:561] <- c(features$V2)

#Remove unwanted columns
tmp1 <- grep(pattern="-std()", features$V2, fixed=TRUE)
tmp2 <- grep(pattern="-mean()", features$V2, fixed=TRUE)
sortedtmp <- sort(rbind(tmp1, tmp2))

#x datasets with descriptive variable names
x_train <- x_train[1:561][,c(sortedtmp)]
x_test <- x_test[1:561][,c(sortedtmp)]

#Merge datasets with and descriptive variable names for subject and activity
train <- cbind(sub_train, y_train, x_train)
test <- cbind(sub_test, y_test, x_test)
fullList <- rbind(train, test)
names(fullList)[1:2] <- c("subject", "activity")

#Create appropriate activity names
library(plyr) #to use mapvalues
currentValues <- c(1,2,3,4,5,6)
newValues <- c("walking", "walking_upstairs", "walking_downstairs", "sitting",
               "standing", "laying")
fullList$activity <- mapvalues(fullList$activity, currentValues, newValues)

#Create second aggregated dataset
library(reshape2) #for melt and dcast functions
aggID <- c("subject", "activity")

#Separates the id and the variables
agg_df <- melt(fullList, id=aggID) 

#Gets the mean for each variable given the subject and activity
agg_data <- dcast(agg_df, subject + activity ~ variable, mean)

#Write .txt file for aggregate dataset
write.table(agg_data,file="tidyData.txt",row.names=FALSE)













