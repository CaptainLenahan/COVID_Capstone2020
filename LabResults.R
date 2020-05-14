#Lab Results Column Cleanup!

SearchVar1 <- "no"
SearchVar2 <- "TRUE"
SearchVar3 <- "FALSE"


#Removes NA values from COVID.Data based off the last column "Testing Results".
Testing_Results <- !is.na(COVID.Data$`Last Lab Results`)
#Store the non NA Values afterusing the which functon to remove all FALSE (NA) Values
#grabs all columns with this matching criteria (no NA values in last column of each row)
Overlake.Clean <- COVID.Data[which(Testing_Results == TRUE), ]

#converts results to lowercase letters
Results <- tolower(Overlake.Clean$`Last Lab Results`)

#mask for non-detected. TRUE = Covid was NOT detected, FALSE means COVID detected.
#replaces last testing column with boolean values for presence of COVID-19
Overlake.Clean$`Last Lab Results` <- str_detect(Results, SearchVar1)



#Converts lab results column to strings and 
Lab_Result_Strings <- toString(Overlake.Clean$`Last Lab Results`)
Lab_Result_Strings <- str_replace_all(Overlake.Clean$`Last Lab Results`, SearchVar2, "Negative")
Lab_Result_Strings <- str_replace_all(Lab_Result_Strings, SearchVar3, "Positive")
Overlake.Clean["Test Results"] <- Lab_Result_Strings
Overlake.Clean$`Last Lab Results` <- NULL