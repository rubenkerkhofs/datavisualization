# Data visualization
This repository contains the JSON datafiles and code that were mode for the course *Data visualization in data science* of the KU Leuven.

## Topic
For this project we will be exploring three different research questions:

- How did the different song characteristics evolve over time?

- How does music vary over the four different seasons? and

- How do new music genres come into existence and fade away?

In order to answer these wicked questions a spotify dataset is used to create visualizations. This dataset contains a total of 755 000+ data points. The dataset contains information on roughly 33 000 songs that are published on Spotify. For all of these songs the dataset contains a title, the album the song belongs to, the release date, the artist, the genre and a bunch of music characteristics like duration, tempo, instrumentalness etc. A more thorough description of these music characteristics can be found here: https://developer.spotify.com/documentation/web-api/reference/tracks/get-audio-features/.

## Sketches
The following sketches were made to answer these research questions:

### Sketch 1
 <img src="https://miro.medium.com/max/875/1*MqmdlWBZ97Ph7aHS82AFJg.jpeg" alt="Sketch 1" class="center" height="400" width="400">
 
 An initial design combines two kinds of plots in an interactive way, providing an insight into both the first and third research questions. The bottom half of the plot shows how relatively popular the different music genres have been throughout the decades. This gives a partial answer to the third research question: it helps to see in what period a particular genre was most important and how it relates to other genres.

Clicking on one of the music genres’ individual rectangles subsequently causes the top plot to open, showing the make-up of that specific genre in that decade. The make-up of a genre can hence be studied through its average song characteristics.

In the implementation of this design we have a few additional considerations. A feature that is not visible in the bottom half of the visualization, is that the size of each decade’s square could reflect the total amount of songs for that decade in our dataset. We might add this once we start implementing the design.

A second consideration is that the radar chart might be replaced by an alternative. As noted by Yan Holtz, the radar chart has a couple of problems. Beyond his general considerations on the radar chart, we also would like to show as much detail as possible, graphing individual data points instead of averages per decade per genre. Therefore Holtz’ suggestion of the ‘parallel coordinate plot’ might be used.

### Sketch 2
 <img src="https://miro.medium.com/max/756/1*PNG3qVpfbtngguqwbe162g.png" alt="Sketch 2" class="center" height="400" width="400">
 
The second design is a first effort to show how the music in our dataset changes both over time in general (top half) and per season per decade (bottom half). The temporal variable is again based upon the date specific songs came out.

The general idea of this visualization is that the top half can be played automatically as the arrow race through the seasons and the years. The development of the different song characteristics can hence be followed ‘live’; the x-axis here spans one year. The bottom half, meanwhile, provides insight in the average development of at least one song characteristic per season per decade. With the vertical marker one can follow how the situation in a particular year differs from the average of that decade.

The chart might lead to conclusions about differences between the seasons when it comes to musical production, whether that is in an individual year, or on average per decade.

### Sketch 3
 <img src="https://miro.medium.com/max/898/1*DcM_GCHm-55kOvY2zwa6Mg.png" alt="Sketch 3" class="center" height="400" width="400">
 
 A third design is a static alternative to answer the question of song characteristics per season or per month. For every month, per genre, there is an additional notch per song or album added to the genre’s ring. Tweaking different aspects of the design, such as colour, these circular notches might make the design look like a CD or a vinyl disc.

Although there are many benefits to the amount of detail that can be provided in the interactive and animated design II, the current CD-like static chart may lead to alternative conclusions, especially because it can provide an overview of the entire dataset at once instead of focusing on different decades.

## Implementation
The different sketches shown above have been implemented using vega or vega lite. The code of these sketches and an example image can be found in this repository as well.

### Sketch 1 - Implementation
[Tree plot implementation](https://raw.githubusercontent.com/rubenkerkhofs/datavisualization/master/Plots/Tree%20plot/Tree%20plot.PNG) - [Code](https://raw.githubusercontent.com/rubenkerkhofs/datavisualization/master/Plots/Tree%20plot/code.txt) - [gist](https://gist.github.com/rubenkerkhofs/0623829646a24c3e455ba31625560598)

[Parallel coordinates plot implementation](https://raw.githubusercontent.com/rubenkerkhofs/datavisualization/master/Plots/Parallel%20coordinates%20plot/Parallel%20coordinates%20plot%20-%20vega.PNG) - [code](https://raw.githubusercontent.com/rubenkerkhofs/datavisualization/master/Plots/Parallel%20coordinates%20plot/code-vega.txt) - [gist](https://gist.github.com/rubenkerkhofs/4d1b8337ea0fe31ca0f5407654918321)

  
 ### Sketch 2 - Implementation
 
 [Line plot over years implementation](https://raw.githubusercontent.com/rubenkerkhofs/datavisualization/master/Plots/Line%20plot%20over%20years/plot.PNG) - [code](https://raw.githubusercontent.com/rubenkerkhofs/datavisualization/master/Plots/Line%20plot%20over%20years/code.txt) - [gist](https://gist.github.com/rubenkerkhofs/bd03982f456d88327672535869b9b757)
 
 [Line plot over months implementation](https://raw.githubusercontent.com/rubenkerkhofs/datavisualization/master/Plots/Lineplot%20over%20months/plot%20after%20editing.jpeg) - [code](https://raw.githubusercontent.com/rubenkerkhofs/datavisualization/master/Plots/Lineplot%20over%20months/code.txt) - [gist](https://gist.github.com/rubenkerkhofs/465ab4c5dd873f3bb7752a03d096618f)
 
  
  ### Sketch 2 - additional implementation
  
  [Github style plot](https://raw.githubusercontent.com/rubenkerkhofs/datavisualization/master/Plots/Additional%20plot%20-%20github%20style/Implementation.PNG) - [code](https://raw.githubusercontent.com/rubenkerkhofs/datavisualization/master/Plots/Additional%20plot%20-%20github%20style/code.txt) - [gist](https://gist.github.com/rubenkerkhofs/9f5d816f38616c024dbeafb80995c081)
  
  
 ### Sketch 3 - Implementation
 [CD plot](https://github.com/rubenkerkhofs/datavisualization/blob/master/Plots/CD%20chart/plot.PNG?raw=true) - [code](https://raw.githubusercontent.com/rubenkerkhofs/datavisualization/master/Plots/CD%20chart/CD_Chart) - [gist](https://gist.github.com/rubenkerkhofs/c8959d7e496cda6903c6c89bdbd26050)
