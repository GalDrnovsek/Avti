library(RPostgreSQL)
library(dplyr)
library(dbplyr)

#Uvoz:
source("auth.R", encoding="UTF-8")
source("uvoz/uvoz.r", encoding="UTF-8")

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
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS ekipa CASCADE"))
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS igralec CASCADE"))
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS tekma CASCADE"))
  }, finally = {
    dbDisconnect(conn)
  })
}


#Funkcija, ki ustvari tabele
create_table <- function(){
  # Uporabimo tryCatch,(da se povežemo in bazo in odvežemo)
  # da prisilimo prekinitev povezave v primeru napake
  tryCatch({
    # Vzpostavimo povezavo
    conn <- dbConnect(drv, dbname = db, host = host, #drv=s čim se povezujemo
                      user = user, password = password)
    
    # Glavne tabele
    ekipa <- dbSendQuery(conn, build_sql("CREATE TABLE ekipa(
                                           id INTEGER PRIMARY KEY,
                                           ekipa TEXT,
                                           mesto TEXT,
                                           stadion TEXT,
                                           kapaciteta INTEGER,
                                           manager TEXT,
                                           kapetan INTEGER)"))
    
    igralec <- dbSendQuery(conn, build_sql("CREATE TABLE igralec(
                                           id INTEGER PRIMARY KEY,
                                           igralec TEXT,
                                           ekipa INTEGER,
                                           pozicija TEXT,
                                           nastopi INTEGER,
                                           podaje INTEGER,
                                           goli INTEGER,
                                           FOREIGN KEY(ekipa) REFERENCES ekipa(id))"))

    tekma <- dbSendQuery(conn, build_sql("CREATE TABLE tekma(
                                           id INTEGER PRIMARY KEY,
                                           datum DATE,
                                           d_ekipa INTEGER REFERENCES ekipa(id),
                                           g_ekipa INTEGER REFERENCES ekipa(id),
                                           d_gol INTEGER,
                                           g_gol INTEGER)"))
    

  
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
    
    dbWriteTable(conn, name="ekipa", ekipa, append=T, row.names=FALSE)
    dbWriteTable(conn, name="igralec", igralec, append=T, row.names=FALSE)
    dbWriteTable(conn, name="tekma", tekma, append=T, row.names=FALSE)
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
    
    dbSendQuery(conn, build_sql("GRANT CONNECT ON DATABASE sem2017_gald TO janp WITH GRANT OPTION"))
    dbSendQuery(conn, build_sql("GRANT CONNECT ON DATABASE sem2017_gald TO zant WITH GRANT OPTION"))
    
    dbSendQuery(conn, build_sql("GRANT ALL ON SCHEMA public TO janp WITH GRANT OPTION"))
    dbSendQuery(conn, build_sql("GRANT ALL ON SCHEMA public TO zant WITH GRANT OPTION"))
    
    dbSendQuery(conn, build_sql("GRANT ALL ON ALL TABLES IN SCHEMA public TO gald WITH GRANT OPTION"))
    dbSendQuery(conn, build_sql("GRANT ALL ON ALL TABLES IN SCHEMA public TO janp WITH GRANT OPTION"))
    dbSendQuery(conn, build_sql("GRANT ALL ON ALL TABLES IN SCHEMA public TO zant WITH GRANT OPTION"))
    
    dbSendQuery(conn, build_sql("GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO gald WITH GRANT OPTION"))
    dbSendQuery(conn, build_sql("GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO janp WITH GRANT OPTION"))
    dbSendQuery(conn, build_sql("GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO zant WITH GRANT OPTION"))
    
    dbSendQuery(conn, build_sql("GRANT CONNECT ON DATABASE sem2017_gald TO javnost"))
    dbSendQuery(conn, build_sql("GRANT SELECT ON ALL TABLES IN SCHEMA public TO javnost"))
    
    
  }, finally = {
    # Na koncu nujno prekinemo povezavo z bazo,
    # saj preveč odprtih povezav ne smemo imeti
    dbDisconnect(conn) #PREKINEMO POVEZAVO
    # Koda v finally bloku se izvede, preden program konča z napako
  })
}


delete_table()
pravice()
create_table()
insert_data()

con <- src_postgres(dbname = db, host = host, user = user, password = password)

##TEST
