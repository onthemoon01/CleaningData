## run_analysis explanantions

# required before running code
* install package 'reshape2'

#Code description

My sequence was the following:
*load the training and test tables
*bind the datas (subject, activity, table) for training set andvthen for test set
*merge both data sets to create the big data table named fullTabe to work with 
*I then appropriately named columns. Of note, for the variable name, I vectorized features.txt
*I modify names to suppress special character such as "-", "," and "()", before I subset the big datas, as it is easier to do it at this stage
*I change activity code by descriptive name
*I then subset the data to a small table which only keeps the column with the word mean or std. I excluded the word angle, as the angle implying a mean is not a mean
*To finish the tidy table, I performed a melt/dcast sequence to calculate mean of every variable, for each subject and each activity (I presume average is equal to mean)
