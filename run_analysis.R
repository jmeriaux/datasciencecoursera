library(data.table)
library(devtools)
library(plyr)

#install_github("rdatatable/data.table")

# 1)Load Subject and X, Y data from train and test data sets
subject_test <- read.table("./SamsungDS/test/subject_test.txt");
colnames(subject_test) <- c("subject_id");

subject_train <- read.table("./SamsungDS/train/subject_train.txt");
colnames(subject_train) <- c("subject_id");

X_test <- read.table("./SamsungDS/test/x_test.txt");
Y_test <- read.table("./SamsungDS/test/y_test.txt");
colnames(Y_test) <- c("act_id");

X_train <- read.table("./SamsungDS/train/X_train.txt");
Y_train <- read.table("./SamsungDS/train/y_train.txt");
colnames(Y_train) <- c("act_id");

# 2)Merge training and test data sets

subject_total <- rbind(subject_test,subject_train);
X_total <- rbind(X_test,X_train);
Y_total <- rbind(Y_test,Y_train);

# 3) Load Activity labels and Feature in Feature table 
Activity_labels <- read.table("./SamsungDS/activity_labels.txt");
colnames(Activity_labels) <- c("act_id","activity_label");

# Load features
Features <- read.table("./SamsungDS/features.txt");
colnames(Features) <- c("id","fname");

# 4)Extract Mean and std features (column name and index)
Flist <-Features[grepl("mean|Mean|std",Features$fname),];

# 5)Extract Mean and std features from X_ data and add ID for merge
X2_total <- X_total[Flist$id];
colnames(X2_total) <- Flist$fname;

#Add Id before merge to preserve orde
X2_total <- cbind(id=seq(1:nrow(X2_total)),X2_total);


# 6) Add ID to Y data set before merge with Activity_labels to respect the order
Y2_total <- cbind(id = seq(1:nrow(Y_total)), Y_total)

# Merge data sets
Y2_total <- merge(Y2_total,Activity_labels,all=TRUE)

# Merge Y and X data sets using ID common key
Total_set <- merge(Y2_total,X2_total,by="id");

#Remove id and act id columns from Total data set
Total_set$id <- NULL;
Total_set$act_id <- NULL;


# 7) Add subject ID as first column to total data set
Total_set <- cbind(subject_total,Total_set);


#Compute Mean of each colum by subject and activity,
Mean_set <- ddply(Total_set, .(subject_id,activity_label), numcolwise(mean));


# 9) This write function will write the Mean_set.txt file 
write.table(Mean_set,file="./Mean_set.txt",row.name=FALSE)




