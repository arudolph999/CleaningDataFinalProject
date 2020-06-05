# Libraries

library(dplyr)
library(tidyr)
library(readr)
library(data.table)
library(stringr)
library(janitor)


# Inputting data

# I imported the data  in the format it was originally given in. This required the 3 test tables, the 3 train tables, the features table and the activity_labels table.
# In total there were 7352 records in the train data and 2947 in the test data.
# The subject table showed which subject each of these records refer to.
# The y table shows which activity each of these records refer to.
# The X table shows some measurements for each of these records.

X_train<- fread("C:/Users/rudolpa/OneDrive - Jacobs/R Training/Cleaning Data Course/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt",sep=" ")
y_train<- fread("C:/Users/rudolpa/OneDrive - Jacobs/R Training/Cleaning Data Course/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt",sep=" ")
subject_train<- fread("C:/Users/rudolpa/OneDrive - Jacobs/R Training/Cleaning Data Course/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt",sep=" ")

X_test<- fread("C:/Users/rudolpa/OneDrive - Jacobs/R Training/Cleaning Data Course/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt",sep=" ")
y_test<- fread("C:/Users/rudolpa/OneDrive - Jacobs/R Training/Cleaning Data Course/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt",sep=" ")
subject_test<- fread("C:/Users/rudolpa/OneDrive - Jacobs/R Training/Cleaning Data Course/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt",sep=" ")

features<- fread("C:/Users/rudolpa/OneDrive - Jacobs/R Training/Cleaning Data Course/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt",sep=" ")
activity_lables<- fread("C:/Users/rudolpa/OneDrive - Jacobs/R Training/Cleaning Data Course/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt",sep=" ")

# Step 1: Merging to 1 dataset

# I first used cbind binded the train data and the test data into 1 table. I put the subject first, then the activity and then the measurements in the X table.
# I then used rbind to combine the train and test data. I also converted it to a data frame in this stage.

train_full<-cbind(subject_train,y_train,X_train)
test_full<-cbind(subject_test,y_test,X_test)
df_full<-as.data.frame(rbind(train_full,test_full))

# Step 4: Adding headings to dataset

# I did step 4 now as I deemed it easier to pick the right columns once they had names.
# The first and second columns were named 'subject_number' and 'activity_number' as this is what they were.
# The rest of the columns were named as per the features (measurements) given in the features table.

names(df_full)[1]<-"Subject_number"
names(df_full)[2]<-"Activity"
names(df_full)[3:ncol(df_full)]<-features$V2

# Step 2: Finding which features are on mean or standard deviation

# I used the grep function to find the features that contained the words 'mean' or 'std', which were the mean and standard deviation variables.
# The grep function gave me the numbers of the features. I then found the relevant feature names and from there subsetted the columns that were the appropriate name (and removed the others).
mean_sd_feautures_numbers<-grep("mean|std",features$V2)
mean_sd_feautures<-features$V2[mean_sd_feautures_numbers]
df<-cbind(df_full[,1:2],df_full[names(df_full) %in% mean_sd_feautures])

# Step 3: Naming activities

# The activity_labels table showed which activity number represents which activity.
# I used a for loop for this, linking the activity number to the activity name.

for (i in 1:6) {
  df$Activity[df$Activity == i] <-activity_lables$V2[i]
}

# Step 5: Making second averages table

# I grouped the datea by subject number and activity as required.
# I used the summarise_each file to then find the mean of each variable split by subject and activity.
# I finally arranged the data bu subject number.

grouped_data<-group_by(df,Subject_number,Activity)
tidy_data<-summarise_each(grouped_data,mean)
tidy_data<-arrange(tidy_data,Subject_number)

# Uploading table

write.table(tidy_data,file = "C:/Users/rudolpa/OneDrive - Jacobs/R Training/Cleaning Data Course/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/tidy_data_table.txt",row.names = FALSE)