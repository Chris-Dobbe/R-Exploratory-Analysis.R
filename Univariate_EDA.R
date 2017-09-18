############################### Univariate EDA #########################################

# Univariate Exploratory Data Analysis script

# Project Name:

# Data source: 

############################################################################################

# begin by setting the working directory for the files
setwd("C:/Users/*******/R")

#Load the packages and libraries, or d/l any using install.packages("???")
library(dplyr)
library(magrittr)
library(tidyr)
library(readr)
library(stringr)
library(ggplot2)
library(gridExtra)
library(DescTools)
library(Hmisc)
library(pastecs)
library(psych)

# Begin by loading in the dataset using the appropriate method

#data1 <- file.choose() # Allows for manual selection from folder location, paired with below
#data <- read_csv(data1)  
data1 <- read_csv("file_name.csv") #loads in the CSV to a tibble, easier to work with
#data1 <- read.csv("file_name.tsv", sep = "\t", header = TRUE)
#data1 <- read.xls("file_name.xlsx")
#data1 <- XLGetRange(sheet = "sheet1", range = "A1:B21", header = TRUE) #only used when Excel workbook is open


#Open the data view
View(data1)

### Basic summary functions to understand the data
names(data1)
head(data1)
str(data1)
class(data1)
dim(data1) #number of rows and columns)

#####   Section 1: Data cleansing and Prep   #####

### Convert any columns to a factor, or other data types, if needed (as.numeric, as.integer, etc.)
data1[,"Level"] <- lapply(data1[,"Level"],as.factor)  #converts specified column to factor
str(data1)  #double check data types to ensure change happened

### Change the name of columns to make them easier to call
colnames(data1) <- c("date", "visits")

### Create new variables with filtered or subsets of the original dataset
newdata1 <- data1 %>% filter(data1$column.name == "variable1")  # filter data by rows, returning only rows with a certain variable
newdata2 <- data1 %>% arrange(column.name, column.name)  # arrange data by rows, returning only rows that match that variable
newdata3 <- data1 %>% select(CountryName)  # select specific columns, return only specific columns with that variable
newdata3a <- data1 %>% select(-CountryName, -ZIPcode) # removes specified columns from data frame

### Group and Summarise Data, similar to a pivot table
newdata4 <- data1 %>% group_by(column.name)  # groups data by a column variables
newdata5 <- data1 %>% summarise(number = n())  # summarise data by a number of occurences
newdata6 <- data1 %>% summarise_each(funs(sum), column.name, column.name, column.name)  #summarise each column specified and return 1 sum
  # summarise_each can also be paried with group_by to get sums for common variables in one column
newdata7 <- mutate(data1, new.variable = var_1 + var_2)  # creates new column based on combination of existing columns

### Combine and Compare data sets (like a lookup table)
newdata8 <- data1 %>% semi_join(data1, lookup_table1, by="column.name")  # shows rows of data that DO match the other lookup table
newdata9 <- anti_join(data1, lookup_table1, by="column.name")  # shows rows of data that DO NOT match the other table

### Remove any rows that have an N/A value within a specific column
data2 <- data1 %>% drop_na(column.name)  #removes rows with NA in specific column
summary(data2)  # will show summary of new data frame, including number of NA's in each column

#####   Section 2: Exploratory Data Analysis, Univariate Descriptive - Numerical   #####

summary(data1)           #for the complete data set
summary(data1$visits)    #for individual variables
describe(data1$visits)   # provides expanded statiscal summary, 5 num sum., skew, standard error, etc.
stat.desc(data1$visits)  # variance, coeff. of variation, and confidence int. for mean

#####   Section 3: Exploratory Data Analysis, Univariate Descriptive - Graphical   #####

hist(data1$visits,
     main = "Histogram of Visits",
     xlab = "Daily Visits")

boxplot(data1$visits,
        main = toupper("Boxplot of Visits"),
        ylab = "Daily Visits",
        col = "blue")

#Kernel Density Plot
d <- density(data1$visits)
plot(d, main = "Kernel density of Visits")
polygon(d, col = "red", border = "blue")

#####  This completes the univariate exploratory data analysis   #####
