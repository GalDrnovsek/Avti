url <- "http://www.betstudy.com/soccer-stats/teams/chelsea/661/squad/"
stran <- html_session(url) %>% read_html(encoding="UTF-8")
tab <- stran %>% html_nodes(xpath ="//table[1]") %>% .[[2]]
tabela <- tab %>% html_table()
igralci_link <- tab %>% html_nodes(xpath=".//a") %>% html_attr("href")