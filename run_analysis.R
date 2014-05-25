setwd("~/Desktop/Computer science/Cleaning datas/assignment/UCI HAR Dataset")
## load the training and test tables
brutXTest<-read.table("test/X_test.txt")
brutXTrain<-read.table("train/X_train.txt")
brutYTest<-read.table("test/Y_test.txt")
brutYTrain<-read.table("train/Y_train.txt")
brutSubjTest<-read.table("test/subject_test.txt")
brutSubjTrain<-read.table("train/subject_train.txt")
## bind the datas (subject, activity, table) for training and test sets
fullTrain<- cbind(brutSubjTrain,brutYTrain,brutXTrain)
fullTest<- cbind (brutSubjTest,brutYTest,brutXTest)
## merge both data sets
fullData<-rbind(fullTrain, fullTest)
## Approprietly name column and clean the names
featVec<-as.vector(read.table("features.txt",colClasses='character')[,2])
colnames(fullData)<-c('subjectnumber','activity',featVec)
colnames(fullData)<-gsub("\\()","",names(fullData))
colnames(fullData)<-gsub("-","",names(fullData))
colnames(fullData)<-gsub(",","",names(fullData))
colnames(fullData)<-tolower(names(fullData))
##Change activity code by descriptive name
fullData$activity[fullData$activity == 1] <- "walking"
fullData$activity[fullData$activity == 2] <- "walkingupstairs"
fullData$activity[fullData$activity == 3] <- "walkingdownstairs"
fullData$activity[fullData$activity == 4] <- "sitting"
fullData$activity[fullData$activity == 5] <- "standing"
fullData$activity[fullData$activity == 6] <- "laying"
##only keep the column with mean or std but not the angle using a mean
colWithMean<-grep('mean',names(fullData))
colWithStd<-grep('std',names(fullData))
smallData1<-fullData[,c(1,2,colWithMean,colWithStd)]
colWithAngle<-grep('angle', names(smallData1))
smallData<-smallData1[,-c(colWithAngle)]
##First change activity and subject number to factor, 
##then compute the mean for each variable for each subject, creating the famous tidy data
smallData$activity<-as.factor(smallData$activity)
smallData$subjectnumber<-as.factor(smallData$subjectnumber)
library(reshape2)
temp<-melt(smallData, id=c('subjectnumber', 'activity'), vars.measures=colnames(smallData[-c(1,2)]))
tidyData<-dcast(temp, subjectnumber + activity ~ variable,mean)
tidyData
write.table(tidyData, "~/repo/tidyData.txt")