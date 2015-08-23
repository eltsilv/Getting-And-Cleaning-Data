# Getting-And-Cleaning-Data
Repo for the Getting And Cleaning Data Course Project

This repository contains the script for the course project of "Getting and Cleaning data" Coursera course.

## About the source data

The source data for the project is a collection of data from accelerometers of Samsung Galaxy S devices that can be obtained at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

In the zipped file there are data from Training and Test that needs to be merged, as well as other files that are used
to describe the features and activities analysed.

## How to use the script

First of all extract the UCI HAR Dataset.zip downloaded from the address above to the working directory of R on your
computer, in a sub_directory named "UCI HAR Dataset" .

Open the script run_analysis.R, that will perform the merge and cleaning of the data to produce a tidy data set,
containing the means of all the columns by subject and activity. 

The output file will feature the columns separed by Tabs and will be available on the working directory
