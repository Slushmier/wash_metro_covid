library(tidyverse)
library(sf)
library(shiny)
library(scales)
library(leaflet)
library(leaflet.extras)
library(leaftime)
library(metricsgraphics)
library(zoo)

### Read in the data of interest
dmv_covid_ts <- st_read("https://raw.githubusercontent.com/Slushmier/wash_metro_covid/master/Data/dmv_covid_spatial_timeseries.geojson")
dmv_newest <- st_read("https://raw.githubusercontent.com/Slushmier/wash_metro_covid/master/Data/dmv_covid_newest_spatial.geojson") %>% 
  mutate_if(is.factor, ~ as.character(.x)) %>% 
  mutate(AWATERK = as.numeric(AWATERK),
         CENSUS2 = as.numeric(CENSUS2),
         Confirmed = as.numeric(Confirmed))
dmv_newest <- dmv_newest %>% 
  mutate(rate1000 = Confirmed / POPESTI * 1000,
         death1000 = Deaths / POPESTI * 1000)

### Get the unique counties list within the data 
counties_list <- dmv_newest %>% arrange(STNAME) %>%
  group_by(STNAME) %>%
  arrange(NAMELSA, .by_group = T) %>% 
  select(STNAME, NAMELSA)
st_geometry(counties_list) <- NULL

### Working on this; I would like create a proper display
# uhhuh <- list()
# for (state in unique(counties_list$STNAME)){
#   unique_counties <- dplyr::filter(counties_list, STNAME == state) 
#   unique_counties <- unique_counties$NAMELSA
#   uhhuh[[state]] <- unique_counties
#   print(unique_counties)
#   }

counties <- counties_list %>% select(-STNAME)
counties <- rbind(c("Washington Metro Area"), counties['NAMELSA'])

### Formatting for the popup information when you click on a county
### in the Leaflet map
county_popup <- paste0("<strong>Covid-19 Data by County</strong>",
                       "<br><br><strong>County: </strong>", 
                       dmv_newest$NAMELSA, 
                       "<br><strong>State: </strong>",
                       dmv_newest$STNAME,
                       "<br><strong>Date of Data: </strong>", 
                       dmv_newest$date,
                       "<br><strong>Cumulative confirmed cases (JHU): </strong>",
                       dmv_newest$Confirmed,
                       "<br><strong>Cumulative deaths (JHU): </strong>",
                       dmv_newest$Deaths,
                       "<br><strong>Confirmed cases per 1 thousand people: </strong>",
                       round(dmv_newest$rate1000, 5),
                       "<br><strong>Confirmed deaths per 1 thousand people: </strong>",
                       round(dmv_newest$death1000, 5),
                       "<br><strong>Population Estimate (Census 2018): </strong>",
                       dmv_newest$POPESTI,
                       "<br><strong>Population Density (per sq km): </strong>",
                       round(dmv_newest$pop_density, 5)
                       )

ui <- fluidPage(
  title = "Covid-19 Cases in Washington Metro Area",
  titlePanel(title = "Covid-19 Cases in Washington Metro Area"),
  
  ### Alignment for the map and the graph on the top part of the main page
  fluidRow(
    column(width = 6, leafletOutput("dmvmap")),
    column(width = 6,
           tabsetPanel(type = "tabs",
                       tabPanel("Cases Over Time", metricsgraphicsOutput('plot')),
                       tabPanel("County Case Data", tableOutput("table"),
                                style = "height: 400px; overflow-y: scroll;"
                       )
           )
    )
  ),
  
  ### Alignment for the bottom row of the web page
  fluidRow(
    column(width = 6,
           fluidRow(align = "center",
                    checkboxInput("deathMap", "Map Deaths", value = FALSE)),
           fluidRow(
             column(width = 6, p("Case data comes from",
                                 tags$a(href = "https://github.com/CSSEGISandData/COVID-19",
                                        "the Johns Hopkins University COVID-19 Github page."),
                                 " Case numbers are certainly lower than actual case numbers.")),
             column(width = 6, 
                    p(tags$a(href = "https://github.com/Slushmier/wash_metro_covid",
                             "Here is the GitHub repository for this page."))
             ) 
           )
           
    ),
    column(width = 6,
           fluidRow(align = "center",
                    column(width = 4, checkboxInput("newCases", "Graph New Cases", value = TRUE)),
                    column(width = 4, checkboxInput("avg7",
                                                    "7-day average (new cases)", value = TRUE)),
                    column(width = 4, checkboxInput("log", "Log Scale", value = FALSE))
           ),
           fluidRow(align = "center",
                    tags$head(tags$style(type = "text/css", paste0(".selectize-dropdown {
                                                     bottom: 100% !important;
                                                     top:auto!important;
                                                 }}"))),
                    selectInput("countyinput",
                                label = "County for Projections:",
                                selected = "District of Columbia",
                                choices = counties$NAMELSA)
           )
    )
  )
)

server <- function(input, output, session){
  
  ### Render the data subset for the table in the second tab of the 
  ### right portion of the app
  output$table <- renderTable({
    
    if (input$countyinput == "Washington Metro Area"){
    dataout <- dmv_covid_ts %>% 
      group_by(date) %>% 
      summarise(Confirmed = sum(Confirmed),
                  Deaths = sum(Deaths),
                  New_Confirmed = sum(New_Confirmed),
                  New_Deaths = sum(New_Deaths))
    } else {
    dataout <- dplyr::filter(dmv_covid_ts,
                            NAMELSA == input$countyinput)}
    
    st_geometry(dataout) <- NULL
    dataout <- dataout %>% 
      arrange(desc(date)) %>% 
      select(date, Confirmed,	Deaths)
    
    firstdate <- dplyr::filter(dataout,
                               Confirmed < 1 & Deaths < 1)
    dataout <- dplyr::filter(dataout, date >= max(firstdate$date))
    
    dataout$date <- as.character(dataout$date)
    dataout
  }, digits = 0)
  
  ### Create the leaflet plot in the upper left
  output$dmvmap <- renderLeaflet({
    if(input$deathMap){
      pal_map <- colorNumeric("Reds", domain = dmv_newest$death1000, n = 4)
    } else {
      pal_map <- colorQuantile("Reds", domain = dmv_newest$rate1000, n = 4)
    }
    
  mapvar <- leaflet(dmv_newest,
              sizingPolicy = leafletSizingPolicy(defaultHeight = "100%")) %>% 
      addProviderTiles(providers$CartoDB.Positron) %>% 
      setView(lat = 38.875,lng = -77.8, zoom = 8) %>% 
      addFullscreenControl()

  if(input$deathMap){
    mapvar %>% 
      addPolygons(layerId = ~NAMELSA, color = "gray", weight = 1.25,
                  smoothFactor = 0.5, opacity = 0.5, fillOpacity = 0.3, 
                  fillColor = ~colorNumeric("Reds", death1000)(death1000),
                  highlightOptions = highlightOptions(color = "red",
                                                      weight = 3,
                                                      bringToFront = T),
                  popup = county_popup,
                  label = ~paste0(NAMELSA, ": ",
                                  Deaths, " confirmed deaths."),
                  labelOptions = labelOptions(direction = "auto")) %>% 
      addLegend("bottomleft", pal = pal_map, values = ~death1000,
                title = "Confirmed Covid-19 Deaths<br>Per 1,000 People",
                opacity = 0.5)
  }
  else {
    mapvar %>%  
      addPolygons(layerId = ~NAMELSA, color = "gray", weight = 1.25,
                  smoothFactor = 0.5, opacity = 0.5, fillOpacity = 0.3, 
                  fillColor = ~colorQuantile("Reds", rate1000,
                                             n = 4)(rate1000),
                  highlightOptions = highlightOptions(color = "red",
                                                      weight = 3,
                                                      bringToFront = T),
                  popup = county_popup,
                  label = ~paste0(NAMELSA, ": ",
                                  Confirmed, " confirmed cases."),
                  labelOptions = labelOptions(direction = "auto")) %>% 
      addLegend("bottomleft", pal = pal_map, values = ~rate1000,
                title = "Confirmed Covid-19 Cases<br>Per 1,000 People",
                opacity = 0.5,
                labFormat = function(type, cuts, p) {
                  n = length(cuts)
                  p = paste0(round(p * 100), '%')
                  cuts = paste0(formatC(cuts[-n]), " - ", formatC(cuts[-1]))
                  # mouse over the legend labels to see the percentile ranges
                  paste0(
                    '<span title="', p[-n], " - ", p[-1], '">', cuts,
                    '</span>')
                }
                
      )
  }
  })
  
  ### Creates an MJS plot of cases/deaths over time in top right
  output$plot <- renderMetricsgraphics({
    if (input$countyinput == "Washington Metro Area"){
      filtered <- dmv_covid_ts
      st_geometry(filtered) <- NULL
      filtered <- filtered %>% group_by(date) %>% 
        summarise(Confirmed = sum(Confirmed),
                  Deaths = sum(Deaths),
                  New_Confirmed = sum(New_Confirmed),
                  New_Deaths = sum(New_Deaths))
    } else {
    filtered <- dplyr::filter(dmv_covid_ts,
                              NAMELSA == input$countyinput)
    }
    
    if(input$avg7 == TRUE & input$newCases == TRUE){filtered <- filtered %>% 
      mutate_at(c("Confirmed", "Deaths", "New_Confirmed", "New_Deaths"),
                ~zoo::rollmean(., k = 7, fill = NA))}
    
    ### Get parameters to inform the date range of the below mjs plot
    firstdate <- dplyr::filter(filtered, Confirmed < 1 & Deaths < 1)
    filtered <- dplyr::filter(filtered,
                              date >= max(firstdate$date) - 2)
    rm(firstdate)
    
    ### Format plot if mjs graphic is for new cases
    if(input$newCases){
      filtered %>% 
        mjs_plot(x = date, y = New_Confirmed, right = 50) %>% 
        mjs_axis_x(xax_format = "date") %>% 
        mjs_axis_y(y_scale_type = ifelse(input$log == TRUE, "log", "linear")) %>% 
        mjs_add_line(New_Deaths) %>% 
        mjs_labs(x = "Date", y = "Confirmed Covid-19 Cases") %>% 
        mjs_add_legend(c("New Cases", "New Deaths"),
                       inline = TRUE)
    } else {
    ### Modify scale if mjs plot is not for new cases
    filtered %>% 
      mjs_plot(x = date, y = Confirmed, right = 40) %>% 
      mjs_axis_x(xax_format = "date") %>% 
      mjs_axis_y(y_scale_type = ifelse(input$log == TRUE, "log", "linear")) %>% 
      mjs_add_line(Deaths) %>% 
      mjs_labs(x = "Date", y = "Confirmed Covid-19 Cases") %>% 
      mjs_add_legend(c("Cases", "Deaths"),
                     inline = TRUE)}
    })
  
  ### Change graph and table to be county clicked on map
  observeEvent(input$dmvmap_shape_click, {
    p <- input$dmvmap_shape_click$id
    updateSelectInput(session, "countyinput",
                      label = NULL,
                      choices = NULL,
                      selected = p)
  })
}

shinyApp(ui, server)