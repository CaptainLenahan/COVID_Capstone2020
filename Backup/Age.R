# ============================= Age column cleanup ======================================================

SearchDec<- "deceased|Deceased"
#Pats are string patterns to identify and remove additional characters inside the "Age" column
pats <- "deceased|y.o.|\\)|\\(" # consider removing spaces?
#creates new column name "Deceased" for the deceased. TRUE = Deceased. FALSE= Survived
Overlake.Clean["Deceased"] <- str_detect(Overlake.Clean$Age, SearchDec)

Overlake.Clean$Age <- stringWiz(Overlake.Clean, "Age", pats, "")

searchMO <- "m.o.|M.O."
ColName <- "Age"
babies <- str_detect(Overlake.Clean$Age, searchMO)
Overlake.Clean$Age <- stringWiz(Overlake.Clean, ColName, searchMO, "")
numericRows <- as.numeric(unlist(Overlake.Clean[babies, ColName]))
Overlake.Clean[babies, ColName] <- format(round((numericRows / 12), 2), nsmall = 2)
Overlake.Clean$Age <- Overlake.Clean[,ColName]

#Applies a mask searchin and creates the deceased table
Overlake.Deceased <- Overlake.Clean[Overlake.Clean$Deceased == TRUE, ]

#Eliminate deceased column as column is redundant
Overlake.Deceased$Deceased <- NULL