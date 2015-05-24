# Getting&CleaningData-courseproject
Course Project 

This repository contains two other files: run_analysis.R and CodeBook.md.

CodeBook.md contains the descriptions of the variables as well as a description of the data itself.

run_analysis.R contains the scripts that cleaned and analyzed the data.

Process for cleaning the data:

- For the first step in cleaning, I assumed the file containing the data came exactly like the unzipped folder. This means that the features.txt file is in the main/working directory, while the test and train data are in their respective folders. In doing so I called each .txt file using the 'read.table' function and created the following dataframes: 
  + features (Contains the variable names for each data column)
  + x_test, x_train (The individual measurements found during data collection)
  + y_test, y_train (Contains the activity rows associated with the measurements that range from 1.Walking, 2.Walking_Upstairs, 3.Walking_Downstairs, 4.Sitting, 5.Standing, 6.Laying)
  + sub_test, sub_train (Contains the subject ID number that ranges from 1 - 30)
  
- After reading in the files, I needed to change the column names in the x_test/train dataframes to their respective descriptive variable names. To do this I first needed to change the features column containing the variables names from the 'factor' class to 'char' class. I used the 'lapply' function in conjunction with the 'as.character' to accomplish this. The reason for changing classes is to match with the 'names' function which requires a character vector. 

- The next step is to remove the unwanted columns and change update the x_test/train dataframes. I used 'grep' to make two vectors, tmp1 and tmp2, that contained the indexes where the pattern was found. For tmp1 I used the pattern "-std()" and for tmp2 I used "-mean()." I included the 'fixed=TRUE' in order to remove and "-meanFreq()." The "-meanFreq()" was not included as there was no associated "-std()" with that value. I then used 'sort(rbind(tmp1, tmp2))' to get the columns in ascending order. Then the columns were removed by only adding the indexes found in the sortedtmp variable.

- The dataframe, fullList, has all the datasets combined through using 'cbind' to combine the x, y, and subject datasets into the two dataframes of test and train. 'rbind' was then used to combine these to make fullList; which also changed the first two column names to the variable names of 'subject' and 'activity.'

- To change the activity values (1, 2, 3, 4, 5, 6) into their true values (walking, walking_upstairs, walking_downstairs, sitting, standing, laying), I used the function 'mapvalues' from the R library 'plyr.' 

Process for creating the tidy dataset:
- The two main functions used to accomplish this is from the R library "reshape2." I define the IDs for the 'melt' function into aggID. Using 'melt' I identify the IDs, leaving the rest of the columns as the variables. Using 'dcast' I am then able to use the 'mean' function on grouped by 'subject' and 'activity.' The final .txt file is written by 'write.table.'




