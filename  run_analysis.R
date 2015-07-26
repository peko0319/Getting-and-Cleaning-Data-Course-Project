test_label<-read.table("./test/y_test.txt")
test_subject<-read.table("./test/subject_test.txt")
test_set<-read.table("./test/X_test.txt")
train_label<-read.table("./train/y_train.txt")
train_subject<-read.table("./train/subject_train.txt")
train_set<-read.table("./train/X_train.txt")
test<-cbind(test_set,test_label,test_subject)
train<-cbind(train_set,train_label,train_subject)
features<-read.table("features.txt")
act_lab<-read.table("activity_labels.txt")
names(test)<-features[,2]
names(train)<-features[,2]
names(test)[562]<-names(train)[562]<-"activity"
names(test)[563]<-names(train)[563]<-"subject"
data<-rbind(train,test)
Ext<-c(grep("mean()",names(data)),grep("std()",names(data)),562,563)
Subdata<-data[,Ext]
Subdata$activity<-as.factor(Subdata$activity)
levels(Subdata$activity)<-act_lab[,2]
names(Subdata)<-make.names(names(Subdata))
meltdata<-melt(Subdata,id = c("activity","subject"),measure.vars = names(Subdata)[1:79])
newData<-dcast(meltdata, activity + subject ~ variable, mean)
write.table(newData,"newdata.txt",row.names = FALSE)