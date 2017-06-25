
library(dplyr)
library(tidyr)
library(rvest)
library(stringr)

#Uvoz ekip

htmlEkipa <- html_session("https://en.wikipedia.org/wiki/2016%E2%80%9317_Premier_League") %>% read_html()
htmlEkipa <- htmlEkipa %>% html_nodes("table") %>% .[[2]]
tabelaEkipa <- htmlEkipa %>% html_table()
colnames(tabelaEkipa) <- c("Ekipa","Mesto","Stadion","Kapaciteta")
class(tabelaEkipa$Kapaciteta)
tabelaEkipa$Kapaciteta <- gsub(",","",tabelaEkipa$Kapaciteta,fixed=TRUE)
tabelaEkipa$Kapaciteta <- gsub("[14]","",tabelaEkipa$Kapaciteta,fixed=TRUE)
tabelaEkipa$Kapaciteta <- as.numeric(tabelaEkipa$Kapaciteta)
tabelaEkipa$Id <- c(1:length(tabelaEkipa$Ekipa))
tabelaEkipa <- tabelaEkipa[c(5,1:4)]
 

#Uvoz tekem

htmlTekma <- html_session("http://www.betstudy.com/soccer-stats/c/england/premier-league/d/results/2016-2017/") %>% read_html()
htmlTekma <- htmlTekma %>% html_nodes(xpath=".//*[@id='content']/div/div[3]/table")
tabelaTekma <- htmlTekma %>% html_table()
tabelaTekma <- as.data.frame(tabelaTekma)
colnames(tabelaTekma) <- c("Datum","DEkipa","Rezultat","GEkipa","")
goli <- str_split_fixed(tabelaTekma$Rezultat, " - ", 2)
tabelaTekma$DGol <- as.numeric(goli[,1])
tabelaTekma$GGol <- as.numeric(goli[,2])
tabelaTekma$Id <- c(1:length(tabelaTekma$Datum))
tabelaTekma <- tabelaTekma[c(8,1,2,4,6,7)]
#Uvoz igralcev


#ARSENAL

htmlArsenal <- html_session("http://www.betstudy.com/soccer-stats/teams/arsenal/660/squad/") %>% read_html
htmlArsenal <- htmlArsenal %>% html_nodes("table") %>% .[[2]]
tabelaArsenal <- htmlArsenal %>% html_table()
tabelaArsenal <- tabelaArsenal[c(2,4,7,11,12)]
colnames(tabelaArsenal) <- c("Igralec","Pozicija","Nastopi","Podaje","Goli")
tabelaArsenal$Pozicija[tabelaArsenal$Pozicija=="G"]<- c("Vratar")
tabelaArsenal$Pozicija[tabelaArsenal$Pozicija=="D"]<- c("Branilec")
tabelaArsenal$Pozicija[tabelaArsenal$Pozicija=="M"]<- c("Sredina")
tabelaArsenal$Pozicija[tabelaArsenal$Pozicija=="A"]<- c("Napadalec")
tabelaArsenal$Ekipa <- c("Arsenal")
tabelaArsenal <- tabelaArsenal[c(1,6,2,3,4,5)]

#CHELSEA

htmlChelsea <- html_session("http://www.betstudy.com/soccer-stats/teams/chelsea/661/squad/?sid=12653") %>% read_html
htmlChelsea <- htmlChelsea %>% html_nodes("table") %>% .[[2]]
tabelaChelsea <- htmlChelsea %>% html_table()
tabelaChelsea <- tabelaChelsea[c(2,4,7,11,12)]
colnames(tabelaChelsea) <- c("Igralec","Pozicija","Nastopi","Podaje","Goli")
tabelaChelsea$Pozicija[tabelaChelsea$Pozicija=="G"]<- c("Vratar")
tabelaChelsea$Pozicija[tabelaChelsea$Pozicija=="D"]<- c("Branilec")
tabelaChelsea$Pozicija[tabelaChelsea$Pozicija=="M"]<- c("Sredina")
tabelaChelsea$Pozicija[tabelaChelsea$Pozicija=="A"]<- c("Napadalec")
tabelaChelsea$Ekipa <- c("Chelsea")
tabelaChelsea <- tabelaChelsea[c(1,6,2,3,4,5)]

#TOTTENHAM

htmlTottenham <- html_session("http://www.betstudy.com/soccer-stats/teams/tottenham-hotspur/675/squad/?sid=12653") %>% read_html
htmlTottenham <- htmlTottenham %>% html_nodes("table") %>% .[[2]]
tabelaTottenham <- htmlTottenham %>% html_table()
tabelaTottenham <- tabelaTottenham[c(2,4,7,11,12)]
colnames(tabelaTottenham) <- c("Igralec","Pozicija","Nastopi","Podaje","Goli")
tabelaTottenham$Pozicija[tabelaTottenham$Pozicija=="G"]<- c("Vratar")
tabelaTottenham$Pozicija[tabelaTottenham$Pozicija=="D"]<- c("Branilec")
tabelaTottenham$Pozicija[tabelaTottenham$Pozicija=="M"]<- c("Sredina")
tabelaTottenham$Pozicija[tabelaTottenham$Pozicija=="A"]<- c("Napadalec")
tabelaTottenham$Ekipa <- c("Tottenham Hotspur")
tabelaTottenham <- tabelaTottenham[c(1,6,2,3,4,5)]

#MAN CITY

htmlManCity <- html_session("http://www.betstudy.com/soccer-stats/teams/manchester-city/676/squad/?sid=12653") %>% read_html
htmlManCity <- htmlManCity %>% html_nodes("table") %>% .[[2]]
tabelaManCity <- htmlManCity %>% html_table()
tabelaManCity <- tabelaManCity[c(2,4,7,11,12)]
colnames(tabelaManCity) <- c("Igralec","Pozicija","Nastopi","Podaje","Goli")
tabelaManCity$Pozicija[tabelaManCity$Pozicija=="G"]<- c("Vratar")
tabelaManCity$Pozicija[tabelaManCity$Pozicija=="D"]<- c("Branilec")
tabelaManCity$Pozicija[tabelaManCity$Pozicija=="M"]<- c("Sredina")
tabelaManCity$Pozicija[tabelaManCity$Pozicija=="A"]<- c("Napadalec")
tabelaManCity$Ekipa <- c("Manchester City")
tabelaManCity <- tabelaManCity[c(1,6,2,3,4,5)]

# Liverpool

htmlLiverpool <- html_session("http://www.betstudy.com/soccer-stats/teams/liverpool/663/squad/?sid=12653") %>% read_html
htmlLiverpool <- htmlLiverpool %>% html_nodes("table") %>% .[[2]]
tabelaLiverpool <- htmlLiverpool %>% html_table()
tabelaLiverpool <- tabelaLiverpool[c(2,4,7,11,12)]
colnames(tabelaLiverpool) <- c("Igralec","Pozicija","Nastopi","Podaje","Goli")
tabelaLiverpool$Pozicija[tabelaLiverpool$Pozicija=="G"]<- c("Vratar")
tabelaLiverpool$Pozicija[tabelaLiverpool$Pozicija=="D"]<- c("Branilec")
tabelaLiverpool$Pozicija[tabelaLiverpool$Pozicija=="M"]<- c("Sredina")
tabelaLiverpool$Pozicija[tabelaLiverpool$Pozicija=="A"]<- c("Napadalec")
tabelaLiverpool$Ekipa <- c("Liverpool")
tabelaLiverpool <- tabelaLiverpool[c(1,6,2,3,4,5)]

#MAN UNITED

htmlManUnited <- html_session("http://www.betstudy.com/soccer-stats/teams/manchester-united/662/squad/?sid=12653") %>% read_html
htmlManUnited <- htmlManUnited %>% html_nodes("table") %>% .[[2]]
tabelaManUnited <- htmlManUnited %>% html_table()
tabelaManUnited <- tabelaManUnited[c(2,4,7,11,12)]
colnames(tabelaManUnited) <- c("Igralec","Pozicija","Nastopi","Podaje","Goli")
tabelaManUnited$Pozicija[tabelaManUnited$Pozicija=="G"]<- c("Vratar")
tabelaManUnited$Pozicija[tabelaManUnited$Pozicija=="D"]<- c("Branilec")
tabelaManUnited$Pozicija[tabelaManUnited$Pozicija=="M"]<- c("Sredina")
tabelaManUnited$Pozicija[tabelaManUnited$Pozicija=="A"]<- c("Napadalec")
tabelaManUnited$Ekipa <- c("Manchester United")
tabelaManUnited <- tabelaManUnited[c(1,6,2,3,4,5)]

#Everton

htmlEverton <- html_session("http://www.betstudy.com/soccer-stats/teams/everton/674/squad/?sid=12653") %>% read_html
htmlEverton <- htmlEverton %>% html_nodes("table") %>% .[[2]]
tabelaEverton <- htmlEverton %>% html_table()
tabelaEverton <- tabelaEverton[c(2,4,7,11,12)]
colnames(tabelaEverton) <- c("Igralec","Pozicija","Nastopi","Podaje","Goli")
tabelaEverton$Pozicija[tabelaEverton$Pozicija=="G"]<- c("Vratar")
tabelaEverton$Pozicija[tabelaEverton$Pozicija=="D"]<- c("Branilec")
tabelaEverton$Pozicija[tabelaEverton$Pozicija=="M"]<- c("Sredina")
tabelaEverton$Pozicija[tabelaEverton$Pozicija=="A"]<- c("Napadalec")
tabelaEverton$Ekipa <- c("Everton")
tabelaEverton <- tabelaEverton[c(1,6,2,3,4,5)]

#Southampton

htmlSouthampton <- html_session("http://www.betstudy.com/soccer-stats/teams/everton/670/squad/?sid=12653") %>% read_html
htmlSouthampton <- htmlSouthampton %>% html_nodes("table") %>% .[[2]]
tabelaSouthampton <- htmlSouthampton %>% html_table()
tabelaSouthampton <- tabelaSouthampton[c(2,4,7,11,12)]
colnames(tabelaSouthampton) <- c("Igralec","Pozicija","Nastopi","Podaje","Goli")
tabelaSouthampton$Pozicija[tabelaSouthampton$Pozicija=="G"]<- c("Vratar")
tabelaSouthampton$Pozicija[tabelaSouthampton$Pozicija=="D"]<- c("Branilec")
tabelaSouthampton$Pozicija[tabelaSouthampton$Pozicija=="M"]<- c("Sredina")
tabelaSouthampton$Pozicija[tabelaSouthampton$Pozicija=="A"]<- c("Napadalec")
tabelaSouthampton$Ekipa <- c("Southampton")
tabelaSouthampton <- tabelaSouthampton[c(1,6,2,3,4,5)]

#AFC Bournemouth

htmlBournemouth <- html_session("http://www.betstudy.com/soccer-stats/teams/everton/711/squad/?sid=12653") %>% read_html
htmlBournemouth <- htmlBournemouth %>% html_nodes("table") %>% .[[2]]
tabelaBournemouth <- htmlBournemouth %>% html_table()
tabelaBournemouth <- tabelaBournemouth[c(2,4,7,11,12)]
colnames(tabelaBournemouth) <- c("Igralec","Pozicija","Nastopi","Podaje","Goli")
tabelaBournemouth$Pozicija[tabelaBournemouth$Pozicija=="G"]<- c("Vratar")
tabelaBournemouth$Pozicija[tabelaBournemouth$Pozicija=="D"]<- c("Branilec")
tabelaBournemouth$Pozicija[tabelaBournemouth$Pozicija=="M"]<- c("Sredina")
tabelaBournemouth$Pozicija[tabelaBournemouth$Pozicija=="A"]<- c("Napadalec")
tabelaBournemouth$Ekipa <- c("AFC Bournemouth")
tabelaBournemouth <- tabelaBournemouth[c(1,6,2,3,4,5)]

#WBA

htmlWba <- html_session("http://www.betstudy.com/soccer-stats/teams/everton/678/squad/?sid=12653") %>% read_html
htmlWba <- htmlWba %>% html_nodes("table") %>% .[[2]]
tabelaWba <- htmlWba %>% html_table()
tabelaWba <- tabelaWba[c(2,4,7,11,12)]
colnames(tabelaWba) <- c("Igralec","Pozicija","Nastopi","Podaje","Goli")
tabelaWba$Pozicija[tabelaWba$Pozicija=="G"]<- c("Vratar")
tabelaWba$Pozicija[tabelaWba$Pozicija=="D"]<- c("Branilec")
tabelaWba$Pozicija[tabelaWba$Pozicija=="M"]<- c("Sredina")
tabelaWba$Pozicija[tabelaWba$Pozicija=="A"]<- c("Napadalec")
tabelaWba$Ekipa <- c("West Bromwich Albion")
tabelaWba <- tabelaWba[c(1,6,2,3,4,5)]

#West Ham

htmlWestHam <- html_session("http://www.betstudy.com/soccer-stats/teams/everton/684/squad/?sid=12653") %>% read_html
htmlWestHam <- htmlWestHam %>% html_nodes("table") %>% .[[2]]
tabelaWestHam <- htmlWestHam %>% html_table()
tabelaWestHam <- tabelaWestHam[c(2,4,7,11,12)]
colnames(tabelaWestHam) <- c("Igralec","Pozicija","Nastopi","Podaje","Goli")
tabelaWestHam$Pozicija[tabelaWestHam$Pozicija=="G"]<- c("Vratar")
tabelaWestHam$Pozicija[tabelaWestHam$Pozicija=="D"]<- c("Branilec")
tabelaWestHam$Pozicija[tabelaWestHam$Pozicija=="M"]<- c("Sredina")
tabelaWestHam$Pozicija[tabelaWestHam$Pozicija=="A"]<- c("Napadalec")
tabelaWestHam$Ekipa <- c("West Ham United")
tabelaWestHam <- tabelaWestHam[c(1,6,2,3,4,5)]

#Leicester

htmlLeicester <- html_session("http://www.betstudy.com/soccer-stats/teams/everton/682/squad/?sid=12653") %>% read_html
htmlLeicester <- htmlLeicester %>% html_nodes("table") %>% .[[2]]
tabelaLeicester <- htmlLeicester %>% html_table()
tabelaLeicester <- tabelaLeicester[c(2,4,7,11,12)]
colnames(tabelaLeicester) <- c("Igralec","Pozicija","Nastopi","Podaje","Goli")
tabelaLeicester$Pozicija[tabelaLeicester$Pozicija=="G"]<- c("Vratar")
tabelaLeicester$Pozicija[tabelaLeicester$Pozicija=="D"]<- c("Branilec")
tabelaLeicester$Pozicija[tabelaLeicester$Pozicija=="M"]<- c("Sredina")
tabelaLeicester$Pozicija[tabelaLeicester$Pozicija=="A"]<- c("Napadalec")
tabelaLeicester$Ekipa <- c("Leicester City")
tabelaLeicester <- tabelaLeicester[c(1,6,2,3,4,5)]

#Stoke 

htmlStoke <- html_session("http://www.betstudy.com/soccer-stats/teams/everton/690/squad/?sid=12653") %>% read_html
htmlStoke <- htmlStoke %>% html_nodes("table") %>% .[[2]]
tabelaStoke <- htmlStoke %>% html_table()
tabelaStoke <- tabelaStoke[c(2,4,7,11,12)]
colnames(tabelaStoke) <- c("Igralec","Pozicija","Nastopi","Podaje","Goli")
tabelaStoke$Pozicija[tabelaStoke$Pozicija=="G"]<- c("Vratar")
tabelaStoke$Pozicija[tabelaStoke$Pozicija=="D"]<- c("Branilec")
tabelaStoke$Pozicija[tabelaStoke$Pozicija=="M"]<- c("Sredina")
tabelaStoke$Pozicija[tabelaStoke$Pozicija=="A"]<- c("Napadalec")
tabelaStoke$Ekipa <- c("Stoke City")
tabelaStoke <- tabelaStoke[c(1,6,2,3,4,5)]

#Crstal Palace

htmlCrystalPalace <- html_session("http://www.betstudy.com/soccer-stats/teams/crystal-palace/679/squad/?sid=12653") %>% read_html
htmlCrystalPalace <- htmlCrystalPalace %>% html_nodes("table") %>% .[[2]]
tabelaCrystalPalace <- htmlCrystalPalace %>% html_table()
tabelaCrystalPalace <- tabelaCrystalPalace[c(2,4,7,11,12)]
colnames(tabelaCrystalPalace) <- c("Igralec","Pozicija","Nastopi","Podaje","Goli")
tabelaCrystalPalace$Pozicija[tabelaCrystalPalace$Pozicija=="G"]<- c("Vratar")
tabelaCrystalPalace$Pozicija[tabelaCrystalPalace$Pozicija=="D"]<- c("Branilec")
tabelaCrystalPalace$Pozicija[tabelaCrystalPalace$Pozicija=="M"]<- c("Sredina")
tabelaCrystalPalace$Pozicija[tabelaCrystalPalace$Pozicija=="A"]<- c("Napadalec")
tabelaCrystalPalace$Ekipa <- c("Crystal Palace")
tabelaCrystalPalace<- tabelaCrystalPalace[c(1,6,2,3,4,5)]

#Swansea

htmlSwansea <- html_session("http://www.betstudy.com/soccer-stats/teams/crystal-palace/738/squad/?sid=12653") %>% read_html
htmlSwansea <- htmlSwansea %>% html_nodes("table") %>% .[[2]]
tabelaSwansea <- htmlSwansea %>% html_table()
tabelaSwansea <- tabelaSwansea[c(2,4,7,11,12)]
colnames(tabelaSwansea) <- c("Igralec","Pozicija","Nastopi","Podaje","Goli")
tabelaSwansea$Pozicija[tabelaSwansea$Pozicija=="G"]<- c("Vratar")
tabelaSwansea$Pozicija[tabelaSwansea$Pozicija=="D"]<- c("Branilec")
tabelaSwansea$Pozicija[tabelaSwansea$Pozicija=="M"]<- c("Sredina")
tabelaSwansea$Pozicija[tabelaSwansea$Pozicija=="A"]<- c("Napadalec")
tabelaSwansea$Ekipa <- c("Swansea")
tabelaSwansea <- tabelaSwansea[c(1,6,2,3,4,5)]

#Burnley

htmlBurnley <- html_session("http://www.betstudy.com/soccer-stats/teams/crystal-palace/698/squad/?sid=12653") %>% read_html
htmlBurnley <- htmlBurnley %>% html_nodes("table") %>% .[[2]]
tabelaBurnley <- htmlBurnley %>% html_table()
tabelaBurnley <- tabelaBurnley[c(2,4,7,11,12)]
colnames(tabelaBurnley) <- c("Igralec","Pozicija","Nastopi","Podaje","Goli")
tabelaBurnley$Pozicija[tabelaBurnley$Pozicija=="G"]<- c("Vratar")
tabelaBurnley$Pozicija[tabelaBurnley$Pozicija=="D"]<- c("Branilec")
tabelaBurnley$Pozicija[tabelaBurnley$Pozicija=="M"]<- c("Sredina")
tabelaBurnley$Pozicija[tabelaBurnley$Pozicija=="A"]<- c("Napadalec")
tabelaBurnley$Ekipa <- c("Burnley")
tabelaBurnley <- tabelaBurnley[c(1,6,2,3,4,5)]

#Watford

htmlWatford <- html_session("http://www.betstudy.com/soccer-stats/teams/crystal-palace/696/squad/?sid=12653") %>% read_html
htmlWatford <- htmlWatford %>% html_nodes("table") %>% .[[2]]
tabelaWatford <- htmlWatford %>% html_table()
tabelaWatford <- tabelaWatford[c(2,4,7,11,12)]
colnames(tabelaWatford) <- c("Igralec","Pozicija","Nastopi","Podaje","Goli")
tabelaWatford$Pozicija[tabelaWatford$Pozicija=="G"]<- c("Vratar")
tabelaWatford$Pozicija[tabelaWatford$Pozicija=="D"]<- c("Branilec")
tabelaWatford$Pozicija[tabelaWatford$Pozicija=="M"]<- c("Sredina")
tabelaWatford$Pozicija[tabelaWatford$Pozicija=="A"]<- c("Napadalec")
tabelaWatford$Ekipa <- c("Watford")
tabelaWatford <- tabelaWatford[c(1,6,2,3,4,5)]

#Hull City

htmlHull <- html_session("http://www.betstudy.com/soccer-stats/teams/crystal-palace/725/squad/?sid=12653") %>% read_html
htmlHull <- htmlHull %>% html_nodes("table") %>% .[[2]]
tabelaHull <- htmlHull %>% html_table()
tabelaHull <- tabelaHull[c(2,4,7,11,12)]
colnames(tabelaHull) <- c("Igralec","Pozicija","Nastopi","Podaje","Goli")
tabelaHull$Pozicija[tabelaHull$Pozicija=="G"]<- c("Vratar")
tabelaHull$Pozicija[tabelaHull$Pozicija=="D"]<- c("Branilec")
tabelaHull$Pozicija[tabelaHull$Pozicija=="M"]<- c("Sredina")
tabelaHull$Pozicija[tabelaHull$Pozicija=="A"]<- c("Napadalec")
tabelaHull$Ekipa <- c("Hull City")
tabelaHull <- tabelaHull[c(1,6,2,3,4,5)]

#Middlesbrough

htmlMiddlesbrough <- html_session("http://www.betstudy.com/soccer-stats/teams/crystal-palace/671/squad/?sid=12653") %>% read_html
htmlMiddlesbrough <- htmlMiddlesbrough %>% html_nodes("table") %>% .[[2]]
tabelaMiddlesbrough <- htmlMiddlesbrough %>% html_table()
tabelaMiddlesbrough <- tabelaMiddlesbrough[c(2,4,7,11,12)]
colnames(tabelaMiddlesbrough) <- c("Igralec","Pozicija","Nastopi","Podaje","Goli")
tabelaMiddlesbrough$Pozicija[tabelaMiddlesbrough$Pozicija=="G"]<- c("Vratar")
tabelaMiddlesbrough$Pozicija[tabelaMiddlesbrough$Pozicija=="D"]<- c("Branilec")
tabelaMiddlesbrough$Pozicija[tabelaMiddlesbrough$Pozicija=="M"]<- c("Sredina")
tabelaMiddlesbrough$Pozicija[tabelaMiddlesbrough$Pozicija=="A"]<- c("Napadalec")
tabelaMiddlesbrough$Ekipa <- c("Middlesbrough")
tabelaMiddlesbrough <- tabelaMiddlesbrough[c(1,6,2,3,4,5)]

#Sunderland

htmlSunderland <- html_session("http://www.betstudy.com/soccer-stats/teams/crystal-palace/683/squad/?sid=12653") %>% read_html
htmlSunderland <- htmlSunderland %>% html_nodes("table") %>% .[[2]]
tabelaSunderland <- htmlSunderland %>% html_table()
tabelaSunderland <- tabelaSunderland[c(2,4,7,11,12)]
colnames(tabelaSunderland) <- c("Igralec","Pozicija","Nastopi","Podaje","Goli")
tabelaSunderland$Pozicija[tabelaSunderland$Pozicija=="G"]<- c("Vratar")
tabelaSunderland$Pozicija[tabelaSunderland$Pozicija=="D"]<- c("Branilec")
tabelaSunderland$Pozicija[tabelaSunderland$Pozicija=="M"]<- c("Sredina")
tabelaSunderland$Pozicija[tabelaSunderland$Pozicija=="A"]<- c("Napadalec")
tabelaSunderland$Ekipa <- c("Sunderland")
tabelaSunderland <- tabelaSunderland[c(1,6,2,3,4,5)]

###TABELA IGRALEC

Igralec <- rbind(tabelaArsenal,tabelaBurnley,tabelaBournemouth,tabelaChelsea,tabelaCrystalPalace,
                 tabelaEverton,tabelaHull,tabelaLeicester,tabelaLiverpool,tabelaManCity,tabelaManUnited,
                 tabelaMiddlesbrough,tabelaStoke,tabelaSwansea,tabelaStoke,tabelaSouthampton,tabelaSunderland,
                 tabelaTottenaham,tabelaWatford,tabelaWestHam,tabelaWba)
Igralec$Id <- c(1:length(Igralec$Igralec))
Igralec <- Igralec[c(7,1:6)]

