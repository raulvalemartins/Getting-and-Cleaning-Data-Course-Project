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
        
        ## process xtest data
        colnames(xtest) <- features[,2]
        xtest <- cbind(as.data.frame(activitylabels[ytest[,1],2]), xtest )
        xtest <- cbind(as.data.frame(ytest[,1]), xtest )
        xtest <- cbind(as.data.frame(subjecttest[,1]), xtest )
        xtest <- cbind(as.data.frame(rep("Test", nrow(xtest))), xtest )
        colnames(xtest)[1:4] = c("Group", "Subject", "Activity ID", "Activity Label")
        
        ## process xtrain data
        colnames(xtrain) <- features[,2]
        xtrain <- cbind(as.data.frame(activitylabels[ytrain[,1],2]), xtrain )
        xtrain <- cbind(as.data.frame(ytrain[,1]), xtrain )
        xtrain <- cbind(as.data.frame(subjecttrain[,1]), xtrain )
        xtrain <- cbind(as.data.frame(rep("Train", nrow(xtrain))), xtrain )
        colnames(xtrain)[1:4] = c("Group", "Subject", "Activity ID", "Activity Label")
        
        ## merge/union of data
        df <- rbind( xtest, xtrain )
        x <- df
        
        ## calculate and merge union means of column data
        agregatedcolsclassifiers <- data.frame( "", "", "", "means" )
        colnames(agregatedcolsclassifiers) = c("Group", "Subject", "Activity ID", "Activity Label")
        agragatedcolsdata <- as.data.frame(lapply(x[,5:ncol(x)],  mean ))
        colnames(agragatedcolsdata) = features[,2]
        totalmean <- cbind( agregatedcolsclassifiers, agragatedcolsdata)
        df <- rbind ( df, totalmean)
        
        ## calculate and merge union std dev of column data
        agregatedcolsclassifiers <- data.frame( "", "", "", "std dev" )
        colnames(agregatedcolsclassifiers) = c("Group", "Subject", "Activity ID", "Activity Label")
        agragatedcolsdata <- as.data.frame(lapply(x[,5:ncol(x)],  sd ))
        colnames(agragatedcolsdata) = features[,2]
        totalsd <- cbind( agregatedcolsclassifiers, agragatedcolsdata)
        df <- rbind ( df, totalsd)
        
        ## write the table that cover the steps 1 to 4 of the peer assessment 
        write.table( df, "Step1to4.txt", sep = ",", row.name = FALSE)
        
        ## calculates the aggregates and write the table that cover the 
        ## steps 5 of the peer assessment 
        ag <- aggregate(x[,5:ncol(x)], by = list(x$Subject, x$"Activity Label"), FUN = mean)
        colnames(ag)[1:2] = c( "Subject", "Activity Label")
        write.table( ag, "Step5.txt", sep = ",", row.name = FALSE)
        
        return (df)
}