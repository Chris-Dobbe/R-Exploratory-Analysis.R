#####################################################################

#Title: R Script Template, a base script to begin any R project

#Author: Chris

#Project Name:

######################################################################

#Set working directory
setwd("C:/Users/*******/*******/R Files")

#Load the packages and libraries, or d/l any using install.packages("???")
library(dplyr)
library(magrittr)
library(tidyr)
library(readr)
library(stringr)
library(ggplot2)
library(gridExtra)
library(DescTools)
library(RDCOMClient)  ## for importing specific cells from an Excel file
library(gdata)  ##for importing entire xls files
library(fBasics)

#Read the exact CSV file OR select the file that you are going to use
data1 <- file.choose() # Allows for manual selection from folder location, paired with below
  data <- read_csv(data1)  
#data1 <- read_csv("file_name.csv") #loads in the CSV to a tibble, easier to work with
#data1 <- read.csv("file_name.tsv", sep = "\t", header = TRUE)
#data1 <- read.xls("file_name.xlsx")
#data1 <- XLGetRange(sheet = "sheet1", range = "A1:B21", header = TRUE) #only used when Excel workbook is open


#Open the data view
View(data1)

#Basic summary functions to understand the data
names(data1)
head(data1)
str(data1)
summary(data1)

#Basic statistics on numerical data providing summary and visuals using RDCOMCLIENT library
options(scipen=10)
options(fmt.abs=structure(list(digits=0, big.mark=","), class="fmt"))
Desc(data1$ratio, plotit = TRUE)

#histogram (1 var) or scatter plot (2+ var) using ggplot2 for visualization of data
qplot(x = data1$ratio, binwidth = 0.25, color = I("black"))          # 1 var histogram
qplot(x = data1$sessions, y = data1$ratio, color = I("Black"))  # 2 var scatter plot
