require(dplyr)

# Priklop na bazo. Vnesite ustrezno geslo.
geslo <- "" 

db <- src_postgres(host="baza.fmf.uni-lj.si", 
                   dbname = "banka", user = "janp", 
                   password = geslo)