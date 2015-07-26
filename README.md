# Getting-and-Cleaning-Data-Course-Project
1. Reads datas into R
test_label<-read.table("./test/y_test.txt")
test_subject<-read.table("./test/subject_test.txt")
test_set<-read.table("./test/X_test.txt")
train_label<-read.table("./train/y_train.txt")
train_subject<-read.table("./train/subject_train.txt")
train_set<-read.table("./train/X_train.txt")
features<-read.table("features.txt")
act_lab<-read.table("activity_labels.txt")
2. Collects training and test sets
test<-cbind(test_set,test_label,test_subject)
train<-cbind(train_set,train_label,train_subject)
3. Names the two data sets variables
names(test)<-features[,2]
names(train)<-features[,2]
names(test)[562]<-names(train)[562]<-"activity"
names(test)[563]<-names(train)[563]<-"subject"
4. Merges the training and the test sets to create one data set.
data<-rbind(train,test)
5. Uses preg() to find mean and standard deviation measurement variables.
Ext<-c(grep("mean()",names(data)),grep("std()",names(data)),562,563)
6. Extracts the measurements on the mean and standard deviation for each measurement.
Subdata<-data[,Ext]
7. Fators activities names then uses descriptive labels as levels
Subdata$activity<-as.factor(Subdata$activity)
levels(Subdata$activity)<-act_lab[,2]
8. Appropriately labels the data set with descriptive variable names by make.names 
names(Subdata)<-make.names(names(Subdata))
9. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
meltdata<-melt(Subdata,id = c("activity","subject"),measure.vars = names(Subdata)[1:79])
newData<-dcast(meltdata, activity + subject ~ variable, mean)
10. Output an txt file
write.table(newData,"newdata.txt",row.names = FALSE)
