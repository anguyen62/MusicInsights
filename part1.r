## ------------------------------------------------------------------------
include <- function(library_name){
  if( !(library_name %in% installed.packages()) )
    suppressMessages(install.packages(library_name))
  library(library_name, character.only=TRUE)
}
include("tidyverse")
include("dplyr")

Survey <- read_csv("https://raw.githubusercontent.com/introdsci/MusicSurvey/master/music-survey.csv")
Preferences <- read_csv("https://raw.githubusercontent.com/introdsci/MusicSurvey/master/preferences-survey.csv")


## ------------------------------------------------------------------------
colnames(Survey)[1] <- "Time_Submitted"
colnames(Survey)[2] <- "Pseudonym_Generation"
colnames(Survey)[3] <- "Pseudonym"
colnames(Survey)[4] <- "Sex"
colnames(Survey)[5] <- "Major"
colnames(Survey)[6] <- "Academic_Year"
colnames(Survey)[7] <- "Year_Born"
colnames(Survey)[8] <- "Instrument"
colnames(Survey)[9] <- "Artist"
colnames(Survey)[10] <- "Song"
colnames(Survey)[11] <- "Link"


## ------------------------------------------------------------------------
#Person <- Survey[,c(3,4,6,7,8)]
Person <- tibble(
  Time_Submitted=Survey$Time_Submitted, 
  Pseudonym_Generation=Survey$Pseudonym_Generation, 
  Pseudonym=Survey$Pseudonym, 
  Sex=Survey$Sex, 
  Major=Survey$Major, 
  Academic_Year=Survey$Academic_Year, 
  Year_Born=Survey$Year_Born
)


## ------------------------------------------------------------------------
Favorite_Song <- tibble(
  Artist=Survey$Artist, 
  Song=Survey$Song, 
  Link=Survey$Link
)


## ------------------------------------------------------------------------
Survey$Time_submitted <- as.POSIXlt(parse_datetime(Survey$Time_Submitted, format="%m/%d/%y %H:%M"))

Person$Time_submitted <- as.POSIXlt(parse_datetime(Person$Time_Submitted, format="%m/%d/%y %H:%M"))

Person$Major <- as.factor(Person$Major)
Person$Academic_Year <- as.factor(Person$Academic_Year)
Person$Sex <- as.factor(Person$Sex)

levels(Person$Major)[levels(Person$Major) == "Computer information systems"] <- "Computer Information Systems"


## ------------------------------------------------------------------------
Ratings <- gather(Preferences, key="Song", value="Rating", 3:45)
colnames(Ratings)[1] <- "Time_Submitted"
colnames(Ratings)[2] <- "Pseudonym"
Ratings$Time_Submitted <- NULL

plot <- ggplot(Ratings, aes(x=pseudonym, y=rating)) + geom_boxplot() + coord_flip()

