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

#=============================Lab_Results Clean-up =================================================================
# TO DO: 1. pending better fix for last few rows with old sars2 test
# 2. apply different titles to apprioriate testing facilities (sars2 tests at outside clinics)

SearchVar1 <- "no"
SearchVar2 <- "TRUE"
SearchVar3 <- "FALSE"


#Removes NA values from COVID.Data based off the last column "Testing Results".
Overlake.Clean <- !is.na(COVID.Data$`Last Lab Results`)
#Store the non NA Values afterusing the which functon to remove all FALSE (NA) Values
#grabs all columns with this matching criteria (no NA values in last column of each row)
Overlake.Clean <- COVID.Data[which(Testing_Results == TRUE), ]

#converts results to lowercase letters
Results <- tolower(Overlake.Clean$`Last Lab Results`)

#mask for non-detected. TRUE = Covid was NOT detected, FALSE means COVID detected.
#replaces last testing column with boolean values for presence of COVID-19
COVID_PRESENCE <- str_detect(Results, SearchVar1)
Overlake.Clean$`Last Lab Results` <- COVID_PRESENCE

#Converts lab results column to strings and 
Lab_Result_Strings <- toString(Overlake.Clean$`Last Lab Results`)
Lab_Result_Strings <- str_replace_all(Overlake.Clean$`Last Lab Results`, SearchVar2, "Negative")
Lab_Result_Strings <- str_replace_all(Lab_Result_Strings, SearchVar3, "Positive")
Overlake.Clean["Test Results"] <- Lab_Result_Strings
Overlake.Clean$`Last Lab Results` <- NULL


# ============================= Age column cleanup ================================================================
#TO DO: create function to replace possible m.o. values with a fraction number here as
#problem: ages have NA values & m.o. patients are not configured yet

SearchVar4 <- "deceased|Deceased"
Overlake.Age <- tolower(Overlake.Clean$Age)

#mask for establishing which rows say deceased and setting them to boolean values. attempting to create
#separate table to work with these values, remove "deceased" and have a table designated for deceased patients

COVID_DECEASED <- str_detect(Overlake.Age, SearchVar4)

#creates new column name "Deceased" for the deceased. TRUE = Deceased. FALSE= Survived
Overlake.Clean["Deceased"] <- COVID_DECEASED

#Pats are string patterns to identify and remove additional characters inside the "Age" column
pats <- "deceased|y.o.|\\)|\\("
#Applies a mask searchin
Overlake.Deceased <- Overlake.Clean[Overlake.Clean$Deceased == TRUE, ]
Overlake.Deceased$Age <-  tolower(Overlake.Deceased$Age)
Overlake.Deceased$Age <- str_replace_all(Overlake.Deceased$Age, pats, "")
#set age column to integer variable
Overlake.Deceased$Age <- as.integer(Overlake.Deceased$Age)
#Eliminate deceased column as column is redundant
Overlake.Deceased$Deceased <- NULL

#============================== Beginning of Test Location Cleanup =================================================
#In progress 5-5-20

Overlake.Clean$`Unit and Room` <- tolower(Overlake.Clean$`Unit and Room`)
Overlake.Clean$`Unit and Room` <- str_replace_all(Overlake.Clean$`Unit and Room`, "OHMC", "")

Overlake.Clean$`Unit and Room` <- str_replace_all(Overlake.Clean$`Unit and Room`, "OHMC", "")


#Exports to a csv file for ease of use in Excel/Tableau with the cleaned overlake data. Last step
write.csv(Overlake.Clean, file = "CleanOverlakeData.csv")
