require(dplyr)
require(rvest)
require(gsubfn)
require(ggplot2)

url1 <- "http://www.betstudy.com/soccer-stats/c/england/premier-league/"
link1 <- sprintf(url1)
stran1 <- html_session(link1) %>% read_html(encoding = "UTF-8")
tabela1 <- stran1 %>% html_nodes(xpath = "//table[1]") %>% .[[4]] %>% html_table()

#Chelsea
url2 <- "http://www.betstudy.com/soccer-stats/teams/chelsea/661/"
link2 <- sprintf(url2)
stran2 <- html_session(link2) %>% read_html(encoding = "UTF-8")
tabela2 <- stran2 %>% html_nodes(xpath = "//table[1]") %>% .[[4]] %>% html_table()
tabela2[,5] <- NULL
names(tabela2)[1] <- "Date"
names(tabela2)[2] <- "Home Team"
names(tabela2)[3] <- "Result"
names(tabela2)[4] <- "Foreign Team"
