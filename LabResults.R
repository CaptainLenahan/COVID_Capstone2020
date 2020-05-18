#================Lab Results Column Cleanup!=====================================================

#converts results to lowercase letters
Results <- tolower(Overlake.Clean$Last.Lab.Results)

#mask for non-detected. TRUE = Covid was NOT detected, FALSE means COVID detected.
#replaces last testing column with boolean values for presence of COVID-19
Overlake.Clean$Last.Lab.Results <- str_detect(Results, "no")


#Converts lab results column to strings and 
Overlake.Clean$Last.Lab.Results <- stringWiz(Overlake.Clean, "Last.Lab.Results", "TRUE", "Negative")
Overlake.Clean$Last.Lab.Results <- stringWiz(Overlake.Clean, "Last.Lab.Results", "FALSE", "Positive")


