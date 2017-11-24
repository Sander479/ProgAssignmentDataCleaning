library(dplyr)
library(data.table)
## loading train data
train <- read.table("UCI HAR Dataset/train/X_train.txt")
## loading test data
test <- read.table("UCI HAR Dataset/test/X_test.txt")
## loading features list for columnames
x <- read.table("UCI HAR Dataset/features.txt")
x <- make.unique(as.character(x[,2]))
## loading activity labels and dataset labels to create activity names
l<- read.table("UCI HAR Dataset/activity_labels.txt")
## creating activity names for train and test dataset by adding a column at the end that displays the activity
y_labelstrain <- read.table("UCI HAR Dataset/train/y_train.txt")
y_labelstest <- read.table("UCI HAR Dataset/test/y_test.txt")
ylabelstrain <- as.vector(y_labelstrain[,1])
labeltrain <- cbind(as.vector(l[,1]),as.vector(l[,2]))
Activity <- c()
for(i in 1:length(ylabelstrain)) {
  Activity[i]= labeltrain[ylabelstrain[i],2]
}
train <- cbind(Activity,train)

ylabelstest <- as.vector(y_labelstest[,1])
labeltest <- cbind(as.vector(l[,1]),as.vector(l[,2]))
Activity <- c()
for(i in 1:length(ylabelstest)) {
  Activity[i]= labeltest[ylabelstest[i],2]
}
test <- cbind(Activity,test)
## appending the train and test data set
total<- rbind(train,test)
## set the columnames for the total set
x<- c("Activity",x)
colnames(total) <- x
## only select the columns that have either the string "mean" or "std" in their name and add the activity column
ms <- select(total,matches("mean|std"))
sm <- cbind(total$Activity,ms)
colnames(sm)[1]="Activity"
## select only the mean and std for the main body measurements
tidydata <- select(sm,c(1:7))
colnames(tidydata) <- c("Activity","MeanBodyAccelerationTimeX","MeanBodyAccelerationTimeY","MeanBodyAccelerationTimeZ","StdBodyAccelerationTimeX","StdBodyAccelerationTimeY","StdBodyAccelerationTimeZ")
## create 2nd tidy dataset tidydata2 that adds the average per variable in tidydata per activity
tidydata2 <- tidydata
setDT(tidydata2)[, AvgMeanBodyAccelerationTimeX := mean(MeanBodyAccelerationTimeX), by = Activity]
setDT(tidydata2)[, AvgMeanBodyAccelerationTimeY := mean(MeanBodyAccelerationTimeY), by = Activity]
setDT(tidydata2)[, AvgMeanBodyAccelerationTimeZ := mean(MeanBodyAccelerationTimeZ), by = Activity]
setDT(tidydata2)[, AvgStdBodyAccelerationTimeX := mean(StdBodyAccelerationTimeX), by = Activity]
setDT(tidydata2)[, AvgStdBodyAccelerationTimeY := mean(StdBodyAccelerationTimeY), by = Activity]
setDT(tidydata2)[, AvgStdBodyAccelerationTimeZ := mean(StdBodyAccelerationTimeZ), by = Activity]
Codebook.MD <- matrix(rep(0,91),nrow=13,ncol=7)
## write the dataset to a .txt file
write.table(tidydata2, file = "tidy data.txt",row.name=FALSE)
## create Codebook.MD that updates the Codebook.MD file with the variables and summaries
rownames(Codebook.MD) <- colnames(tidydata2)
colnames(Codebook.MD) <- c("Characteristic 1","Characteristic 3","Characteristic 3","Characteristic 4","Characteristic 5","Characteristic 6","Characteristic 7")
for(i in 1:length(tidydata2[1,])) {
  Codebook.MD[i,2:length(Codebook.MD[1,])] <- summary(tidydata2)[,i]
}
Codebook.MD[,1]<- c(class(tidydata2$Activity),class(tidydata2$MeanBodyAccelerationTimeX),class(tidydata2$MeanBodyAccelerationTimeY),class(tidydata2$MeanBodyAccelerationTimeZ),class(tidydata2$StdBodyAccelerationTimeX),class(tidydata2$StdBodyAccelerationTimeY),class(tidydata2$StdBodyAccelerationTimeZ),class(tidydata2$AvgMeanBodyAccelerationTimeX),class(tidydata2$AvgMeanBodyAccelerationTimeY),class(tidydata2$AvgMeanBodyAccelerationTimeZ),class(tidydata2$AvgStdBodyAccelerationTimeX),class(tidydata2$AvgStdBodyAccelerationTimeY),class(tidydata2$AvgStdBodyAccelerationTimeZ))
write.table(Codebook.MD, file = "Codebook.MD")