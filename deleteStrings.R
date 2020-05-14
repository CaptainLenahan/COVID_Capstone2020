#A function that can be called to search and remove strings. Set searchVar to what string
#you want removed, the columnInput to search, and the Data_Frame being worked with!

deleteSrings <- function(columnInput, searchVar, Data_Frame) {
  Data_Frame[[columnInput]] <- tolower(Data_Frame[[columnInput]]) # turns all values of columnInput column to lowercase
  
  Data_Frame[, columnInput] <- str_replace_all(Data_Frame[[columnInput]], searchVar, "")
  
  return(Data_Frame[, columnInput])
}
#Example Call
#x <- deleteSrings("Age", "y.o.", Overlake.Clean)
