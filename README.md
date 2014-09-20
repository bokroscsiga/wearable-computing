This is a Course Project fot the Getting and Cleaning Data course on Coursera

In this repo you will find the following files: 

- 'README.md': the readme file
- 'CodeBook.md': the codebook with explanations about the method of obtianing the tidy data, variablenames  
- 'run_analysis.R': the .R scipt that takes the original raw data and transforms it into a tidy dataset
- 'tidy.txt': the resulting tidy dataset

Please go take a look at the list of transformations in 'CodeBook.md' that are made in 'run_analysis.R'
in order to get 'tidy.txt'. Note that the steps are not always identical to the descriptions on the 
Course Project's website. 

Also, notice that I took kept variables from the raw dataset that had 'mean' and 'std' in their name (case sensitively).

Variable names are as descriptive as they are in the original raw dataset. Please read the cited description of them in 'CodeBook.md'.

For the detialed description of the script resulting 'tidy.txt' please take a look at the comments in 'run_analysis.R' at the relevant parts.

The main steps are:
- reading in the names of the variables from "features.txt"
- reading in training and test data; naming variables; keeping only measurments on the mean and standard deviation for each measurement
- merging training and test datasets
- reading in subject and activity datasets for both training and test; merging datasets
- adding descriptive activity names to name the activities in the dataset
- merging datasets
- creating a tidy dataset with the average of each variable for each activity and each subject
- reordering dataset
- creating 'tidy.txt'

To read in 'tidy.txt', please use the following command in R: read.table("./tidy.txt", sep = ",")

