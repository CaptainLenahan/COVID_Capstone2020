#install.packages("dplyr")
#install.packages("stringr")
#install.packages("xlsx")
#install.packages("lubridate")
library(dplyr)
library(stringr)
library(xlsx)
#library(lubridate)

#This Program Reads in the supplied excel sheet from Overlake Hospital 
#and stores in COVID.Data variable for cleaning. Upon completion, it outputs
#a new excel file with cleaned columns for visualization purposes.
 
# Displays a pop-up file explorer window to choose the desired excel file from Overlake.
COVID.Data <- read.xlsx(file.choose(), 1)  # reads first sheet

#Removes NA values from COVID.Data based off the last column "Testing Results".
#Store the non NA Values afterusing the which functon to remove all FALSE (NA) Values
#grabs all columns with this matching criteria (no NA values in last column of each row)
Overlake.Clean <- COVID.Data[which(!is.na(COVID.Data$Last.Lab.Results) == TRUE), ]

source("stringWiz.R") #The function used for column clean-up
source("LabResults.R") #Cleans Lab.Results Column
source("Age.R") #Cleans Age Column
source("UnitandRoom.R") #Cleans Unit.and.Room Column
source("InpatientLOS.R")

#Exports to a new excel file for ease of use in Excel/Tableau with the cleaned overlake data. Last step

write.xlsx(Overlake.Clean, "CleanOverlakeData.xlsx")