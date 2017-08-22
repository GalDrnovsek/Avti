library(shiny)
library(dplyr)
library(RPostgreSQL)
library(datasets)

team <- c("Chelsea","Tottenham Hotspur","Mancteahester City","Liverpool","Arsenal",
          "Manchester United","Everton","Southampton","AFC Bournemouth","West Bromwich Albion","West Ham United",
          "Leicester City","Stoke City","Crystal Palace","Swansea City","Burnley","Watford","Hull City",
          "Middlesbrough","Sunderland")
team <- sort(team)
position <- c("Vratar","Branilec","Sredina","Napadalec")


shinyUI(
  ui <- fluidPage(
    
    titlePanel("Primerjava dveh ekip v Premier Ligi"),
    sidebarLayout(
      sidebarPanel(
        selectInput(inputId = "ekipa1",label = "Izberi prvo ekipo",choices = team,selected = NULL),
        selectInput(inputId = "ekipa2",label = "Izberi drugo ekipo", choices =team,selected = NULL),
        checkboxGroupInput(inputId = "pozicija",label="Pozicija igralcev",choices = position),
        dateInput(inputId="zacetek", label= "Odigrane tekme od",format="dd.mm.yyyy",value = "1.1.2017"),
        dateInput(inputId="konec",label= "do vključno",format="dd.mm.yyyy", value="7.7.2017")
        
      ),
      mainPanel(
        h1("Osnove informacije"),
        splitLayout(
          
          textOutput("ime1"),textOutput("ime2")),
        splitLayout(
          textOutput("mesto1"),textOutput("mesto2")),
        splitLayout(
          textOutput("stadion1"),textOutput("stadion2")),
        splitLayout(
          textOutput("manager1"),textOutput("manager2")),
        h1("Seznam igralcev"),
        splitLayout(
          dataTableOutput(outputId = "tabela1"),
          dataTableOutput(outputId = "tabela2")),
        h1("Odigrane tekme"),
        splitLayout(
          dataTableOutput(outputId="tekma1"),
          dataTableOutput(outputId="tekma2"))
      )
    )
  )
)

