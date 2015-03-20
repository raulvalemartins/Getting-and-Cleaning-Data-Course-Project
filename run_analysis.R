run_analysis <- function ( ) {
        
        ## read files
        features <- read.csv( "features.txt", header = FALSE , sep = "" )
        activitylabels <- read.csv( "activity_labels.txt", header = FALSE, sep = "" )
        
        subjecttest <- read.csv( "./test/subject_test.txt", header = FALSE )
        xtest <- read.csv( "./test/x_test.txt", header = FALSE, sep = "" )
        ytest <- read.csv( "./test/y_test.txt", header = FALSE )
        
        subjecttrain <- read.csv( "./train/subject_train.txt", header = FALSE )
        xtrain <- read.csv( "./train/x_train.txt", header = FALSE, sep = "" )
        ytrain <- read.csv( "./train/y_train.txt", header = FALSE )
        
        ## features to include
        includedfeatures <- grep("std|mean|Mean", features$V2)
        
        ## process xtest data
        xtest <- xtest[, includedfeatures]
        colnames(xtest) <- features[includedfeatures,2]
        xtest <- cbind(as.data.frame(activitylabels[ytest[,1],2]), xtest )
        xtest <- cbind(as.data.frame(subjecttest[,1]), xtest )
        colnames(xtest)[1:2] = c( "Subject", "Activity Label")
        
        ## process xtrain data
        xtrain <- xtrain[, includedfeatures]
        colnames(xtrain) <- features[includedfeatures,2]
        xtrain <- cbind(as.data.frame(activitylabels[ytrain[,1],2]), xtrain )
        xtrain <- cbind(as.data.frame(subjecttrain[,1]), xtrain )
        colnames(xtrain)[1:2] = c( "Subject", "Activity Label")
        
        ## merge/union of data
        df <- rbind( xtest, xtrain )
        
        ## calculates the aggregates and write the table that cover the 
        ## steps 5 of the peer assessment 
        ag <- aggregate(df[,3:ncol(df)], by = list(df$Subject, df$"Activity Label"), FUN = mean)
        colnames(ag)[1:2] = c( "Subject", "Activity Label")
        write.table( ag, "Step5.txt", sep = ",", row.name = FALSE)
        
        return (ag)
}