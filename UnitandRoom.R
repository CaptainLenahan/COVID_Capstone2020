#============================== Beginning of Test Location Cleanup =================================================
#In progress 5-5-20

#works
pats2 <- "0|1|2|3|4|5|6|7|8|9| "
patEast <- "ee"
patWest <- "ww"
patSouth <- "ss"
patED <- "eds"
patPsych <- "psye"

Overlake.Clean$Unit.and.Room <- stringWiz(Overlake.Clean, "Unit.and.Room", "OHMC", "")
Overlake.Clean$Unit.and.Room <- stringWiz(Overlake.Clean, "Unit.and.Room", pats2, "")
Overlake.Clean$Unit.and.Room <- stringWiz(Overlake.Clean,"Unit.and.Room", patEast, "east")
Overlake.Clean$Unit.and.Room <- stringWiz(Overlake.Clean, "Unit.and.Room", patWest,  "west")
Overlake.Clean$Unit.and.Room <- stringWiz(Overlake.Clean,"Unit.and.Room", patSouth, "south")
Overlake.Clean$Unit.and.Room <- stringWiz(Overlake.Clean,"Unit.and.Room", patED, "ed")
Overlake.Clean$Unit.and.Room <- stringWiz(Overlake.Clean,"Unit.and.Room", patPsych, "psych east")
