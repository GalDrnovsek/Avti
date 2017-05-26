require(dplyr)
require(rvest)
require(gsubfn)
library(reshape2)
library(ggplot2)

url <- "http://www.betstudy.com/soccer-stats/c/england/premier-league/"
stran <- html_session(url) %>% read_html(encoding="UTF-8")
tab <- stran %>% html_nodes(xpath ="//table[1]") %>% .[[4]]
tabela <- tab %>% html_table()


ekipe_link <- tab %>% html_nodes(xpath=".//a") %>% html_attr("href")
url <- "http://www.betstudy.com/soccer-stats/teams/chelsea/661/squad/"
stran <- html_session(url) %>% read_html(encoding="UTF-8")
tab <- stran %>% html_nodes(xpath ="//table[1]") %>% .[[2]]
tabela3 <- tab %>% html_table()
Encoding(tabela3$Name) <- "UTF-8"
tabela3$ekipa <- "Chelsea"
for(url in ekipe_link){
  if(url!="/soccer-stats/teams/chelsea/661/"){
  url2<-paste("http://www.betstudy.com",url,sep="")
  url2<-paste(url2,"squad/",sep="")
  stran <- html_session(url2) %>% read_html(encoding="cp1250")
  tab <- stran %>% html_nodes(xpath ="//table[1]") %>% .[[2]]
  tabela2 <- tab %>% html_table()
  Encoding(tabela2$Name) <- "UTF-8"
  tabela2$ekipa <- substr(url, 21, nchar(url)-5)
  tabela3<-rbind(tabela3,tabela2)
  }
}

