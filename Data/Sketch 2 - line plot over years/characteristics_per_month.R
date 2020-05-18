library(dplyr)
library(tidyr)
options(scipen = 999)


# ----------------
# Loading the data
# ----------------
songData <- readRDS("songData.rds")

# ----------------
# Data engineering
# ----------------
songData %>%
  separate(track_album_release_date, c("track_album_release_year", "track_album_release_month", "track_album_release_day"), sep = "-") %>%
  mutate(track_album_release_year = as.numeric(track_album_release_year),
         track_album_release_month = as.numeric(track_album_release_month),
         track_album_release_day = as.numeric(track_album_release_day),
         duration = round(duration_ms/1000),
         decade = track_album_release_year - (track_album_release_year%%10)) -> songData

songData %>%
  mutate(season = ifelse(track_album_release_month == 1 | track_album_release_month == 2, "Winter",
                  ifelse(track_album_release_month == 3 & track_album_release_day < 21, "Winter",
                  ifelse(track_album_release_month == 3 | track_album_release_month == 4 | track_album_release_month == 5, "Spring", 
                  ifelse(track_album_release_month == 6 & track_album_release_day < 21, "Spring",
                  ifelse(track_album_release_month == 6 | track_album_release_month == 7 | track_album_release_month == 8, "Summer",
                  ifelse(track_album_release_month == 9 & track_album_release_day < 21, "Summer", "Fall"))))))) -> songData

songData %>%
  group_by(track_album_release_month) %>%
  summarise("Danceability" = sum(danceability)/n(),
            "Energy" = sum(energy)/n(),
            "Key" = sum(key)/n(),
            "Loudness" = sum(loudness)/n(),
            "Mode" = sum(mode)/ n(),
            "Speechiness" = sum(speechiness)/ n(),
            "Acousticness" = sum(acousticness)/n(),
            "Instrumentalness" = sum(instrumentalness)/n(),
            "Liveness" = sum(liveness)/n(),
            "Valence" = sum(valence)/n(),
            "Tempo" = sum(tempo)/n(),
            "Duration" = sum(duration)/n()) %>%
  filter(!is.na(track_album_release_month)) -> songData



songData %>%
  gather(key = "Characteristic", value = "Value", Danceability, Energy, Key, Loudness, Mode, Speechiness, Acousticness, Instrumentalness, Liveness, Valence, Tempo, Duration) %>%
  mutate(x = track_album_release_month,
         y = Value,
         c = Characteristic) %>%
  select(x, y, c) -> temp


library(RJSONIO)
export =jsonlite::toJSON(temp)
write(export, "characteristics_per_month.json")
write.csv(temp, "characteristics_per_month.csv")
