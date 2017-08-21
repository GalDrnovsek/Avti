library(shiny)
library(dplyr)
library(RPostgreSQL)
library(datasets)

source("auth_public.r", encoding="UTF-8")
source("uvoz/uvoz.r", encoding="UTF-8")


shinyServer(
  server <- function(input, output){
    
    # Vzpostavimo povezavo
    conn <- src_postgres(dbname = db, host = host,
                         user = user, password = password)
    
    
    tbl.ekipa <- tbl(conn, "tabelaekipa")
    tbl.igralcev <- tbl(conn, "tabelaigralcev")
    tbl.tekma <- tbl(conn, "tabelatekma")
    tbl.vodstvo <- tbl(conn, "tabelavodstvo")
    
    
    output$ime1 <- renderText({c(paste0("Ime ekipe: ", input$ekipa1))})
    output$mesto1 <- renderText({paste0("Mesto: ",as.character(tbl.ekipa %>% filter(ekipa %in% input$ekipa1)%>% select(mesto)))})
    output$stadion1 <- renderText({paste0("Stadion in kapaciteta: ", as.character(tbl.ekipa %>% filter(ekipa %in% input$ekipa1)%>% select(stadion)),", ",as.character(tbl.ekipa %>% filter(ekipa %in% input$ekipa1)%>% select(kapaciteta)) )})
    output$manager1 <- renderText({paste0("Manager: ",as.character(tbl.vodstvo %>% filter(ekipa %in% input$ekipa1)%>% select(manager)))})
    
    output$ime2 <- renderText({c(paste0("Ime ekipe: ", input$ekipa2))})
    output$mesto2 <- renderText({paste0("Mesto: ",as.character(tbl.ekipa %>% filter(ekipa %in% input$ekipa2)%>% select(mesto)))})
    output$stadion2 <- renderText({paste0("Stadion in kapaciteta: ", as.character(tbl.ekipa %>% filter(ekipa %in% input$ekipa2)%>% select(stadion)),", ",as.character(tbl.ekipa %>% filter(ekipa %in% input$ekipa2)%>% select(kapaciteta)) )})
    output$manager2 <- renderText({paste0("Manager: ",as.character(tbl.vodstvo %>% filter(ekipa %in% input$ekipa2)%>% select(manager)))})
    
    output$tabela1 <- renderDataTable({tbl.igralcev %>% filter(ekipa %in% input$ekipa1, pozicija %in% input$pozicija) %>% select(igralec,pozicija,nastopi,podaje,goli)},
                                      options = list(searching = FALSE, paging = FALSE))
    output$tabela2 <- renderDataTable({tbl.igralcev %>% filter(ekipa %in% input$ekipa2, pozicija %in% input$pozicija) %>% select(igralec,pozicija,nastopi,podaje,goli)},
                                      options = list(searching = FALSE, paging = FALSE))
    output$tekma1 <- renderDataTable({tbl.tekma %>% filter(d_ekipa == input$ekipa1 | g_ekipa == input$ekipa1, as.Date(datum,"%d.%m.%Y") > input$zacetek, as.Date(datum,"%d.%m.%Y") < input$konec) %>% select(datum,"Domači"=d_ekipa,"Gostje"=g_ekipa,"Goli domačih"=d_gol,"Goli gostov"=g_gol)},
                                     options = list(searching = FALSE, paging = FALSE))
    output$tekma2 <- renderDataTable({tbl.tekma %>% filter(d_ekipa == input$ekipa2 | g_ekipa == input$ekipa2, as.Date(datum,"%d.%m.%Y") > input$zacetek, as.Date(datum,"%d.%m.%Y") < input$konec) %>% select(datum,"Domači"=d_ekipa,"Gostje"=g_ekipa,"Goli domačih"=d_gol,"Goli gostov"=g_gol)},options = list(searching = FALSE, paging = FALSE))
    
    
  })
