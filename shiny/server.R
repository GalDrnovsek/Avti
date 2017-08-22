library(shiny)
library(dplyr)
library(RPostgreSQL)
library(datasets)

source("auth_public.r", encoding="UTF-8")


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
    
    output$mesto1 <- renderText({
      data <- tbl.ekipa %>% filter(ekipa == input$ekipa1) %>% select(mesto) %>%
        data.frame()
      paste0("Mesto: ",data$mesto)
    })
    
    output$stadion1 <- renderText({
      data <- tbl.ekipa %>% filter(ekipa == input$ekipa1) %>% select(stadion, kapaciteta) %>%
        data.frame()
      paste0("Stadion in kapaciteta: ", data$stadion,", ",data$kapaciteta )
    })
    
    output$manager1 <- renderText({
      data <- tbl.vodstvo %>% filter(ekipa == input$ekipa1) %>% select(manager) %>%
        data.frame()
      paste0("Manager: ", data$manager)
    })
    
    
    
    output$ime2 <- renderText({c(paste0("Ime ekipe: ", input$ekipa2))})
    
    output$mesto2 <- renderText({
      data <- tbl.ekipa %>% filter(ekipa == input$ekipa2) %>% select(mesto) %>%
        data.frame()
      paste0("Mesto: ",data$mesto)
    })
    
    output$stadion2 <- renderText({
      data <- tbl.ekipa %>% filter(ekipa == input$ekipa2) %>% select(stadion, kapaciteta) %>%
        data.frame()
      paste0("Stadion in kapaciteta: ", data$stadion,", ",data$kapaciteta)
    })
    
    output$manager2 <- renderText({
      data <- tbl.vodstvo %>% filter(ekipa == input$ekipa2) %>% select(manager) %>%
        data.frame()
      paste0("Manager: ", data$manager)
    })
    
    
    
    output$tabela1 <- renderDataTable({
      validate(need(!is.null(input$ekipa1), "Izberi prvo ekipo!"))
      validate(need(length(input$pozicija) >= 1, "Izberi pozicijo!"))
      pos <- c(input$pozicija, NA) # prisilimo dplyr, da podatke predstavi kot vektor
      igralci <- tbl.igralcev %>% filter(ekipa == input$ekipa1, pozicija %in% pos) %>%
        select(igralec,pozicija,nastopi,podaje,goli) %>% data.frame()
      Encoding(igralci$igralec) <- "UTF-8"
      igralci
    }, options = list(searching = FALSE, paging = FALSE, encoding="UTF-8"))
    

    output$tabela2 <- renderDataTable({
      validate(need(!is.null(input$ekipa2), "Izberi drugo ekipo!"))
      validate(need(length(input$pozicija) >= 1, "Izberi pozicijo!"))
      pos <- c(input$pozicija, NA) # prisilimo dplyr, da podatke predstavi kot vektor
      igralci <- tbl.igralcev %>% filter(ekipa == input$ekipa2, pozicija %in% pos) %>%
        select(igralec,pozicija,nastopi,podaje,goli) %>% data.frame()
      Encoding(igralci$igralec) <- "UTF-8"
      igralci
    }, options = list(searching = FALSE, paging = FALSE, encoding="UTF-8"))
    
    
    
    output$tekma1 <- renderDataTable({
      validate(need(!is.null(input$ekipa1), "Izberi prvo ekipo!"))
      validate(need(length(input$zacetek) == 1 && length(input$konec) == 1,
                    "Izberi začetni in končni datum!"))
      tbl.tekma %>% filter(d_ekipa == input$ekipa1 | g_ekipa == input$ekipa1,
                           datum > input$zacetek, datum < input$konec) %>%
        select(datum, "Domaci" = d_ekipa, "Gostje" = g_ekipa, "Goli domacih" = d_gol,
               "Goli gostov" = g_gol) %>% data.frame()
    }, options = list(searching = FALSE, paging = FALSE, encoding="UTF-8"))
    
    
    output$tekma2 <- renderDataTable({
      validate(need(!is.null(input$ekipa2), "Izberi drugo ekipo!"))
      validate(need(length(input$zacetek) == 1 && length(input$konec) == 1,
                    "Izberi začetni in končni datum!"))
      tbl.tekma %>% filter(d_ekipa == input$ekipa2 | g_ekipa == input$ekipa2,
                           datum > input$zacetek, datum < input$konec) %>%
        select(datum, "Domaci" = d_ekipa, "Gostje" = g_ekipa, "Goli domacih" = d_gol,
               "Goli gostov" = g_gol) %>% data.frame()
    }, options = list(searching = FALSE, paging = FALSE, encoding="UTF-8"))
    
    
  })
