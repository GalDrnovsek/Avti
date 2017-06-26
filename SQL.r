library(RPostgreSQL)
library(dplyr)

#Uvoz:
source("auth.R", encoding="UTF-8")
source("fuzbal.R", encoding="UTF-8")

# Povezemo se z gonilnikom za PostgreSQL
drv <- dbDriver("PostgreSQL") 


# Funkcija za brisanje tabel
delete_table <- function(){
  # Uporabimo funkcijo tryCatch,
  # da prisilimo prekinitev povezave v primeru napake
  tryCatch({
    # Vzpostavimo povezavo z bazo
    conn <- dbConnect(drv, dbname = db, host = host, user = user, password = password)
    
    # Če tabela obstaja, jo zbrišemo, ter najprej zbrišemo tiste,
    # ki se navezujejo na druge
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS igralci CASCADE"))
  }, finally = {
    dbDisconnect(conn)
  })
}


pravice <- function(){
  # Uporabimo tryCatch,(da se povežemo in bazo in odvežemo)
  # da prisilimo prekinitev povezave v primeru napake
  tryCatch({
    # Vzpostavimo povezavo
    conn <- dbConnect(drv, dbname = db, host = host,#drv=s čim se povezujemo
                      user = user, password = password)
    
    dbSendQuery(conn, build_sql("GRANT CONNECT ON DATABASE sem2017_janp TO gald WITH GRANT OPTION"))
    dbSendQuery(conn, build_sql("GRANT CONNECT ON DATABASE sem2017_janp TO zant WITH GRANT OPTION"))
    dbSendQuery(conn, build_sql("GRANT ALL ON SCHEMA public TO gald WITH GRANT OPTION"))
    dbSendQuery(conn, build_sql("GRANT ALL ON SCHEMA public TO zant WITH GRANT OPTION"))
    
    
  }, finally = {
    # Na koncu nujno prekinemo povezavo z bazo,
    # saj preveč odprtih povezav ne smemo imeti
    dbDisconnect(conn) #PREKINEMO POVEZAVO
    # Koda v finally bloku se izvede, preden program konča z napako
  })
}


#Funkcija, ki ustvari tabele
create_table <- function(){
  # Uporabimo tryCatch,(da se povežemo in bazo in odvežemo)
  # da prisilimo prekinitev povezave v primeru napake
  tryCatch({
    # Vzpostavimo povezavo
    conn <- dbConnect(drv, dbname = db, host = host,#drv=s čim se povezujemo
                      user = user, password = password)
    
    #Glavne tabele
    igralci <- dbSendQuery(conn,build_sql("CREATE TABLE igralci (
                                         id PRIMARY KEY,
                                         ime TEXT NOT NULL,
                                         pozicija TEXT NOT NULL)"))
    
    
    dbSendQuery(conn, build_sql("GRANT ALL ON ALL TABLES IN SCHEMA public TO janp WITH GRANT OPTION"))
    dbSendQuery(conn, build_sql("GRANT ALL ON ALL TABLES IN SCHEMA public TO gald WITH GRANT OPTION"))
    dbSendQuery(conn, build_sql("GRANT ALL ON ALL TABLES IN SCHEMA public TO zant WITH GRANT OPTION"))
    dbSendQuery(conn, build_sql("GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO janp WITH GRANT OPTION"))
    dbSendQuery(conn, build_sql("GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO gald WITH GRANT OPTION"))
    dbSendQuery(conn, build_sql("GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO zant WITH GRANT OPTION"))
    
  }, finally = {
    # Na koncu nujno prekinemo povezavo z bazo,
    # saj preveč odprtih povezav ne smemo imeti
    dbDisconnect(conn) #PREKINEMO POVEZAVO
    # Koda v finally bloku se izvede, preden program konča z napako
  })
}


#Funcija, ki vstavi podatke
insert_data <- function(){
  tryCatch({
    conn <- dbConnect(drv, dbname = db, host = host,
                      user = user, password = password)
    
    dbWriteTable(conn, name="igralci", tabela_igralcev, append=T, row.names=FALSE)
  }, finally = {
    dbDisconnect(conn) 
    
  })
}

delete_table()
pravice()
create_table()
insert_data()

con <- src_postgres(dbname = db, host = host, user = user, password = password)

##TEST
