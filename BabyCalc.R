## ========== Function for month old patients =============
# Accepts an Age integer from the age cleanup section. this function resolves the issue of patient
#ages that are listed in m.o. (months old) and turns them into a fraction for use in data visualizaiton.

Baby.Age.Calc <- function(AgeInput) {
  Age.Fraction <- format(round((AgeInput / 12), 2), nsmall = 2)
  as.double(Age.Fraction)
  return(Age.Fraction)
Baby.Age.Calc <- function(DFInput) {
  searchMO <- "m.o.|M.O."
  ColName <- "Age"
  babies <- str_detect(DFInput[[ColName]], searchMO)
  DFInput[,ColName] <- deleteSrings( ColName, searchMO, DFInput)
  numericRows <- as.numeric(unlist(DFInput[babies, ColName]))
  DFInput[babies,ColName] <- format(round((numericRows / 12), 2), nsmall = 2)
  DFInput <- DFInput[,ColName]
  return(DFInput[,ColName]) #returns df with fraction of babies
}

# example call:  x <- Baby.Age.Calc(Overlake.Clean)
