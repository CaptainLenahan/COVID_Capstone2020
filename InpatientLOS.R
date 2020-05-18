#This is for calculating length of stay and creating a column for the values returned -Kara Jung

#Inpatient vs. Outpatient

Inpatient.Data <- filter(Overlake.Clean, Overlake.Clean$Account.Class == "Inpatient [101]")
Emergency <- filter(Overlake.Clean, Overlake.Clean$Account.Class == "Emergency [103]")
Observation <- filter(Overlake.Clean, Overlake.Clean$Account.Class == "Observation [104]")
Outpatient <- filter(Overlake.Clean, Overlake.Clean$Account.Class == "Outpatient [102]")                      
OutpatientSurgery <- filter(Overlake.Clean, Overlake.Clean$Account.Class == "SDC/23 Hour Outpatient Surgery [123]")
Outpatient.Data <- rbind(Observation, Outpatient, OutpatientSurgery, Emergency)


#Discharge Date into Current Date


day <- "05/17/2020"
Inpatient.Data$Discharge.Date <- as.Date(Inpatient.Data$Discharge.Date)
Inpatient.Data$Discharge.Date[is.na(Inpatient.Data$Discharge.Date)] <- day

#Calculating Length of Stay
survey <- data.frame(date=c(Inpatient.Data$Discharge.Date),tx_start=c(Inpatient.Data$Admsn.Date))
survey$date_diff <- as.Date(as.character(survey$date), format="%m/%d/%y")- as.Date(as.character(survey$tx_start), format="%m/%d/%y")
survey
Inpatient.Data <- mutate(Inpatient.Data, Length_Stay = survey$date_diff)