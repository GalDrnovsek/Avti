
library(RPostgreSQL)
library(dplyr)

#Uvoz:
source("auth_public.r", encoding="UTF-8")
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
    dbSendQuery(conn,build_sql("CREATE TABLE igralci(id PRIMARY KEY
                               ime TEXT NOT NULL
                               pozicija TEXT NOT NULL
                               )"))
    
    dbSendQuery(conn,build_sql())
  }, finally = {
    dbDisconnect(conn)
  })
}

##TEST