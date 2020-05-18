#install.packages("readxl")
#install.packages("dplyr")
#install.packages("stringr")
library(dplyr)
library(stringr)
library(readxl)

#Reads in the supplied excel sheet from Overlake Hospital 
#and stores in COVID.Data variable.
#TO DO: Replace this string variable with most recent excel 
#name and specify directory path if necessary

Overlake.Data <- "3-1-20 to 4-17-20 UW Analysis.xlsx"
COVID.Data <- read_excel(Overlake.Data)
#Removes NA values from COVID.Data based off the last column "Testing Results".
Testing_Results <- !is.na(COVID.Data$`Last Lab Results`)
#Store the non NA Values afterusing the which functon to remove all FALSE (NA) Values
#grabs all columns with this matching criteria (no NA values in last column of each row)
Overlake.Clean <- COVID.Data[which(Testing_Results == TRUE), ]
source("BabyCalc.R")
source("stringWiz.R")
source("LabResults.R")
source("Age.R")
source("UnitandRoom.R")


#Exports to a csv file for ease of use in Excel/Tableau with the cleaned overlake data. Last step
write.csv(Overlake.Clean, file = "CleanOverlakeData.csv")
