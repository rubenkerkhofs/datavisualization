

library(shiny)
library(hrbrthemes)
library(GGally)
library(viridis)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Visualization Research Question 1"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput(inputId = "Genre",
                        label = "Select the genre you want to display",
                        choices = c("All Genres", "Rap", "Rock", "R&B", "Latin", "Pop", "Edm"),
            ),
            helpText("Select the decades you want to have displayed"),
            checkboxInput("d1970", "1970", value = F),
            checkboxInput("d1980", "1980", value = F),
            checkboxInput("d1990", "1990", value = F),
            checkboxInput("d2000", "2000", value = F),
            checkboxInput("d2010", "2010", value = T)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    songData <- readRDS("songData.rds")
    songData %>%
      separate(track_album_release_date, c("track_album_release_year", "track_album_release_month", "track_album_release_day"), sep = "-") %>%
      mutate(track_album_release_year = as.numeric(track_album_release_year),
             track_album_release_month = as.numeric(track_album_release_month),
             track_album_release_day = as.numeric(track_album_release_day),
             duration = round(duration_ms/1000),
             decade = track_album_release_year - (track_album_release_year%%10)) %>%
      filter(decade > 1965 & decade < 2015)-> songData
    groups = 5

    output$distPlot <- renderPlot({
      if (input$Genre == "All Genres") {
        songData -> songDataSelectedGenre
      } else if (input$Genre == "Rap") {
        songData %>%
          filter(playlist_genre == "rap") -> songDataSelectedGenre
      } else if(input$Genre == "Rock") {
        songData %>%
          filter(playlist_genre == "rock") -> songDataSelectedGenre
      } else if(input$Genre == "Latin") {
        songData %>%
          filter(playlist_genre == "latin") -> songDataSelectedGenre
      } else if(input$Genre == "R&B") {
        songData %>%
          filter(playlist_genre == "r&b") -> songDataSelectedGenre
      } else if(input$Genre == "Pop") {
        songData %>%
          filter(playlist_genre == "pop") -> songDataSelectedGenre
      } else {
          songData %>%
            filter(playlist_genre == "edm") -> songDataSelectedGenre
      }
      colours = c( "#DAF875", "#70DF9C", "#648CAE",  "#7F5E80",  "#723B46")
      if(!input$d1970) {
          colours[1] = NA
          groups = groups - 1
      }
      if(!input$d1980) {
        colours[2] = NA
        groups = groups - 1
      }
      if(!input$d1990) {
        colours[3] = NA
        groups = groups - 1
      }
      if(!input$d2000) {
        colours[4] = NA
        groups = groups - 1
      }
      if(!input$d2010) {
        colours[5] = NA
        groups = groups - 1
      }
      
  
      
      
      characteristics <- songDataSelectedGenre %>%
        mutate(decade = factor(decade)) %>%
        group_by(decade, playlist_genre) %>%
        summarise(Danceability = mean(danceability),
                  Energy = mean(energy),
                  Key = mean(key),
                  Loudness = mean(loudness),
                  Speechiness = mean(speechiness),
                  Acousticness = mean(acousticness),
                  Instrumentalness = mean(instrumentalness),
                  Liveness = mean(liveness),
                  Valence = mean(valence),
                  Tempo = mean(tempo),
                  Count = n()) %>%
        mutate(key = paste(playlist_genre, decade, sep = "-"))
      
      
        ggparcoord(characteristics,
                   columns = 3:12, groupColumn = 1, order = "anyClass",
                   showPoints = TRUE, 
                   title = "Parallel Coordinate Plot for the Iris Data",
                   alphaLines = max(1 - (groups/6), 0.5),
                   scale = "uniminmax"
        ) + 
          scale_color_manual(values= colours) +
          theme_ipsum()+
          theme(
            plot.title = element_text(size=10)
          )
      
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
