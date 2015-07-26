#Reading activity labels dictionary

act_lab<-read.table("UCI HAR Dataset/activity_labels.txt", header=FALSE)
names(act_lab)=c("Activity_code","Activity")

#Reading features dictionary (for columns)
feat_lab<-read.table("UCI HAR Dataset/features.txt", header=FALSE)

#Reading subject ids
tr_sub<-read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE)
ts_sub<-read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)
sub<-rbind(tr_sub,ts_sub)

#Reading activity labels
tr_lab<-read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE)
ts_lab<-read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE)
lab<-rbind(tr_lab,ts_lab)


#Reading data sets
tr_set<-read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE)
ts_set<-read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE)
set<-rbind(tr_set,ts_set)

#Labelling data with initial variable names
names(set)<-feat_lab$V2

#Extracting only the measurements on the mean and standard deviation for each measurement. 
set<-set[ , c( grep("mean\\(|std\\(", names(set)))]

#Adding activities to data set
set$Activity_code<-lab$V1 

#Adding subject ids to data set
set$Subject<-sub$V1

#applying descriptive activity names to name the activities in the data set
set = merge(set,act_lab,by = "Activity_code",all=TRUE) #adding activity labels
set<-set[,names(set)!="Activity_code"]  #removing variable with activity code
set<-set[,c(67,68,1:66)]    #moving activity label to beginning

#creatung a second, independent tidy data set with the average of each variable for each activity and each subject.
aggrdata <- aggregate(set[,c(3:68)], by = set[c("Subject", "Activity")], FUN=mean)

#cleaning variable_names
names(aggrdata) <- gsub("\\(|\\)", "",names(aggrdata))
names(aggrdata) <- gsub("Mag", "-Magnitude",names(aggrdata))
names(aggrdata) <- gsub("Acc", "-Acceleration",names(aggrdata))
names(aggrdata) <- gsub("Jerk", "-Jerk",names(aggrdata))
names(aggrdata) <- gsub("Gyro", "-Gyro",names(aggrdata))
names(aggrdata) <- gsub("BodyBody", "Body",names(aggrdata))
names(aggrdata) <- gsub("^t", "",names(aggrdata))
names(aggrdata) <- gsub("^f", "FFT-",names(aggrdata))

#Writing final dataset into txt file
write.table(aggrdata, "tidydata.txt", sep="\t", row.names = FALSE)

