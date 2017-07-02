library(RPostgreSQL)
library(dplyr)
library(dbplyr)

#Uvoz:
source("auth.R", encoding="UTF-8")
source("uvoz.r", encoding="UTF-8")

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
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS tabelaIgralcev CASCADE"))
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS tabelaEkipa CASCADE"))
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS tabelaTekma CASCADE"))
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS tabelaVodstvo CASCADE"))
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS tabelaArsenal CASCADE"))
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS tabelaBournemouth CASCADE"))
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS tabelaBurnley CASCADE"))
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS tabelaChelsea CASCADE"))
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS tabelaCrystalPalace CASCADE"))
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS tabelaEverton CASCADE"))
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS tabelaHull CASCADE"))
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS tabelaLeicester CASCADE"))
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS tabelaLiverpool CASCADE"))
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS tabelaManCity CASCADE"))
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS tabelaManUnited CASCADE"))
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS tabelaMiddlesbrough CASCADE"))
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS tabelaSouthampton CASCADE"))
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS tabelaStoke CASCADE"))
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS tabelaSunderland CASCADE"))
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS tabelaSwansea CASCADE"))
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS tabelaTottenham CASCADE"))
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS tabelaWatford CASCADE"))
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS tabelaWba CASCADE"))
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS tabelaWestHam CASCADE"))
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
    
    #Glavne tabele
    tabelaIgralcev <- dbSendQuery(conn, build_sql("CREATE TABLE tabelaIgralcev(
                                           id INTEGER PRIMARY KEY,
                                           igralec TEXT,
                                           ekipa TEXT,
                                           pozicija TEXT,
                                           nastopi INTEGER,
                                           podaje INTEGER,
                                           goli INTEGER)"))
    
    tabelaEkipa <- dbSendQuery(conn, build_sql("CREATE TABLE tabelaEkipa(
                                           id INTEGER PRIMARY KEY,
                                           ekipa TEXT,
                                           mesto TEXT,
                                           stadion TEXT,
                                           kapaciteta INTEGER)"))
    
    tabelaTekma <- dbSendQuery(conn, build_sql("CREATE TABLE tabelaTekma(
                                          id INTEGER PRIMARY KEY,
                                          datum DATE,
                                          dEkipa TEXT,
                                          gEkipa TEXT,
                                          dGol INTEGER,
                                          gGol INTEGER)"))
    
    tabelaVodstvo <- dbSendQuery(conn, build_sql("CREATE TABLE tabelaVodstvo(
                                          id INTEGER PRIMARY KEY,
                                          ekipa TEXT,
                                          manager TEXT,
                                          kapetan TEXT)"))
    
    tabelaArsenal <- dbSendQuery(conn, build_sql("CREATE TABLE tabelaArsenal(
                                          igralec TEXT PRIMARY KEY,
                                          ekipa TEXT,
                                          pozicija TEXT,
                                          nastopi INTEGER,
                                          podaje INTEGER,
                                          goli INTEGER)"))
    
    tabelaBournemouth <- dbSendQuery(conn, build_sql("CREATE TABLE tabelaBournemouth(
                                          igralec TEXT PRIMARY KEY,
                                          ekipa TEXT,
                                          pozicija TEXT,
                                          nastopi INTEGER,
                                          podaje INTEGER,
                                          goli INTEGER)"))
    
    tabelaBurnley <- dbSendQuery(conn, build_sql("CREATE TABLE tabelaBurnley(
                                          igralec TEXT PRIMARY KEY,
                                          ekipa TEXT,
                                          pozicija TEXT,
                                          nastopi INTEGER,
                                          podaje INTEGER,
                                          goli INTEGER)"))
    
    tabelaChelsea <- dbSendQuery(conn, build_sql("CREATE TABLE tabelaChelsea(
                                          igralec TEXT PRIMARY KEY,
                                          ekipa TEXT,
                                          pozicija TEXT,
                                          nastopi INTEGER,
                                          podaje INTEGER,
                                          goli INTEGER)"))
    
    tabelaCrystalPalace <- dbSendQuery(conn, build_sql("CREATE TABLE tabelaCrystalPalace(
                                          igralec TEXT PRIMARY KEY,
                                          ekipa TEXT,
                                          pozicija TEXT,
                                          nastopi INTEGER,
                                          podaje INTEGER,
                                          goli INTEGER)"))
    
    tabelaEverton <- dbSendQuery(conn, build_sql("CREATE TABLE tabelaEverton(
                                          igralec TEXT PRIMARY KEY,
                                          ekipa TEXT,
                                          pozicija TEXT,
                                          nastopi INTEGER,
                                          podaje INTEGER,
                                          goli INTEGER)"))
    
    tabelaHull <- dbSendQuery(conn, build_sql("CREATE TABLE tabelaHull(
                                          igralec TEXT PRIMARY KEY,
                                          ekipa TEXT,
                                          pozicija TEXT,
                                          nastopi INTEGER,
                                          podaje INTEGER,
                                          goli INTEGER)"))
    
    tabelaLeicester <- dbSendQuery(conn, build_sql("CREATE TABLE tabelaLeicester(
                                          igralec TEXT PRIMARY KEY,
                                          ekipa TEXT,
                                          pozicija TEXT,
                                          nastopi INTEGER,
                                          podaje INTEGER,
                                          goli INTEGER)"))
    
    tabelaLiverpool <- dbSendQuery(conn, build_sql("CREATE TABLE tabelaLiverpool(
                                          igralec TEXT PRIMARY KEY,
                                          ekipa TEXT,
                                          pozicija TEXT,
                                          nastopi INTEGER,
                                          podaje INTEGER,
                                          goli INTEGER)"))
    
    tabelaManCity <- dbSendQuery(conn, build_sql("CREATE TABLE tabelaManCity(
                                          igralec TEXT PRIMARY KEY,
                                          ekipa TEXT,
                                          pozicija TEXT,
                                          nastopi INTEGER,
                                          podaje INTEGER,
                                          goli INTEGER)"))
    
    tabelaManUnited <- dbSendQuery(conn, build_sql("CREATE TABLE tabelaManUnited(
                                          igralec TEXT PRIMARY KEY,
                                          ekipa TEXT,
                                          pozicija TEXT,
                                          nastopi INTEGER,
                                          podaje INTEGER,
                                          goli INTEGER)"))
    
    tabelaMiddlesbrough <- dbSendQuery(conn, build_sql("CREATE TABLE tabelaMiddlesbrough(
                                          igralec TEXT PRIMARY KEY,
                                          ekipa TEXT,
                                          pozicija TEXT,
                                          nastopi INTEGER,
                                          podaje INTEGER,
                                          goli INTEGER)"))
    
    tabelaSouthampton <- dbSendQuery(conn, build_sql("CREATE TABLE tabelaSouthampton(
                                          igralec TEXT PRIMARY KEY,
                                          ekipa TEXT,
                                          pozicija TEXT,
                                          nastopi INTEGER,
                                          podaje INTEGER,
                                          goli INTEGER)"))
    
    tabelaStoker <- dbSendQuery(conn, build_sql("CREATE TABLE tabelaStoke(
                                          igralec TEXT PRIMARY KEY,
                                          ekipa TEXT,
                                          pozicija TEXT,
                                          nastopi INTEGER,
                                          podaje INTEGER,
                                          goli INTEGER)"))
    
    tabelaSunderland <- dbSendQuery(conn, build_sql("CREATE TABLE tabelaSunderland(
                                          igralec TEXT PRIMARY KEY,
                                          ekipa TEXT,
                                          pozicija TEXT,
                                          nastopi INTEGER,
                                          podaje INTEGER,
                                          goli INTEGER)"))
    
    tabelaSwansea <- dbSendQuery(conn, build_sql("CREATE TABLE tabelaSwansea(
                                          igralec TEXT PRIMARY KEY,
                                          ekipa TEXT,
                                          pozicija TEXT,
                                          nastopi INTEGER,
                                          podaje INTEGER,
                                          goli INTEGER)"))
    
    tabelaTottenham <- dbSendQuery(conn, build_sql("CREATE TABLE tabelaTottenham(
                                          igralec TEXT PRIMARY KEY,
                                          ekipa TEXT,
                                          pozicija TEXT,
                                          nastopi INTEGER,
                                          podaje INTEGER,
                                          goli INTEGER)"))
    
    tabelaWatford <- dbSendQuery(conn, build_sql("CREATE TABLE tabelaWatford(
                                          igralec TEXT PRIMARY KEY,
                                          ekipa TEXT,
                                          pozicija TEXT,
                                          nastopi INTEGER,
                                          podaje INTEGER,
                                          goli INTEGER)"))
    
    tabelaWba <- dbSendQuery(conn, build_sql("CREATE TABLE tabelaWba(
                                          igralec TEXT PRIMARY KEY,
                                          ekipa TEXT,
                                          pozicija TEXT,
                                          nastopi INTEGER,
                                          podaje INTEGER,
                                          goli INTEGER)"))
    
    tabelaWestHam <- dbSendQuery(conn, build_sql("CREATE TABLE tabelaWestHam(
                                          igralec TEXT PRIMARY KEY,
                                          ekipa TEXT,
                                          pozicija TEXT,
                                          nastopi INTEGER,
                                          podaje INTEGER,
                                          goli INTEGER)"))
    
    
    
    
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
    
    dbWriteTable(conn, name="tabelaIgralcev", tabelaIgralcev, append=T, row.names=FALSE)
    dbWriteTable(conn, name="tabelaEkipa", tabelaEkipa, append=T, row.names=FALSE)
    dbWriteTable(conn, name="tabelaTekma", tabelaTekma, append=T, row.names=FALSE)
    dbWriteTable(conn, name="tabelaVodstvo", tabelaVodstvo, append=T, row.names=FALSE)
    dbWriteTable(conn, name="tabelaArsenal", tabelaArsenal, append=T, row.names=FALSE)
    dbWriteTable(conn, name="tabelaBournemouth", tabelaBournemouth, append=T, row.names=FALSE)
    dbWriteTable(conn, name="tabelaBurnley", tabelaBurnley, append=T, row.names=FALSE)
    dbWriteTable(conn, name="tabelaChelsea", tabelaChelsea, append=T, row.names=FALSE)
    dbWriteTable(conn, name="tabelaCrystalPalace", tabelaCrystalPalace, append=T, row.names=FALSE)
    dbWriteTable(conn, name="tabelaEverton", tabelaEverton, append=T, row.names=FALSE)
    dbWriteTable(conn, name="tabelaHull", tabelaHull, append=T, row.names=FALSE)
    dbWriteTable(conn, name="tabelaLeicester", tabelaLeicester, append=T, row.names=FALSE)
    dbWriteTable(conn, name="tabelaLiverpool", tabelaLiverpool, append=T, row.names=FALSE)
    dbWriteTable(conn, name="tabelaManCity", tabelaManCity, append=T, row.names=FALSE)
    dbWriteTable(conn, name="tabelaManUnited", tabelaManUnited, append=T, row.names=FALSE)
    dbWriteTable(conn, name="tabelaMiddlesbrough", tabelaMiddlesbrough, append=T, row.names=FALSE)
    dbWriteTable(conn, name="tabelaSouthampton", tabelaSouthampton, append=T, row.names=FALSE)
    dbWriteTable(conn, name="tabelaStoke", tabelaStoke, append=T, row.names=FALSE)
    dbWriteTable(conn, name="tabelaSunderland", tabelaSunderland, append=T, row.names=FALSE)
    dbWriteTable(conn, name="tabelaSwansea", tabelaSwansea, append=T, row.names=FALSE)
    dbWriteTable(conn, name="tabelaTottenham", tabelaTottenham, append=T, row.names=FALSE)
    dbWriteTable(conn, name="tabelaWatford", tabelaWatford, append=T, row.names=FALSE)
    dbWriteTable(conn, name="tabelaWba", tabelaWba, append=T, row.names=FALSE)
    dbWriteTable(conn, name="tabelaWestHam", tabelaWestHam, append=T, row.names=FALSE)
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
