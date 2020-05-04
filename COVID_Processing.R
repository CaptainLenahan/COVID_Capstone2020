install.packages("readxl")
install.packages("dplyr")
install.packages("stringr")
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
#Removes NA values from COVID.Data based off the last column "Testing Results".
Overlake.Clean <- !is.na(COVID.Data$`Last Lab Results`)
#Store the non NA Values afterusing the which functon to remove all FALSE (NA) Values
#grabs all columns with this matching criteria (no NA values in last column of each row)
Overlake.Clean <- COVID.Data[which(Overlake.Clean == TRUE), ]


#converts results to lowercase letters to prevent from data errors/incorrect boolean values
Results <- tolower(Overlake.Clean$`Last Lab Results`)

#mask for non-detected. TRUE = Covid was NOT detected, FALSE means COVID detected.
#pending better fix for last few rows with old sars2 test
SearchVar1 <- "no"
COVID_PRESENCE <- str_detect(Results, SearchVar1)
#replaces last testing column with boolean values for presence of COVID-19
Overlake.Clean$`Last Lab Results` <- COVID_PRESENCE





# ============================= Age column cleanup ================================================================
Overlake.Age <- tolower(Overlake.Clean$Age)

Overlake.Age <- str_replace_all(Overlake.Age, "y.o.", "")
#Overlake.Age <- str_replace_all(Overlake.Age, "m.o.", "") # m.o. NOT the same as Y.O. use mask for MO and use maths

#attempting to grab all columns that have an age indicated by "deceased" string/number value


#mask for establishing which rows say deceased and setting them to boolean values. attempting to create
#separate table to work with these values, remove "deceased" and have a table designated for deceased patients
SearchVar2 <- "deceased"
COVID_DECEASED <- str_detect(Overlake.Age, SearchVar2)

#creates new column name "Deceased" for the deceased. TRUE = Deceased. FALSE= Survived
Overlake.Clean["Deceased"] <- COVID_DECEASED

#TO DO: create equation to replace possible m.o. values with a fraction number here as
#problem: ages have NA values & m.o. patients are not configured yet
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




#Exports to a csv file for ease of use in Excel/Tableau with the cleaned overlake data.
write.csv(Overlake.Clean, file = "CleanOverlakeData.csv")
