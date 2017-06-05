require(dplyr)
require(rvest)
require(gsubfn)
require(reshape2)
require(ggplot2)

url3 <- "http://www.betstudy.com/soccer-stats/c/england/premier-league/"
stran3 <- html_session(url3) %>% read_html(encoding="UTF-8")
tab3 <- stran3 %>% html_nodes(xpath ="//table[1]") %>% .[[4]]
tabela3 <- tab3 %>% html_table()

ekipe_link <- tab3 %>% html_nodes(xpath=".//a") %>% html_attr("href")

url4 <- "http://www.betstudy.com/soccer-stats/teams/chelsea/661/squad/"
stran4 <- html_session(url4) %>% read_html(encoding="UTF-8")
tabela_igralcev <- stran4 %>% html_nodes(xpath ="//table[1]") %>% .[[2]] %>% html_table()
Encoding(tabela_igralcev$Name) <- "UTF-8"
tabela_igralcev$Ekipa <- "Chelsea"

for(url in ekipe_link){
  if(url != "/soccer-stats/teams/chelsea/661/"){
    url5 <- paste("http://www.betstudy.com", url, sep="")
    url5 <- paste(url5, "squad/", sep="")
    stran5 <- html_session(url5) %>% read_html(encoding="cp1250")
    tabela5 <- stran5 %>% html_nodes(xpath ="//table[1]") %>% .[[2]] %>% html_table()
    Encoding(tabela5$Name) <- "UTF-8"
    tabela5$Ekipa <- substr(url, 21, nchar(url)-5)
    tabela_igralcev <- rbind(tabela_igralcev, tabela5)
  }
}  

names(tabela_igralcev)[7] <- "Appearances"
names(tabela_igralcev)[8] <- "YCards"
names(tabela_igralcev)[9] <- "SecYCards"
names(tabela_igralcev)[10] <- "RCards"
names(tabela_igralcev)[12] <- "Goals"


url <- "http://www.betstudy.com/soccer-stats/teams/chelsea/661/transfers/"
stran <- html_session(url) %>% read_html(encoding="cp1250")
tabela_transferjev <- stran %>% html_nodes(xpath ="//table[1]") %>% .[[2]] %>% html_table()
Encoding(tabela_transferjev[,2]) <- "UTF-8"
tabela_transferjev$Ekipa <- "Chelsea"


for(url in ekipe_link){
  url <- paste("http://www.betstudy.com", url, sep="")
  url <- paste(url, "transfers/", sep="")
  stran <- html_session(url) %>% read_html(encoding="cp1250")
  tabela <- stran %>% html_nodes(xpath ="//table[1]") %>% .[[2]] %>% html_table()
  Encoding(tabela[,2]) <- "UTF-8"
  Encoding(tabela[,4]) <- "UTF-8"
  tabela$Ekipa <- substr(url, 44, nchar(url)-15)
  tabela_transferjev <- rbind(tabela_transferjev, tabela)
}




